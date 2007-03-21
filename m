From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 14:50:04 +0300
Message-ID: <20070321115004.GB14837@codelabs.ru>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org> <20070321051406.GW96806@codelabs.ru> <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 21 12:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTzKe-0004Q8-Jo
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 12:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbXCULuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 07:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbXCULuP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 07:50:15 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:50548 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbXCULuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 07:50:14 -0400
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HTzKT-0004B6-Bi; Wed, 21 Mar 2007 14:50:09 +0300
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42787>

Johannes, good day.

Wed, Mar 21, 2007 at 12:16:40PM +0100, Johannes Schindelin wrote:
> > Will try to implement. But still, NO_GUI should ban the GUI tools from 
> > being built and installed, because user can have the Tcl/Tk available, 
> > but have no intention to use the git GUI. Am I right?
> 
> I am not quite certain if I agree. With a similar reasoning, you could 
> introduce a flag to prevent pull-request from being installed, and 
> git-tag, or other rarely used functions. Is it so bad to have gitk and 
> git-gui installed?

I am happening to develop on some machines on which I have no
X-Windows or any GUI providers at all, so I prefer not to have the
Tcl/Tk dependency at all. Once again, the patch was originally done
for the FreeBSD where the port system installs the dependencies
automatically. And I do not need the Tcl/Tk on some machines: imagine
the server that uses Git for its configuration tracking. It is
server, there is absolutely no need for any GUIs there. And one of
my developing machines has no X-Windows, so Tcl/Tk is again useless.
This is the reasons for the NO_GUI knob. As it is turned off by
default it does not breaks the expectations of the users who are
used to the git GUI tools.

> I mean, you are likely to just try them (and possibly 
> like them!) at some stage, because the graphical representation is so much 
> clearer than what _any_ text representation can do.

Yes, sometimes I use the graphical representation. But there are
use-cases when no GUI is needed at all.
-- 
Eygene
