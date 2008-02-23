From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Sun, 24 Feb 2008 09:49:50 +1100
Message-ID: <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
References: <47AAA254.2020008@thorn.ws>
	<20080207063020.GP24004@spearce.org>
	<200802071056.19370.robin.rosenberg.lists@dewire.com>
	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT3sy-00054P-43
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbYBWXdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbYBWXdh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:33:37 -0500
Received: from ozlabs.org ([203.10.76.45]:39030 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbYBWXdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:33:36 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0C00EDDDF3; Sun, 24 Feb 2008 10:33:35 +1100 (EST)
In-Reply-To: <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74881>

Gerrit Pape writes:

> Saving the geometry can cause several inconveniences, e.g. when using a
> temporary dual screen setup, or sharing ~/.gitk between multiple
> systems.  Additionally it can be argued that window placement and sizing
> are the tasks of the window manager.  So don't do that anymore.

I myself find it useful to have gitk remember the size and layout of
the various panes, so I won't be applying this patch.

The saving/restoring of the window position was done by Mark Levedahl
to make gitk work properly on Cygwin.  I agree it can be annoying on X
and I would take a patch to inhibit the restoring of the window
position when running under X.  I'd want an ack from Mark before
making that change more generally.

Paul.
