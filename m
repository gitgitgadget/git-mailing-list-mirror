From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: v2.5.2 installation on Windows 10
Date: Sat, 12 Sep 2015 12:05:17 +0200
Organization: gmx
Message-ID: <cb974bd42910dd3babb8efeb57d3afd9@dscho.org>
References: <loom.20150911T181145-207@post.gmane.org>
 <loom.20150912T113250-202@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Diaoul <diaoulael@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 12:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZahgS-0008St-RP
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 12:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbbILKFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 06:05:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:50840 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754461AbbILKFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 06:05:19 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MFMIO-1ZOYbS1COy-00EMwx; Sat, 12 Sep 2015 12:05:18
 +0200
In-Reply-To: <loom.20150912T113250-202@post.gmane.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:XqStc2Q+Gx6gVOzERHmYBExKG9Ueaxf79mmK5K8JQKeVQFLLIQu
 grPdaiwSkKtX+m0aGCvfMBTcuGAwMOe7EZs/W3ky9bpRAA7TsNoKO0HElhw+DWwAKA+OGTA
 JabNerWC17xFvWzyOqHXyFjz/6Z1CFzgJvS4soxGHoHs5uk2B8cWbDrw04Q8V0JAwfJokbu
 4wqxNQ/3FOSiWAjeaRagw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hbBaQ2/av/c=:Jv1wpfuROed/hp+/4SmXZS
 8fMCBXqD6yQNQ1uuZK0DhbvGetKLzaNjTLcqDdt4PzZJlYoESCap4y3kdw8DANuFk6v15+E+g
 UltlMCv/uhrZ+2Hw6NtKp5bA/GP2JcqZWoKEGHkqRWtwNHoDJggdpeCkR4E7CQDo6cZnEDY0z
 6h779whyXyAO2f7ktllOdJYPKc00omKo+EcYX/Rt/udAOOnCkB814NdkYrXTbYRWQ80Ndqfdc
 iUMeeB+30iOcV5ZT9TBlTh6Fgg59JF2iffxNExlwmV+AsyO0dDAGVVsRcQUN8ef765blIoI9i
 Qggwgpcp2yhtxwqZzOQSWGbEcuo7NNC5Cv+SR3w5MT8WdjGK6h4JQzkCHlyW0bF5xcDS61X+f
 5xGmuedqCBFNWeeQQutOrHO6+Z2lp5bAe7IIo0xVoaygzoy1yWEea9XxNu6eq3ykPB3k8AQmg
 KpfN+nI4TsVF0AAxplnUAKJkci9sGleZSLyfrbQ8HkvTTKNk1MPu7tTBlX+8XJfmkI5VEImqi
 C6+y525AKMFr1VGeFULa+HbmnZJXuKraXZxbh3wao06269KCehSUmiSYfkYz7z33qidj6adFD
 h229IdEgp+DJM2iryUEc1hEj21T+UOq7JtrRsCP15aangKVQT9hy73BEzO3IzWpnMY7H2hFpl
 EPub9e13p8pWCbuckhD52fbVZANRMEsF0zgviG546UiqfO2plCAg5qE5O5r3Q6hX1gm1Gqe5t
 ymJDvxKXYNMoYKHWEld3YfjihFac2BM9fvLO+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277721>

Dear Diaoul,

it is considered rude on this mailing list to top-post, and likewise to cull the Cc: list. Please do not do that.

On 2015-09-12 11:34, Diaoul wrote:
> I can confirm this on the same setup (W10 64bit git 2.5.2)

Please see the corresponding ticket: https://github.com/git-for-windows/git/issues/376

In short: I will release an updated installer soon, with other fixes. In the meantime, as a work-around you could right-click on the Git GUI shortcut (you can right-click the icon in the Windows menu and open the file location to get there), select Properties... and change the Target: from

"C:\Program Files\Git\cmd\git-gui.exe"

to

"C:\Program Files\Git\cmd\git.exe" gui

It will open an ugly, unnecessary console until the next Git for Windows version is available, but at least it will work until then.

Out of curiosity: how did you go about finding the best place to report this bug?

Ciao,
Johannes
