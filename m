X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 10:42:08 +0000
Message-ID: <200612141042.09453.andyparkins@gmail.com>
References: <200612132200.41420.andyparkins@gmail.com> <200612140908.36952.andyparkins@gmail.com> <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 10:42:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QwcNeuQb31aOE5kFqORELpXLFnmHmBQkvvcTkdioy9oVW1UIOA6XeFvJ2SXPnfCZplIvGXtUJcW6GoY8M8QBKohfXOt1g+F+iq5FU1WTX+eK7kKVj9y2hwdc/r3TR69iNuMpqS0g4wyv9+ZEU/Dt1lzAh+wBQupG0Jlx/cxv7M4=
User-Agent: KMail/1.9.5
In-Reply-To: <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34306>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guo2f-0007vt-7x for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751941AbWLNKmS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWLNKmS
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:42:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:19303 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751941AbWLNKmS (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 05:42:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so455136uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 02:42:16 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr1200966ugm.1166092936420; Thu, 14
 Dec 2006 02:42:16 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id k2sm1864278ugf.2006.12.14.02.42.12; Thu, 14 Dec 2006 02:42:14 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 09:44, Junio C Hamano wrote:

> I would say pretending as if cat-file is a Porcelain is the
> unfair part.

I had to; there is no other equivalent of "svn cat" in git.

> Again, mistaking ls-tree as if it was a Porcelain is the true
> cause of the newbie confusion.

Again, there is no other equivalent of "svn list" in git.

> If a Porcelain level "ls" is needed (and I am doubtful about
> usefulness of "svn list -r538" like command), that is the

Me too.  I was in no way advocating that git should try to be SVN (shudder).  
As I was comparing though, I had to pick git commands that did at least what 
SVN could do.

> command you would want to teach about using ls-files and ls-tree
> depending on what the end users want in their workflow.

Personally, I think qgit fills an awfully big hole in svn that makes them all 
irrelevant.  qgit is a much better repository browsing tool than "svn list" 
is.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
