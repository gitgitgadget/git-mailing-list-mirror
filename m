From: David Kastrup <dak@gnu.org>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 15 Aug 2007 07:30:19 +0200
Message-ID: <85fy2l1i1g.fsf@lola.goethe.zz>
References: <f99cem$4a4$1@sea.gmane.org>
	<30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
	<Pine.LNX.4.64.0708081810130.14781@racer.site>
	<75EB313E-807D-44FB-A186-A151F182B47B@zib.de>
	<Pine.LNX.4.64.0708082228520.21857@racer.site>
	<76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
	<e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
	<2383328F-300E-459C-A299-90242DA230F7@zib.de>
	<e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
	<EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
	<e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com>
	<30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torgil Svensson <torgil.svensson@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 07:30:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILBSd-0002zM-Mx
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 07:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbXHOFaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 01:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbXHOFaY
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 01:30:24 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:49899 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268AbXHOFaX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 01:30:23 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id A306017F486;
	Wed, 15 Aug 2007 07:30:21 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 940C0ABE0E;
	Wed, 15 Aug 2007 07:30:21 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-014-216.pools.arcor-ip.net [84.61.14.216])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 70B4031276F;
	Wed, 15 Aug 2007 07:30:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 5DE511C3D500; Wed, 15 Aug 2007 07:30:20 +0200 (CEST)
In-Reply-To: <30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de> (Steffen Prohaska's message of "Wed\, 15 Aug 2007 07\:22\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3959/Wed Aug 15 06:33:29 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55878>

Steffen Prohaska <prohaska@zib.de> writes:

> Author: Johannes Schmidt-Ehrenberg <schmidt-ehrenberg@zib.de>
> Date:   Mon Aug 13 19:00:39 2007 +0200
>
>     mergetool: fixed parsing of registry entry for kdiff3
>
>     The old code failed on Windows Vista. The output of
>     reg.exe or something else may be a bit different.
>     This patch improves the parsing code to be more robust.

I seem to remember that you can't rely on reg.exe being available on
Windows.  The Microsoft support pages talk about using regedit.exe
instead (which is quite more cumbersome).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
