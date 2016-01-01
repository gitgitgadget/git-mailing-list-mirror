From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT GUI - Windows build will open a window on a disconnected
 display
Date: Fri, 1 Jan 2016 15:51:04 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601011548330.14434@virtualbox>
References: <CANw98ADVGg0GKXmHbNVrPhqM4fbFL3et_vrY7kcvMt-LaW7Htg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eli Woods <eliaswoods@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 15:51:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF12v-0001n0-MF
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 15:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbcAAOvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 09:51:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:59496 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbcAAOvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 09:51:08 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lw2Sj-1aBxC82Xy1-017nzA; Fri, 01 Jan 2016 15:51:05
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CANw98ADVGg0GKXmHbNVrPhqM4fbFL3et_vrY7kcvMt-LaW7Htg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:SGkEJTZnXFsy1sRIog/GWngLiQRYLACj2dJ3HgZzE3Kr0RrT6QI
 8cAPmelEUtNNMGRQ3xn3kCjnTrjuj2DY6jT5jxE9GAmIdEgQeHn1CETdCeNvsliNzOWvEi9
 nlyEaCUvAEdpYZv0yABnVLFY04eumX3riZybXq+B0JyvJI/1iQuChe7gEPnTXBqZTB2JRU+
 xDZb7xQIaU0ipJOQn/Gbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tT1uMJDux7A=:cbml7E6xjK8EDDrSuJSRa8
 rLXOWdfQ2CLG/j2+fYMTnpkbgWjrZ3nTkO5R5Mybge7zWA46KsciT0yZXy5DcHZNmsYAVQeB5
 vogV0FP2ms+9PB8PL8j3hjdyB/Y0ZgeWTDB1Rr0E/0l/VChTftZOkQbjX598v09p1QC0jjBR1
 u60vcqCs9vS+15kaapIFJPW2Xr/1lYWa8ZjMuWw1WlidDr09GowA0kLlzNNSJLiNseaHoLDd4
 V2Qz3JlTCUNo/MwX8vXoWtKuKN/0cODEoNhw2lpFhyxpow6kGY2KoIBqPchUzqRo9ZvTvWqDo
 Po6r3yZlnE3DHdBrJIgeywnnajRgTduDGi/npqC/c0J1YEwf57EILUR50xthYPodu2WgDhwMa
 XiUeGf+FYKapWoYsFQLGxuDtXEVkj3h5jT0XrAhj7BeuPlw5UEq0n1ouMb8CMusgItdtLVJBe
 Z4Ne49mfZDKIk2kZnqscrvmbv9+Z32AZzl9MH+nLbNoRGrRSlU8XIkoIkghUxV7Da9vbJjRGn
 D0Yc5dt2sUDXlH9Fe+/3POwouxv+WPsCeF3jOzRwGAdG52TzTTfyOZ+foLuDHKehdGr0M54m/
 Kz/1A2TqxPmMtahWWXgA5AMMgj/cyis+av+KyK3aC6avH3EdOmybMLhB5EHveMnRuS+uulrWN
 KHE5n6kT1I2EFLk4KywKuQmQuZ0AEldQxp9uBTnCafWy56SElLxYXkAn8FvrPIQv+TKaMuce3
 Cwu3B2T1GoFdfz05Xhq5B/KEElgoH21PRBSmr2SvQs4ELIlQH7mDAqV0EPrKlxLEqmYGgqmn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283252>

Hi Eli,

On Thu, 31 Dec 2015, Eli Woods wrote:

> This may not be a bug specifically for Git GUI, it may better be
> reported to WISH
>  or even Microsoft.

Well, let's find out where the bug occurs. I have a *hunch* that the
answer lies with gui.geometry in .git/config. Delete/rename it and try
again whether this is the culprit, if not, write a Tcl/Tk script (to be
executed with wish.exe) to find out whether Tk is the problem.

Ciao,
Johannes
