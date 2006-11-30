X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 08:03:52 -0800
Message-ID: <m23b80ncpj.fsf@ziti.fhcrc.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<7vd5786opj.fsf@assigned-by-dhcp.cox.net> <ekmkoe$a52$1@sea.gmane.org>
	<ekmlf4$ask$3@sea.gmane.org> <m2odqpm0d6.fsf@ziti.fhcrc.org>
	<fcaeb9bf0611300750t4adb4c97ibd65bc5b254e7efa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 16:04:11 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=PwilPDcvDJr65Ok2Ppajlgd69gSDigbk1oh+5HEI1Ha9boAvqHPCWxZqB0unWGbIRrkFmIsSM7GNK2LGfNAd1CwrSmqQgL/LflOrmVR6+ofKzk562mWCNTfy+9+hvB+JqX9n6/tLyh9F4hYNVBF4Hhz0NUItttn4OGNk6wBLG3c=
In-Reply-To: <fcaeb9bf0611300750t4adb4c97ibd65bc5b254e7efa@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Thu, 30 Nov 2006 22:50:23 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32761>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoO0-0003hr-2Q for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030639AbWK3QDl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030641AbWK3QDl
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:03:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:41853 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030639AbWK3QDk
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:03:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2155620uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 08:03:38 -0800 (PST)
Received: by 10.78.201.10 with SMTP id y10mr3695175huf.1164902618491; Thu, 30
 Nov 2006 08:03:38 -0800 (PST)
Received: from ziti.fhcrc.org ( [67.171.24.140]) by mx.google.com with ESMTP
 id 11sm26923848hug.2006.11.30.08.03.37; Thu, 30 Nov 2006 08:03:38 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 11/30/06, Seth Falcon <sethfalcon@gmail.com> wrote:
>>
>> For those using emacsclient, I don't think ^C will work.  Is there
>> another way to undu an ammend commit?  If not, is there any sense in
>> detecting a magic comment to abort the ammend commit?
>
> Uncomment to abort commit would be more intuitive.

