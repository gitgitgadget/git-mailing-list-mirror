From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: git clone problem through HTTP
Date: Fri, 20 Apr 2007 06:01:18 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27EA8476@az33exm24.fsl.freescale.net>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com> <Pine.LNX.4.64.0704201245330.10595@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 15:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeskA-0002r4-CG
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 15:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992739AbXDTNBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 09:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992741AbXDTNBX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 09:01:23 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:37521 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992739AbXDTNBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 09:01:22 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id l3KD1Jm8014324
	for <git@vger.kernel.org>; Fri, 20 Apr 2007 06:01:20 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l3KD1J0k015659
	for <git@vger.kernel.org>; Fri, 20 Apr 2007 08:01:19 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0704201245330.10595@reaper.quantumfyre.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git clone problem through HTTP
Thread-Index: AceDQdvA++ylsMQATi2FXRbt29bJBwACbpIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45099>

Hi Aubery,


If you have a SOCKS server somewhere you could use socksify to get a
clone with the git native protocol.


Cheers,
Emil.


-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Julian Phillips
Sent: Friday, April 20, 2007 6:48 AM
To: Aubrey Li
Cc: git@vger.kernel.org
Subject: Re: git clone problem through HTTP

On Fri, 20 Apr 2007, Aubrey Li wrote:

> I'm behind of a firewall on which the git port is not permitted, so I
> can only use http protocol. Unfortunately, I can't clone linus' git
> tree at all.

Linus packs his refs, which means that currently you can't clone using 
http, with any version of git.

Try http://repo.or.cz/r/linux-2.6.git/ instead?  This appears to be a 
straight clone, but without packed refs.

-- 
Julian

  ---
Go out and tell a lie that will make the whole family proud of you.
 		-- Cadmus, to Pentheus, in "The Bacchae" by Euripides
