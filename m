From: Brian Dessent <brian@dessent.net>
Subject: Re: git-gui not working in a non-default Cygwin installation.
Date: Sun, 17 Feb 2008 05:39:55 -0800
Organization: My own little world...
Message-ID: <47B8392B.4D90DFD1@dessent.net>
References: <fp5fdj$5fi$1@ger.gmane.org> <20080217080255.GQ24004@spearce.org> <fp95jr$r08$1@ger.gmane.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jurko Gospodneti? <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Sun Feb 17 14:41:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQjlI-0002FJ-Nc
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 14:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbYBQNkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 08:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbYBQNkA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 08:40:00 -0500
Received: from dessent.net ([69.60.119.225]:45756 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756206AbYBQNkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 08:40:00 -0500
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1JQjkK-0000ZI-Df; Sun, 17 Feb 2008 13:39:56 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74130>

Jurko Gospodneti? wrote:

>    Sorry, I seem to be a bit confused about this... Why does cygwin not
> support Tcl/Tk above version 8.4.1?
> 
>    What about the information found on
> http://opencircuitdesign.com/cygwin under 'Tcl-Cygwin binary
> distribution download and install:'? It lists some additional downloads
> that may be used to install the latest Tcl/Tk on cygwin... Why is this
> not included in the regular Cygwin distribution (setup.exe)?

The Cygwin tcl/tk package exists primarily to support the Insight
debugger which uses its own bundled in-tree copy of tcl + tk + itcl +
itk.  If someone were to hack on Insight to decouple it, then it might
be possible to ship a different/newer version, but not until then.

Brian
