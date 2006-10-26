X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: (unknown)
Date: Thu, 26 Oct 2006 08:14:04 +0100
Message-ID: <200610260814.05957.andyparkins@gmail.com>
References: <E1Gck2K-0003H4-00@dvr.360vision.com> <7v1wowm46j.fsf@assigned-by-dhcp.cox.net> <7vwt6okpgr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 07:14:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CQe6RddClsVvcQstwnGhjY5QLYUe1NctJLAv7ZiDVZ04Hiy/QCuHgeWni7lzhAHH0lAf7n9WH4IwTQHHG5cLo5KLpC3VeEXPuOBA1RelrcSbtRjfkTjc8FlhrB8FjUPZD3YVYFybJLU+42ztSX3vVQeKYIiQuJ1bW925aX7KwXA=
User-Agent: KMail/1.9.5
In-Reply-To: <7vwt6okpgr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30143>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GczRP-0005qe-IO for gcvg-git@gmane.org; Thu, 26 Oct
 2006 09:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751758AbWJZHOM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 03:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWJZHOM
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 03:14:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:45531 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751759AbWJZHOL
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 03:14:11 -0400
Received: by ug-out-1314.google.com with SMTP id 32so298556ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 00:14:10 -0700 (PDT)
Received: by 10.66.232.10 with SMTP id e10mr2283387ugh; Thu, 26 Oct 2006
 00:14:10 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 53sm29314ugd.2006.10.26.00.14.09; Thu, 26 Oct 2006 00:14:09 -0700
 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


> > "git log remotes/origin..master" perhaps?
> >
> > The point being, remotes/origin when origin is a directory that
> > has HEAD that points at something, it stands for
> > remotes/origin/HEAD.
>
> Heh, I spoke too fast.
>
> 	"git log origin..master"
>
> If you do not have none of .git/origin, .git/refs/origin,
> .git/refs/tags/origin, .git/refs/heads/origin, nor
> .git/refs/remotes/origin, then .git/refs/remotes/origin/HEAD is
> what "origin" means (see get_sha1_basic() in sha1_name.c).

Again: you guys have thought of everything.

I believe then, that my problem is that I didn't find this written anywhere - 
would it be useful if I were to write a Documentation/ file about 
commit-ish/tree-ish that covered these issues?  Have I overlooked the 
existence of such a file already?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
