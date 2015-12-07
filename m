From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems installing git-for-windows
Date: Mon, 7 Dec 2015 20:03:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512072001540.21630@virtualbox>
References: <323868295.20151207124400@ptoye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Toye <git@ptoye.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 20:03:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a614j-00062f-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 20:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbbLGTDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 14:03:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:51251 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755539AbbLGTDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 14:03:48 -0500
Received: from virtualbox ([37.24.142.60]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MF5FT-1a46TB3AwV-00GFm1; Mon, 07 Dec 2015 20:03:46
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <323868295.20151207124400@ptoye.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:uAWA6qcV4N8Kg+v+ax5I5XvpejVC3okG6xLK2G/wQPca3hZewNi
 LgXnL/sB6GiZ/v3OhgXGawNIcoJFU4J+tljzEKV6ARLy6v8CkPTNMyo2ua/KQzvhAWYOZt2
 1jBJEaFZa8nxiEI2rkhNj38s9nB+4PvvxKezFocqyxBmm6VcY5O5i1GiSqWmMsucP9G6Q8+
 yt3ixBRI72SIWOcNeER3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YO6gJiZX2Dg=:rCFEhPzGQ03CGJKlxgRVGL
 Nq0CzE59ZKhUAoKjbBdhHL1Jzj4yjX5nifrpJOVj8ucX7L2rdEwdzc4Din3HTQVLr2+cA5dGs
 JogXuAkjsCG/P2bSk5QArHMVBO5u62xoLdTdZ6Xx1aktpCEyUpouPcTHq+TpFrdceoLVFcjeM
 NwJ5zISTI5QDtwxTREWGfgxzmjepjolWayzkHY+R5MsJFnfCXjYv3CM6RP6/sOE35ah/Tp0by
 XdwyLFqTDZEhPtiAMMXPzbMkUzcy2JhZGyJePKaaKWPPY7bbZw9c6OlGHKiYnrqhglERi4eNQ
 kPrx+MTQmDUzKKzTzGhy71PHJl6f7DhWc+t6bkCjbI7kjE6zUgCkEvDCYTP+99ppnD252fV2B
 oVs4rT/ER8efbgUzvCzM/VYUaWxJDJFSARZ8WhPS857/2I8/yNuyHdV5Sdf70SY8oa6gdY5y4
 OEsb3Hu1SJSeiZ8Mf/Qcg0DReh3sN8WvmH0X7qRw1/44npTMHJf3HcRGgTxCAH15mwcNc0Hns
 anVpduDcY1wmsYDZ3sX5rxdLKCOKjIqzTtG9DLobL3GX5nMF6dEqVZ66BslfeR9mL5gkYZSNh
 HaZq2LiLiiNSHZh+nid8tip5Pw7tKqFS5Dh1Xl4fE5RzEX/LNk6SefRHkO7X7KYAWtmTqJNb3
 7RHpMuzoqxJ25fJmHp83tmd3SIXPLgbYjRKTbK8pD5yX5Rwg8ALkkZ4+eywOzix5ePPMOQQCd
 ntdfkKf75+vxG4iboRHJAmE5bnnY0dQTSGV7+f+VjdAqlKgGop3V2SxC5WqBDqc5LgGUlnHJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282106>

Hi Peter,

On Mon, 7 Dec 2015, Peter Toye wrote:

> 1)  It wanted to install into my User directory instead of the
> Program Files directory, which is the best place for all programs.

There has been a regression in Git for Windows 2.6.3 (please *always*
state the version when reporting bugs) that requires you to run this
installer as administrator manually, else it will install into AppData by
default.

The other problems seem to be consequences.

The regression has been fixed and the next Git for Windows version will
install into Program Files again (if your account is equipped with the
appropriate permissions to elevate the installer enough).

Ciao,
Johannes
