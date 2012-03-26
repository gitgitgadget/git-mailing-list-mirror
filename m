From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Push from specific directory.
Date: Mon, 26 Mar 2012 16:27:00 +0200
Message-ID: <4F707CB4.3030308@ira.uka.de>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl> <20120322225747.GB14874@sigill.intra.peff.net> <4F6BD1E2.2050607@gmail.com> <BLU0-SMTP315865C5026D08E76594E5DB1460@phx.gbl> <4F6C970B.2010803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anjib Mulepati <anjibcs@hotmail.com>, git <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 16:26:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCAsc-0003VI-OA
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 16:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546Ab2CZO0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 10:26:35 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46279 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932489Ab2CZO0e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 10:26:34 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SCArz-0007DP-Ot; Mon, 26 Mar 2012 16:26:26 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SCArz-0003J1-Fi; Mon, 26 Mar 2012 16:26:03 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4F6C970B.2010803@gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1332771987.048449000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193912>

On 23.03.2012 16:30, Neal Kreitzinger wrote:

> You would want to setup the gitignore before doing the init.

Why that? "git init" doesn't add any files, the repo is still empty.

I would even say "git init" helps because you get a comprehensive list 
of non-ignored files with "git status" and can sift through that list 
for files you want to be ignored
