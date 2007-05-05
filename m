From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 5 May 2007 16:39:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705051637450.4015@racer.site>
References: <463BD40C.6080909@gmail.com>  <Pine.LNX.4.64.0705050324580.4015@racer.site>
  <7vwszolz26.fsf@assigned-by-dhcp.cox.net> <56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 17:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkMMI-00042i-H4
	for gcvg-git@gmane.org; Sat, 05 May 2007 17:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423000AbXEEPje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 11:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423190AbXEEPje
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 11:39:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:60315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423069AbXEEPjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 11:39:22 -0400
Received: (qmail invoked by alias); 05 May 2007 14:39:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 05 May 2007 16:39:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KnfAJIt8KFUih3iuukKrymZsoHvP9H+pkyxI2wb
	7uN2c9h7Qhppu0
X-X-Sender: gene099@racer.site
In-Reply-To: <56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46256>

Hi,

On Fri, 4 May 2007, Dana How wrote:

> (a) In a bare repository, I believe setup.c:setup_git_directory_gently()
> determines the prefix to be NULL.  This means my patch will see
> ALL paths as absolute,  except :../path which will result in an error.

My point was that it feels inconsistent to take the current path into 
account in one case, but not in the other.

Ciao,
Dscho
