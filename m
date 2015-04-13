From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] gitweb: Update logo and favicon
Date: Mon, 13 Apr 2015 10:52:48 +0100
Message-ID: <alpine.LSU.2.00.1504131033420.23307@hermes-1.csi.cam.ac.uk>
References: <1428882040-13938-1-git-send-email-thosch97@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jason Long <jason@jasonlong.me>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Schneider <thosch97@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 11:52:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhb31-0003ZS-W4
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 11:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbbDMJwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 05:52:51 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:39642 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbbDMJwu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 05:52:50 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:42631)
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Yhb2u-0003vZ-2y (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 13 Apr 2015 10:52:48 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Yhb2u-0005iR-Sh (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 13 Apr 2015 10:52:48 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <1428882040-13938-1-git-send-email-thosch97@gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267072>

Thomas Schneider <thosch97@gmail.com> wrote:

> The new images were downloaded from https://git-scm.herokuapp.com/downloads/logos
> and converted with ImageMagick:
>   convert -resize 72x30 Git-Logo-2Color.eps git-logo.png
>   convert -resize 16x16 Git-Icon-1788C.eps git-favicon.png
> The old logo was only 27 pixels in height, the 3 additional pixels are necessary
> for the slightly different aspect ratio of the new one.

This is a good improvement :-) I did something similar for the logos on my
installation of gitweb, including exactly the same command to create the
favicon.

https://git.csx.cam.ac.uk/x/ucs/git/gitcam.git/blob/HEAD:/bin/make-icons.sh

I think it is a bad idea to change the height of the logo: gitweb
generates an <img src> element with a fixed 72x27 size, and the
gitweb.conf documentation suggests that site admins can replace the logo
with a custom one of the same size. My version of the new logo includes a
bit of horizontal padding so that it matches this specification.

(The higher-resolution icons are used by my server's documentation pages
but not by gitweb.)

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Humber, Thames: Northwest backing south or southwest later, 4 or 5,
occasionally 6 later. Slight or moderate. Fair. Moderate or good.
