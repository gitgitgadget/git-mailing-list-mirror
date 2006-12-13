X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit repo & gitweb, was Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Wed, 13 Dec 2006 22:09:06 +0000
Message-ID: <b0943d9e0612131409x4a894f72if9c4d44cfa970be@mail.gmail.com>
References: <20061207101707.GA19139@spearce.org>
	 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 22:09:27 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nCWmcHL/YQUDyqQh/KlkYR93Y7SipMQNTm30jrgiLp56GH5beGQNZp5EVo/aYSVwonGQf2V2R+J8x2Rkf1mMsCckCLZjQLGe/JK1mIIGia4XOMduigZJ6BUxTnT3riYJK1ThzLH1yh9mNY1KP6Yji/ytrSbT7PeWD89dnqw2Ikc=
In-Reply-To: <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34237>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucHq-0006Kq-1L for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751189AbWLMWJK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWLMWJK
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:09:10 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:31370 "EHLO
 nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751189AbWLMWJI (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 17:09:08 -0500
Received: by nz-out-0506.google.com with SMTP id s1so161790nze for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 14:09:06 -0800 (PST)
Received: by 10.65.251.1 with SMTP id d1mr180537qbs.1166047746404; Wed, 13
 Dec 2006 14:09:06 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Wed, 13 Dec 2006 14:09:06 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 13/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 12 Dec 2006, Junio C Hamano wrote:
>
> > Although I would feel very happy about this change, Catalin
> > might want to be informed about potential interaction this
> > change might have with his commit 8d41555 in StGIT.
>
> Indeed. Catalin, do you have any suggestion how to proceed? Do you want to
> introduce a check if the file exists prior to re-generating it? Or do you
> need some version check?

It currently checks whether the file exists and, if it doesn't, it is
re-generated. I think the patch is good idea.

> BTW why is StGit not on kernel.org?

Why would it be? Unless you know who to talk to for this :-), it's not
really a derivative of the Linux kernel.

> Not that it matters: repo.or.cz has a nice mirror. Pasky, how powerful is
> that machine? I am a happy user of the gitweb interface on that box...

Hopefully, when I get a bit of time, I'll try to give up the
http-hosted repository and use Pasky's one exclusively.

BTW, how can I notify people that only pull from the http repository
that it will no longer be updated (rather than them thinking the
development stopped)? One solution would be to create a file with a
meaningful name in the top dir and hope people will notice it.

-- 
