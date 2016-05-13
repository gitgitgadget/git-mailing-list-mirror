From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: possible problem / bug
Date: Fri, 13 May 2016 13:39:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605131338480.4092@virtualbox>
References: <CAPpP+uW=ReKkUnz4PMEyhchcafd0qtgSZ_Qg0Hq77k4u+aPUyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bryant Bernstein <bryant.bernstein@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 13:39:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1BR2-0007xI-0M
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 13:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbcEMLjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 07:39:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:63613 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbcEMLjG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 07:39:06 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MQ7sF-1ax2pS3tQ3-005Gg2; Fri, 13 May 2016 13:39:02
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPpP+uW=ReKkUnz4PMEyhchcafd0qtgSZ_Qg0Hq77k4u+aPUyQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:19Mqi5dW7xL3FGvk8geoIrN/V2m8YuNVpRUNtnzIuRr9U3EEn4s
 iI1/4eyguflCdpp1l5dUbcCDBQy9bHyYe428gms317hfkyri4TOgyTiMQJlN6G5yLbXuZjv
 MTcNo1Cov9B3gZdSj1PmlFKhYbCUef0EY4qWKbhAqQuHw/Pm9AaKfscmcSsO9L7bjWDYk6t
 F4NOi4H9iiLUCFt2PGWnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tBHbOl6R4/Y=:HpIGhEq0AM+B7B3s0UDlhR
 qVdPgN6NtbSpu1PsYUhBCEavsMOegwzXNusBkAyvJ8e5a3wL5F2qdrX1LYco8rgvRNHI0sYo6
 5jaQ+pxcELAbxhEZKBxsjBYcayzlAaFgGnnUQaCYXIHY9zJyu+F+PCEYfDWmn/OtS1pwmCbwp
 206oLH6mj9X7quBKgo+HgGsDYXdHgbjC2iLgUFFHEnb2AiGPHgqN1tKq6XRjgW1EsNIH0xhxg
 4K55v0WmaT0f0qTSSogOMxO/8ezhbQ5Sd8cpaRNJOQQbw5ahjJig7PvSauw5mCbukPQQVGQJd
 9hLYGas/30ZUN9PyBM/d8laMcvAd3ZPFAfA8hu4InMeeLxfkrgGbIBIBFHFKII1BC3nyaj8t/
 EZTLi9Rt64Xrw9oPQnw6TYCsehF4l2xLejzsSYxCzcMKIqiOqvUrWmV3cj/0t5pMq7kq1VRz0
 ZxByFtZfq/3UVXFkfAeHQ44rMzRlYmHDaDO/hsLuCQ/ZyhOa42vNOk002X2oSgzRyE3GTd0x+
 745grRgayDvhdbztrmI3khaJH45CQunJ5cFfrF5bJyDLxrZrGROTOO7LqUBEjgxUBq05wNThG
 373wc9dF/LXWMVMx/NRni0BQ4xwVlBHrtdrAiQsNmgnw1g+2BThQKZXEqBpJ8YL6GbF/11iRM
 qt4wBWBmUSwaUQVvJpOvFPWc8XuY7kPFGu1wTz6P20e+GExpTmDSDdJnHbOysy+WsjovZU/Wt
 FhjsADzW+nYZjKlO+Qgfnbqw/GXJW7uFSIR1Oj2PhVgkhpY7rVvIMjGJPoker4Mv/QnNw1bj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294524>

Hi Bryant,

On Thu, 5 May 2016, Bryant Bernstein wrote:

> Both windows and linux support links but both git and the git bash
> seem to have a problem with them.
> 
> In my source, (originally on Linux) I have a link in my source
> directory to a config file which I normally import into python.  This
> allows me to have something.py pointing to config.txt .  config.txt
> can be opened by an editor and something.py can be imported into a
> python shell.
> 
> This worked in Linux alone and on windows  as both platforms support
> links.  But if I use git to bring my code from linux to windows I end
> up with a file that contains the path to the target file.
> 
> Then I went to try to see what git bash would do with a link.
> 
> I created a file and a link to it using ln -s
> This created a copy of the file I wanted to link to.
> 
> What do you think?
> Should this work better?

See https://github.com/git-for-windows/git/wiki/Symbolic-Links

Ciao,
Johannes
