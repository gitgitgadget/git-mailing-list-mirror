From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: automatic git installation
Date: Wed, 13 May 2015 10:43:32 +0200
Organization: gmx
Message-ID: <b70c62b621a8288039627d4911da5af9@www.dscho.org>
References: <AM3PR01MB3742DD43DFAE5196C50A572E6DA0@AM3PR01MB374.eurprd01.prod.exchangelabs.com>
 <CAEcj5uXSTu+eqX3O0ecb1JnQQfjEYb38TfYhF9tUOmNV8hZCTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Knobbe, Fabian" <Fabian.Knobbe@landisgyr.com>, git@vger.kernel.org
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 10:43:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSGV-0001Pj-Hv
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 10:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbbEMIni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 04:43:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:64429 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbbEMInf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 04:43:35 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M4Gyx-1Z9Qwx3YDj-00rsU1; Wed, 13 May 2015 10:43:32
 +0200
In-Reply-To: <CAEcj5uXSTu+eqX3O0ecb1JnQQfjEYb38TfYhF9tUOmNV8hZCTw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:cBXhs7Yzfxiv0SSOdWiABplwp6Z/TWegAgD3RfgKsGaQiWL0g03
 5pMoO0zIVAAKiQOBzHlkrsvWFKrCLpQPw6D31sypmZ6LxFh6n6DaHLFz5d0n/ihNh7v3rU2
 vB8nbyzzbudfqU/u+zjCdZL9BjbbDTg+pXb6/VtFNzxPs69RfF3u/gQNMJwGhCgkAkDFCqn
 Tpq2JsZE34/dM/w3+2QQg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268948>

Hi Thomas,

On 2015-05-12 21:30, Thomas Ferris Nicolaisen wrote:
> On Tue, May 12, 2015 at 10:50 AM, Knobbe, Fabian
> <Fabian.Knobbe@landisgyr.com> wrote:
>>
>> Hallo,
>>
>> I would like to automatically install git with a script. I already found some command line arguments to pass my settings to the setup routine, but I still don't know how to set "Adjust your PATH environment" to "Use Git from the Windows Command Prompt" without userinteraction.
>>
>> Thanks for any hints!
> 
> Have you looked at Chocolatey? It's a Windows-based package manager
> that lets you install software like Git in one command [1].
> 
> [1] https://chocolatey.org/packages?q=git

Good point. Please note that Chocolatey essentially takes our portable Git and repackages it.

As for proper package management, the Git SDK is based on MSys2 which sports the Pacman package manager ported from Arch Linux. Git for Windows is also available via a "Pacman" repository, and our installer essentially takes the contents of up-to-date packages and bundles them in an installer.

Ciao,
Dscho
