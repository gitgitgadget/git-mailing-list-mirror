From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Fri, 7 Mar 2008 10:10:08 +1100
Message-ID: <18384.31184.663885.595827@cargo.ozlabs.ibm.com>
References: <47AAA254.2020008@thorn.ws>
	<20080207063020.GP24004@spearce.org>
	<200802071056.19370.robin.rosenberg.lists@dewire.com>
	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	<18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	<47C190E3.6000407@gmail.com>
	<18383.57540.26282.526111@cargo.ozlabs.ibm.com>
	<57518fd10803060459m6e3ffc00n388721ad2e5975ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Mark Levedahl" <mlevedahl@gmail.com>,
	"Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:10:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXPEm-0003XM-Bt
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 00:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758427AbYCFXKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 18:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbYCFXKR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 18:10:17 -0500
Received: from ozlabs.org ([203.10.76.45]:55221 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbYCFXKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 18:10:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3E6C4DDF48; Fri,  7 Mar 2008 10:10:14 +1100 (EST)
In-Reply-To: <57518fd10803060459m6e3ffc00n388721ad2e5975ad@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76434>

Jonathan del Strother writes:

> This almost works on OS X.  The only problem is that it's not taking
> into account menubars and windowbars.  eg, if I have a screen
> resolution of 640x480, setting the window _content_ to that size will
> make the entire window including its titlebar about 500px tall.  Not
> only that, but the system-wide menubar at the top of the screen also
> reduces the available space, meaning that the maximum window size
> ought to be around 640x456.  (If you wanted to get even pickier, that
> will changing depending on the interface resolution...)

Do you know of any way for an application to determine how big it can
be, then?

> Presumably your patch does nothing to move gitk back on screen if the
> monitor it was on last time has gone away?  Or are we still blaming
> the window manager for that?

With the patch it no longer specifies a position, so yes we blame the
window manager now if it doesn't put the window somewhere visible. :)

Paul.
