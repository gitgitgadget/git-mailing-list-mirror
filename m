X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 21:02:42 +0000
Message-ID: <200612142102.45724.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612141021.12637.andyparkins@gmail.com> <Pine.LNX.4.64.0612141221300.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 21:05:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S8m7HUfnOYmpo4iN0sv4YO5HpmGoHXBsQiJUE4P95Z95zVvEH8wKUsonAXUe11qnrdEpP5bhDkJ96nMeJ/WsQFmVKJWqj/pdgF9Lkj542y4JtfWBJ74NHrvGzxpTYBVB/JYH4hhqZmCYLQlr8RsRWtaI77TFf6V43iKY9UFMWEo=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612141221300.18171@xanadu.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34400>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guxlk-0007cJ-Mh for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932900AbWLNVF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWLNVF3
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:05:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:60747 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932900AbWLNVF2 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 16:05:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so618232uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 13:05:27 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr2122026ugl.1166130327305; Thu, 14
 Dec 2006 13:05:27 -0800 (PST)
Received: from ?192.168.1.48? ( [84.201.153.164]) by mx.google.com with ESMTP
 id 55sm3115613ugq.2006.12.14.13.05.26; Thu, 14 Dec 2006 13:05:26 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006, December 14 17:23, Nicolas Pitre wrote:

> Well, people are used to say they've "reverted" a change.  Although the
> command might appear slightly misnamed wrt its operation, it still does
> what most people are expecting from such a name.

Actually , not only is git-revert misnamed, it doesn't match up with most 
other SCMs.

"svn revert" is git-reset.
"bzr revert" is git-reset.
"darcs revert" is git-reset.
"hg revert" is git-reset.
"svk revert" is git-reset.
"monotone revert" is git-reset.

Most people must surely be expecting it to do what it does in every other SCM; 
as it doesn't my argument is that we should just drop the name "revert" and 
call it git-invert instead, which is more accurately named and doesn't 
conflict with the standard meaning.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
