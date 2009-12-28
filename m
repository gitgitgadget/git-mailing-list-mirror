From: David Aguilar <davvid@gmail.com>
Subject: Re: file in new branch also shown in master branch?
Date: Mon, 28 Dec 2009 15:25:54 -0800
Message-ID: <20091228232539.GA16146@gmail.com>
References: <92c9564e0912281437g20fe51f9ta33383791ef20385@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Carlos Santana <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 00:26:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPOyc-0001AF-2M
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 00:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZL1X0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 18:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbZL1X0I
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 18:26:08 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:36975 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZL1X0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 18:26:07 -0500
Received: by yxe17 with SMTP id 17so9687237yxe.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dHGVEiexlkWBmEKlQOOyGiMMa6K2AooLfAnzLbgSgJw=;
        b=Sz+jCaxcDzm9n1Xl1tJq00PN4Ug3Fy+KIejvCcE10GkX8POoCQRGmfEj6b26FknlFs
         nwOveXKBKxPvPBmaXfVPNbQflrtkZ4wL0Wby1fMR8jnv5j1CRJPwAnoo/m6RPS1pGUT0
         lQZfK1bPs7TzTrPsl0YJKU5ggJIsgbrw3ml+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gsDWG/uxWNWQpkN40efPC9RGXANjHrs+zOFJbiFZQ8CRq1pUlajK68VY+BCciVbbie
         mcNjyC1EqtFtBMhJeA6vhLYCWelcz9k/QtXLKmQwk8Yry6dgA9w2FBhVnA0jhNpzg6/J
         4JthGhsmN/CM/VIfTlTCuxF8s6sCKILg/PoJ8=
Received: by 10.101.147.27 with SMTP id z27mr5858354ann.22.1262042761644;
        Mon, 28 Dec 2009 15:26:01 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 21sm4874425yxe.1.2009.12.28.15.26.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 15:26:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <92c9564e0912281437g20fe51f9ta33383791ef20385@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135772>

On Mon, Dec 28, 2009 at 04:37:08PM -0600, Carlos Santana wrote:
> Hi,
> 
> I tried following commands to test branching:
> 
> git branch test
> git checkout test

1. You are now on branch "test"

> echo "Test branch" >> testfile
> git status

2. This does nothing as far as git is concerned.
   "testfile" is still unknown to git.

> git checkout master

3. You are now on branch "master"

> git add .
> git commit

4. You just committed "testfile" to branch "master".
   Recall #3.  This may be where your confusion began.

> The 'testfile' file shows up in 'master' as well as 'test'. I thought

Nope, it only shows up in master.

try:
    git checkout test

It is gone.


> or am I missing something? I was unable to repeat same behavior again,
> so I am confused now. Any clues?

These are great references:

http://book.git-scm.com/3_basic_branching_and_merging.html
http://progit.org/book/ch3-0.html


Have fun,

-- 
		David
