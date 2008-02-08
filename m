From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH (try 2)] git-svn: fix "Malformed network data" with
	svn:// servers
Date: Fri, 8 Feb 2008 16:24:33 +0000
Message-ID: <20080208162433.25929.qmail@dd8a37fc58824d.315fe32.mid.smarden.org>
References: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org> <20070704210526.GA9582@muzzle> <20070807134220.23420.qmail@c96e4a6cce1e57.315fe32.mid.smarden.org> <20070907073424.GA16468@mayonaise> <20070907100711.GA24166@muzzle> <20070907110040.GA9369@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 17:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNW1z-0004aZ-8K
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbYBHQYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbYBHQYS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:24:18 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:35685 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754522AbYBHQYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:24:17 -0500
Received: (qmail 25930 invoked by uid 1000); 8 Feb 2008 16:24:33 -0000
Content-Disposition: inline
In-Reply-To: <20070907110040.GA9369@mayonaise>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73105>

On Fri, Sep 07, 2007 at 04:00:40AM -0700, Eric Wong wrote:
> We have a workaround for the reparent function not working
> correctly on the SVN native protocol servers.  This workaround
> opens a new connection (SVN::Ra object) to the new
> URL/directory.

Hi, this problem popped up again, please see
 http://bugs.debian.org/464713
 
I can reproduce it with v1.5.4 through

 $ git svn clone svn://svn.debian.org/chinese/packages/lunar-applet
 [...]
 r159 = 010d0b481753bd32ce0255ce433d63e14114d3b6 (git-svn@159)
 Found branch parent: (git-svn) 010d0b481753bd32ce0255ce433d63e14114d3b6
 Following parent with do_switch
 Malformed network data: Malformed network data at /usr/bin/git-svn line
 2251

 $ 

Regards, Gerrit.
