From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 08:14:06 +0300
Message-ID: <20070321051406.GW96806@codelabs.ru>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 06:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTt9W-0003Kd-S9
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 06:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbXCUFOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 01:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbXCUFOO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 01:14:14 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:62451 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbXCUFON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 01:14:13 -0400
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HTt9H-0003EX-B1; Wed, 21 Mar 2007 08:14:11 +0300
Content-Disposition: inline
In-Reply-To: <etpuen$2uo$2@sea.gmane.org>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42779>

Jakub, good day.

Wed, Mar 21, 2007 at 01:35:22AM +0100, Jakub Narebski wrote:
> Eygene Ryabinkin wrote:
> 
> > NO_GUI disables the building and installation of the git GUI part.
> 
> By the way, it would be nice for ./configure script (generated from
> configure.ac) to detect if Tcl/Tk is available and disable
> git-gui and gitk installation if it is not found.

Will try to implement. But still, NO_GUI should ban the GUI tools
from being built and installed, because user can have the Tcl/Tk
available, but have no intention to use the git GUI. Am I right?
-- 
Eygene
