From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH QGit 0/4] enhancements for the context menu of the Rev list
Date: Sat, 6 Jun 2009 14:14:26 +0200
Message-ID: <200906061414.27371.markus.heidelberg@web.de>
References: <1244289471-698-1-git-send-email-markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 14:15:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCuo0-0007u2-2E
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 14:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbZFFMPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 08:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbZFFMPG
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 08:15:06 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:48350 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbZFFMPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 08:15:04 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 45907FEED945;
	Sat,  6 Jun 2009 14:14:22 +0200 (CEST)
Received: from [89.59.108.98] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MCun0-0001Y7-00; Sat, 06 Jun 2009 14:14:22 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1244289471-698-1-git-send-email-markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/90QPc5KA2xRAq/lzckQbPeb8fWhFeyoRTtoBw
	5ce+nt/m2Ty3Fb4+64Kf+FILRFdhdB+5WmVnSp6OVpn0DtWq5a
	E7+ZP9OcmHRZHWXGSG5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120914>

Markus Heidelberg, 06.06.2009:
> Markus Heidelberg (4):
>   Don't count the submenu entries for checking if it is empty
>   Correctly count the entries in the revs context menu
>   Avoid submenus with merely 1 entry
>   Create a separate submenu for tags

Hmm, no In-Reply-To in 1..4/4

I think I managed to do this earlier with just
  $ git format-patch -4 -s
  $ git send-email 000*

But not even
  $ git send-email --thread 000*
seems to work.

Only 
  $ git format-patch -4 -s --thread
  $ git send-email 000*
