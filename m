X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 09:53:25 +0100
Message-ID: <200611030853.26467.andyparkins@gmail.com>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061103074857.GA15972@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 08:53:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c000IFMrx96yziQtBNRu2U7h7dhgLYkwW5tuENNh/0ciE1p+S7TQWt2LKjIIlr3/z9KKn23eeQtfcO9F67RYOCIAUPp4phhCqn4yFNG9QoHFQwWKFYTQyKlIsuBqAhjzK0RoSdV3iQPfrc1861bTv8fPTePBuXtf0V59wbKLAsE=
User-Agent: KMail/1.9.5
In-Reply-To: <20061103074857.GA15972@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30800>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfunv-0005YY-1q for gcvg-git@gmane.org; Fri, 03 Nov
 2006 09:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752362AbWKCIxc convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 03:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbWKCIxc
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 03:53:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:20497 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752343AbWKCIxb
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 03:53:31 -0500
Received: by ug-out-1314.google.com with SMTP id m3so352120ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 00:53:30 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr2287492ugm.1162544010292; Fri, 03
 Nov 2006 00:53:30 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id b23sm615416ugd.2006.11.03.00.53.29; Fri, 03 Nov 2006 00:53:29 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 07:48, Karl Hasselstr=F6m wrote:

> Hmm, this is interesting. 99% of the time, I use "git fetch", followe=
d
> by "git pull . remotes/origin/foo" (often having run gitk in between

I often do this too; and have found that the "remotes" is not needed pr=
ovided=20
there is no overlap with your local branch names.  The above can be rep=
laced=20
with

  git pull . origin/foo

This relies on there being no "origin/foo" local branch.


Andy
--=20
Dr Andy Parkins, M Eng (hons), MIEE
