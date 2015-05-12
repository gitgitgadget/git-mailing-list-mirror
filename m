From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: automatic git installation
Date: Tue, 12 May 2015 17:10:28 +0200
Organization: gmx
Message-ID: <623dfcd4547202a2c6eb399a6c0116ed@www.dscho.org>
References: <AM3PR01MB3742DD43DFAE5196C50A572E6DA0@AM3PR01MB374.eurprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Knobbe, Fabian" <Fabian.Knobbe@landisgyr.com>
X-From: git-owner@vger.kernel.org Tue May 12 17:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsBpN-0004V7-G2
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 17:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbbELPKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 11:10:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:58802 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbbELPKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 11:10:32 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MarAM-1YcJdX1aRu-00KQq4; Tue, 12 May 2015 17:10:29
 +0200
In-Reply-To: <AM3PR01MB3742DD43DFAE5196C50A572E6DA0@AM3PR01MB374.eurprd01.prod.exchangelabs.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:4SomX2uTdWOIeaHic74ygXhqy1wvLFcZSUP57Xg/AZDLh0kc6Yw
 lpDvwPiJ+ZJX1Y7LtkTmfXxUQ1lymBeeOjunZm+fs7XxHmWWUJlCZJDimxQ3VciL65hWxQP
 7hn9PQddSccgQlU3iVgqESnvLg/IM7Flx8UQd1aveyjhWaFTvO/IfymvkZM2wUoTVKgSRXV
 upLW7/mb8ny2khVdkcOXQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268856>

Hi Fabian,

On 2015-05-12 10:50, Knobbe, Fabian wrote:

> I would like to automatically install git with a script.

... on Windows.

> I already found some command line arguments to pass my settings to the setup routine, but I still don't know how to set "Adjust your PATH environment" to "Use Git from the Windows Command Prompt" without user interaction.

If you use a recorded silent installation [*1*], you can choose that option in the recording stage and that should be enough to select it during replay.

For non-Windows users: Git for Windows uses an InnoSetup-based installer that has the option to adjust the user's PATH to either include the entire Git for Windows binaries including all third-party libraries, or just the so-called Git wrapper (it is a lone `git.exe` inside a directory that does *not* add all the `.dll` files that would possibly conflict with other executables on the PATH).

Ciao,
Johannes

Footnote *1*: https://github.com/msysgit/msysgit/wiki/Silent-or-Unattended-Installation
