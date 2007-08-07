From: Gerrit Pape <pape@smarden.org>
Subject: git-svn: "Malformed network data" issue
Date: Tue, 7 Aug 2007 13:42:20 +0000
Message-ID: <20070807134220.23420.qmail@c96e4a6cce1e57.315fe32.mid.smarden.org>
References: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org> <20070704210526.GA9582@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 15:42:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIPK3-0004W5-TD
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 15:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241AbXHGNmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 09:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759459AbXHGNmD
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 09:42:03 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:46898 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1758310AbXHGNmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 09:42:01 -0400
Received: (qmail 23421 invoked by uid 1000); 7 Aug 2007 13:42:20 -0000
Mail-Followup-To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20070704210526.GA9582@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55256>

On Wed, Jul 04, 2007 at 02:07:42PM -0700, Eric Wong wrote:
>   Although this fixes blocking reads, this does *not* fix the
>   "Malformed network data" issue, which has been around for a
>   while...
> 
>   I'll try to find time to fix the "Malformed network data" bug
>   in a few days time, but it's not fatal (just restart git-svn,
>   this error happens at a point where it's not possible to have
>   a corrupted import).

Hi, this still is a problem we face on Debian with 1.5.3-rc3
 http://bugs.debian.org/436142
 http://bugs.debian.org/430091

I'm sorry, I didn't manage to provide a patch.

Thanks, Gerrit.
