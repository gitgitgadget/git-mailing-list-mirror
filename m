From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git crash on different versions, including current
Date: Mon, 31 Aug 2015 15:45:16 +0200
Organization: gmx
Message-ID: <77acde26d3e0af558670ce430f24e21c@www.dscho.org>
References: <55E17049.8030706@soltenborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Soltenborn <christian@soltenborn.de>
X-From: git-owner@vger.kernel.org Mon Aug 31 15:45:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWPOo-0002AB-Ei
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 15:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbbHaNpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 09:45:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:50770 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbbHaNpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 09:45:18 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MPD8G-1Zan7M31wO-004UxK; Mon, 31 Aug 2015 15:45:16
 +0200
In-Reply-To: <55E17049.8030706@soltenborn.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:M4yUyVVtlDDaLQpqJplNXim3A77WgUHpk54niv8bTmf7PjvBmaa
 dMC8dPT5Un/L77WU19rgAGnRBsqSyjs9blAh3gOvTmY38FoKb1Emr2PFh6Xejl85vF821of
 ZYeHVSB4ZlJrfEkVUNLr61gw50bspTgb2GQFSvFuzoA/D+2ihmr2V4J0MLQAmhsHBdFvrES
 Mhfk8FJGLIHzgYWHrM32w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SRodObm9j/I=:ab+eMvYWM8C+qUEjzoGK1Y
 ANMQaImf8RDFf9UKz9XmR7Cz2dSTWX5Z1U4MBTza8EkbDUehKPzBZv0ql0++cU+vJsl47VAkF
 JNbZeOTTPG5OPhyK/h+jnmVTDjaQ940Ydsgbg1hMLjlSyxxkbTwxjyOoCLJvcpIWZIhZM35rP
 Qq5ZL0U/iJAzyrO3FUh8oTO+7/DMRrO5QDmoKrBDg93AKv3PdgsU/KnBnATRua/ELn/Xxoqyy
 SQ5eX2h7t5atxzEDSMhsPToEriEh/jTb/c+7rxbrJ3OShgtC6kbcKW4CW3/E64zWQE8U7wbVW
 P3/3zpSVl3nmjzTlwOYl050BktTOEg1gP8wV+RzRtu4N9SMX/7dPygArd/LymqBFfGe5soG4h
 O3+qe7q+lWfB/6uXpODzpfbGMeZrSdOSvfonoDL9mSZKRxtfuxJhG1aLvRJOo8fCzy1qhXV+J
 cPMV+RSKbWNH4/QhAokW5BoSgro7u89UwRZNGaTEgjCqyGgL6TxqqsfelPCsuS9lFeUHmvZMJ
 l426Wf1QpBHwAh6/C5lDpRsaqWrBc8KHoPtUBde6om4cL0xAvd+Tdg1E9Z0uMmnj0OVml/Cyb
 Frx/OmVmCz0Naw42XbJup4OAJ79IfJ7vDiqi3UskNG6JDX9eSTZheuMbHrH/obcf2b/dEFJDd
 6q6Zm4nYKSnKRLRtvhXSMIOq9uQhFusBXYsEfI7qVFVS5vq7pSyqCyI1iL9ZxaXlZ6Oo3lPug
 8Kbt09cr4BQC4kJs2G8tO8DgHONl5TEt99d0Bg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276877>

Hi Christian,

On 2015-08-29 10:41, Christian Soltenborn wrote:

> today I ran into a git issue on Windows 7/64. My directory structure
> looks like this, and I wondered why the content of a dir wouldn't get added.
> 
> C:\Users\chris\git\GoogleTestExtension
> -- .git
> -- ConsoleApplication1 (new)
> ----- gtest-1.7.0 dir (does not get added)
> ----- stuff that has been successfully added
> -- more stuff that's already under git control
> 
> So here's about what I did:
> - Looked at it with Git Gui, noticed that gtest-1.7.0 is a submodule
> - Deleted gtest-1.7.0/.git
> - performed git add --all . within the gtest-1.7.0 dir => crash, output
> below

If you copy the entire `GoogleTestExtension` folder somewhere else, does the crash happen there, still? Can you share a .zip of this folder?

Ciao,
Johannes
