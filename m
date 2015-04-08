From: Tony Finch <dot@dotat.at>
Subject: Re: How to send a warning message from git hosting server?
Date: Wed, 8 Apr 2015 12:08:06 +0100
Message-ID: <alpine.LSU.2.00.1504081206420.10193@hermes-1.csi.cam.ac.uk>
References: <CAFT+Tg-Gwr9EemFv88+=Ao21dGYe73D-CDiT4mXU4kuP-niOSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: "Yi, EungJun" <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 13:08:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfnqA-00041l-AG
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 13:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbbDHLIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 07:08:10 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:38061 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbDHLII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 07:08:08 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:52403)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Yfnq2-0001D5-j7 (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 08 Apr 2015 12:08:07 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Yfnq2-0003Hh-Uj (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 08 Apr 2015 12:08:06 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <CAFT+Tg-Gwr9EemFv88+=Ao21dGYe73D-CDiT4mXU4kuP-niOSw@mail.gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266952>

Yi, EungJun <semtlenori@gmail.com> wrote:
>
> I want a way to response a remote message when a client send any kind
> of request. Is it possible?

Yes, though you need a wrapper around git. Recent versions of gitolite
have a "motd" message of the day feature.

http://gitolite.com/gitolite/list-non-core.html#triggers

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Fisher: Northwest backing southwest 4 or 5, occasionally 6 at first. Slight or
moderate. Fog patches. Moderate or good, occasionally very poor.
