From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: MinGW binary installer available
Date: Wed, 07 Feb 2007 15:38:40 +0100
Message-ID: <45C9E470.7030609@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jan Nieuwenhuizen <janneke@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 15:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEnwU-0008Gd-Qm
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 15:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965632AbXBGOif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 09:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161323AbXBGOif
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 09:38:35 -0500
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:4238 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161336AbXBGOie (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 09:38:34 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id l17EcTih038170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Feb 2007 15:38:30 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38925>

Hi, 

I had a try to see whether I could make GUB
also produce a MinGW installer for Git.

You can download the result at 

http://lilypond.org/mingit/mingit-1.4.9993-1.mingw.exe

the odd version number was because I was too lazy to write code
to extract the version number from the repository automatically.

I don't actually have a windows copy, so it's basically untested.
However, I did succeed in running rev-list in wine.


PS. I'd be interested in comments on using GUB from others.
GUB is a cross-compiling build tool, probably best described
as a "Poor Man's Conary".
 
Once I have the boilerplate code committed, building this 
installer should amount to  

  darcs get  http://lilypond.org/vc/gub.darcs/ gub
  cd gub
  make -f Makefile.mingit bootstrap mingw

(yes, GUB itself is still hosted in Darcs. Shoot me.)


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
