From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] remote-hg: fix handling of file perms when pushing
Date: Tue, 15 Jan 2013 14:06:57 +0100
Message-ID: <1E49829A-0675-40D2-97C6-FD62982A0923@quendi.de>
References: <1358254959-50435-1-git-send-email-max@quendi.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 14:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv6Ef-0001wy-88
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 14:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756761Ab3AONHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 08:07:01 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:52931 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755751Ab3AONHA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 08:07:00 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Tv6ED-0004TA-BG; Tue, 15 Jan 2013 14:06:57 +0100
In-Reply-To: <1358254959-50435-1-git-send-email-max@quendi.de>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358255220;4f116448;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213633>


On 15.01.2013, at 14:02, Max Horn wrote:

> Previously, when changing and committing an executable file, the file
> would loose its executable bit on the hg side. Likewise, symlinks ended
> up as "normal" files". This was not immediately apparent on the git side
> unless one did a fresh clone.

Sorry, forgot to sign off, please add:

Signed-off-by: Max Horn <max@quendi.de>

Max
