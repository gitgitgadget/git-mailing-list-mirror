From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Apr 2016, #07; Mon, 25)
Date: Thu, 28 Apr 2016 09:58:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604280956590.2896@virtualbox>
References: <xmqqoa8xia1j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1604271454250.2896@virtualbox> <xmqqmvof9fqw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 09:58:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avgqI-0003Ys-Hu
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 09:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbcD1H6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 03:58:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:49554 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbcD1H63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 03:58:29 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2cYX-1bn6u82iPN-00sOtq; Thu, 28 Apr 2016 09:58:21
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqmvof9fqw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:igs3OwmZ4lnK0frNcKDurdXJGAXXsJcIv0kSqqXBj9EbBF2cS2B
 Vt5/IzdsOQJGo+I7z5efj67Jm+UWIgTINp1C9Z4J8HJ1QdbqJ2AApdGbVKf46ZwHW93QwHd
 RC2r1qalAxqPH6dcCn6XcpvVtLfv178bcXCSNtmYJEOQOWk2FmMFCNHVwNrLCiPYK6gfcq9
 JlKrINB8flccmEFrWjC6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iiTlryrlgJA=:MWUxrK2cZsRcYB81wZlWGq
 w/IbPO900QG72oEzznaTJB7n5A6v0s88YJVJzxqyRxYdE2gEjixXtWZ+IqN5s29HAtwnfEFwG
 ePLqtGvSOmr0zQhL8HDfutI+/tWhmhrVke6iW3BzyXGRq6PrFIf4zie6bEPIZcDWxFMox5ZSg
 0k47AWu+Lo2L4nKJBSBxpcDHFZBIpja6tOS4LHfP1Fi0U5vvMG3knjMnWSXFwMPK8lXJkLUED
 EPx1BlraIa6/uOZaZRaRlaUT0md4dHt+PcFEpEgAzPGM6BvkyAIbtgHlMTZnkh4F3ftDbx73Q
 vMeBN2ARXUYGxB/LrLNqemVbZO6oJWeN93tgZLSViFADmBxIf4EMmX8bCGEkHVM6f+aC1qFU7
 b/XRZQhFwCExBfyX92WSXDtfhgtFDNg12E60MxutstzmvrGaVnRfXhPQY/CXlWbEBm4SDrbB0
 SyOIOqoBqMkvqjwarvuYb5uvJgroDyoHmUu0kPAL7trvnSPTINvWZPYo9jw95paW9+Kg4CEw1
 Xdcjy/lSAG9kCXwuKPV7dN0OA2cmOpU3npTICyEvRpJYpkFKY5ccWL5xJVyEJdG5LfV6Tn8YT
 wiwB1EQsReIWLGjjCgO3yWOBwRKAJwPkcOTdYTqS6gIeFX/mu7lRqayiR4SghDzQWP1jH0Ydv
 rX7I+7yqBYAt5eZxHisxzHK9LTihjNDvSbouihCpEAg1HCe71bLngBDXhE2noVCPojCvZq/A7
 nw19K82weH5qW5qrADjNwn/Jc7NY1XLIiRppmKqGFkdUCm6QaSTNOhprl1/8uY3FRgvXiE49 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292855>

Hi Junio,

On Wed, 27 Apr 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi Junio,
> >
> > On Mon, 25 Apr 2016, Junio C Hamano wrote:
> >
> >> * js/win32-mmap (2016-04-22) 3 commits
> >>   (merged to 'next' on 2016-04-22 at cd39c60)
> >>  + mmap(win32): avoid expensive fstat() call
> >>  + mmap(win32): avoid copy-on-write when it is unnecessary
> >>  + win32mmap: set errno appropriately
> >> 
> >>  mmap emulation on Windows has been optimized.
> >
> > Please note that it is not purely an optimization. It is also a bug fix in
> > case of a pretty full disk: on Windows, mmap() is backed by the page file
> > if it is in copy-on-write mode, and that can fail when the free space on
> > the drive that has the page file drops below a certain threshold.
> 
> Thanks.  How does this look then?
> 
>     * js/win32-mmap (2016-04-22) 3 commits
>       (merged to 'next' on 2016-04-22 at cd39c60)
>      + mmap(win32): avoid expensive fstat() call
>      + mmap(win32): avoid copy-on-write when it is unnecessary
>      + win32mmap: set errno appropriately
> 
>      mmap emulation on Windows has been optimized and work better without
>      consuming paging store when not needed.
> 
>      Will merge to 'master'.

Perfect!

> Reducing paging file consumption still falls into optimization in my
> dictionary, though ;-)

Well, I considered this a bug fix when I worked on it: the command should
not have failed, and with my fix, it didn't ;-)

Ciao,
Dscho
