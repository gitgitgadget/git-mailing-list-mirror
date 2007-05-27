From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 03:56:18 -0300
Message-ID: <46592B92.9060403@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <Pine.LNX.4.64.0705251113280.4648@racer.site> <46588DA4.5020109@xs4all.nl> <Pine.LNX.4.64.0705262311380.4648@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 27 08:58:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsCi5-0000b6-B9
	for gcvg-git@gmane.org; Sun, 27 May 2007 08:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbXE0G6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 02:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbXE0G6X
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 02:58:23 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:1856 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbXE0G6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 02:58:23 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4R6wGkx031413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 08:58:18 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0705262311380.4648@racer.site>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48522>

Johannes Schindelin escreveu:

> I recently compiled tcl and tk from scratch on MinGW. (No cross-compile.) 
> Worked out of the box:
> 
> 	http://prdownloads.sourceforge.net/tcl/tcl8.4.14-src.tar.gz
> 	http://prdownloads.sourceforge.net/tcl/tk8.4.14-src.tar.gz
>       

GCC barfs on:

      ((Tcl_Obj **) objv) += (async + 3);




-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
