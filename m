From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] gitweb: Avoid overflowing page body frame with large
 images
Date: Fri, 7 Feb 2014 15:02:04 +0000
Message-ID: <alpine.LSU.2.00.1402071458040.15645@hermes-1.csi.cam.ac.uk>
References: <2452A253-A926-4A40-9F08-6E28EFF229F3@kellerfarm.com> <CAAH6HY92SGAjMMcrw_HwA_Uh_3=AWFFF9K9WAnNAPcyUpDkbwQ@mail.gmail.com> <85BCA9A4-5EC3-4488-A4E4-4F86739B6450@kellerfarm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	Git List <git@vger.kernel.org>,
	Krzesimir Nowak <krzesimir@endocode.com>,
	=?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 16:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBnF9-0002yz-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 16:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbaBGPVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 10:21:18 -0500
Received: from ppsw-42.csi.cam.ac.uk ([131.111.8.142]:47762 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbaBGPVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 10:21:17 -0500
X-Greylist: delayed 1149 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2014 10:21:17 EST
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:50454)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1WBmwO-0000HS-6j (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 07 Feb 2014 15:02:04 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1WBmwO-0007GD-0n (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 07 Feb 2014 15:02:04 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <85BCA9A4-5EC3-4488-A4E4-4F86739B6450@kellerfarm.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241773>

Andrew Keller <andrew@kellerfarm.com> wrote:
>
> With that said, I don't think it's unreasonable for a software project
> to contain images larger than a browser window.  And, when that happens,
> I'm pretty confident that the default behavior should be to scale the
> image down so the user can see the whole thing.

Right. And if you want to see the unscaled version of the image you can
view the blob_plain version instead of the (scaled html-wrapped) blob.

Seems sensible in principle to me but I have not reviewed the code.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first.
Rough, becoming slight or moderate. Showers, rain at first. Moderate or good,
occasionally poor at first.
