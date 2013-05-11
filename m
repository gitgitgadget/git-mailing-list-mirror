From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: Outdated and broken online versions of user-manual.html
Date: Sat, 11 May 2013 17:00:55 +0200 (CEST)
Message-ID: <407109112.1476124.1368284455898.JavaMail.ngmail@webmail17.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: philipoakley@iee.org, git@vger.kernel.org, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sat May 11 17:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbBIF-0008Ec-0r
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 17:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab3EKPA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 11:00:58 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:52542 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752995Ab3EKPA5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 11:00:57 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id EBF8035A324;
	Sat, 11 May 2013 17:00:55 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id E808A3F83CC;
	Sat, 11 May 2013 17:00:55 +0200 (CEST)
Received: from webmail17.arcor-online.net (webmail17.arcor-online.net [151.189.8.75])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id DFDE2197A97;
	Sat, 11 May 2013 17:00:55 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net DFDE2197A97
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1368284455; bh=la7/HBck8OAzm0Coqfge/aaSgS+1rAnAV0sRUiMPqsY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=puajUqGFyMlmWRogQ+u5uYhmjJNs3Fu/T2qOdQF4YefchQR4f2igIgqRi3g0cESsP
	 mSvyj2tunCS2KDvdhYRzswLCGv3+ymgqgN2LemDw6WEEOVmeUd1JeGLQE/UvItNJ66
	 99vW137a8wrbXnNqCZb6pbE53Huo5uuPw8Q8U2pM=
Received: from [94.217.22.251] by webmail17.arcor-online.net (151.189.8.75) with HTTP (Arcor Webmail); Sat, 11 May 2013 17:00:55 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.22.251
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223973>

 
> > (1) Very poor html formatting (document type "book" causes
> > ugly TOCs per section and there's a "Part I" without a "Part II")
> > (2) Partly outdated content
> > (3) Sub-optimal structuring (to-do list as part of the document,
> > glossary not at the end of the document)
> > (4) User-manual.PDF uses an independent tool chain which makes it
> > harder to do improvements for user-manual.html and also is the only
> > pdf doc we are creating. IMHO we should remove this altogether.
> > (5) Large overlapping with the tutorials. IMHO all of the
> > tutorials should be blended into user-manual

> I'd welcome the provision of a 'man'/'html' formatted version of the two 
> guides. Are you expecting to make then compatible with the man format?
>
This is another topic on my to-do list ...
 
> I would be a little cautious of your point 5 if it squoze everything 
> into one overlong document at the expense of losing the shorter 
> documents - one can't eat a whole melon in one bite ;-) That said there 
> is a significant opportunity for rationalisation and clarity 
> improvement, even if it is only a proper realisation of where we 
> deliberately duplicate information for ease of user learning.
> 
I did not have a closer look on this but just from reading the documents
I got the impression that the tutorials are already more or less contained
in the user-manual and by a little restructuring the melon will fall into handy pieces ;-)

> I also liked the idea of all the documenation being collated into one 
> Humongous pdf as a reference (there was a patch a while back - don't 
> have a reference right now).
>
Thanks :-) My patches were rejected but (4) shows that now I know why ;-)
Nevertheless I maintain this in https://github.com/tacker66/git.git and provide
the documents for every major version of Git in https://github.com/tacker66/git-docpdf.git.
(4) is also the reason why I stopped using the pdf target and instead create user-manual.pdf
with wkhtmltopdf from user-manual.html.
Additionally I use Amazons kindlegen to create mobi version from the html documents
which look quite good on a Kindle.


---
Thomas
