From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: reverting a file or files back to repository copy
Date: Sat, 2 May 2009 17:33:07 +0200
Message-ID: <200905021733.08557.markus.heidelberg@web.de>
References: <137A749092D040488A7F25B4CA5ED1DC@HPLAPTOP> <eaa105840905020825v561f610dj99b1b00581bf1b3d@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Aaron Gray <aaronngray.lists@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Sat May 02 17:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0HDH-0001Qu-Hr
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 17:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbZEBPdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 11:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbZEBPdG
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 11:33:06 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:32998 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZEBPdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 11:33:05 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 334E3FBA8910;
	Sat,  2 May 2009 17:33:03 +0200 (CEST)
Received: from [89.59.107.122] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M0HD5-0005Js-00; Sat, 02 May 2009 17:33:03 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <eaa105840905020825v561f610dj99b1b00581bf1b3d@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18iEDD3MMMfwL6vqAiBQCOmC9JT6Wf53L9GFGug
	O1Frgz5oeI0RyqI9gtqYXkPOZHyUT/Rc5o5JkjM21jL0uDMiwx
	pYnY9hoKuBUihOVWaorw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118137>

Peter Harris, 02.05.2009:
> On Sat, May 2, 2009 at 10:54 AM, Aaron Gray wrote:
> > How do I do the eqivalent of an 'svn revert' on a single file, on a
> > directory of files, or on all files ?
> 
> git checkout <files>

This will use the state of the files from the index.
To revert to the latest commit, i.e. discard all your local changes of
particular files, use

    git checkout HEAD -- <files>

Markus
