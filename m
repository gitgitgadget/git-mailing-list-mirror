From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] merge: do not contaminate option_commit with
 --squash
Date: Wed, 27 Apr 2016 17:19:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604271718530.2896@virtualbox>
References: <874mb0kkkk.fsf@gmail.com> <alpine.DEB.2.20.1604180825170.2967@virtualbox> <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com> <87a8krpehl.fsf@gmail.com> <CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
 <xmqqy48a6fht.fsf@gitster.mtv.corp.google.com> <xmqqtwiy6end.fsf@gitster.mtv.corp.google.com> <xmqqk2jkdpjr.fsf_-_@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1604270846200.2896@virtualbox> <xmqqeg9raxtb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:19:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avRFm-0001Cu-Su
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbcD0PTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:19:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:52928 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcD0PTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:19:46 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LxcbX-1bkfL82pTv-017GuL; Wed, 27 Apr 2016 17:19:21
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqeg9raxtb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:pBs2BcHFzGhNRr7mwC8GdfXngfXuD+prFj3vLmzV/CvIs1FaT1A
 J2qsBDeSLwz0v6QZ+fj01Dg1MtOcOR6iJD2f8YAFDQmoZOW5UYIKCvIsIiYmWxGPgMj6pNr
 +nAdBiW7Uuq4bJN5ZyBMAJmNXDRdnEPZZT66r7sY18ObAtcXDEc5ibo/b4ckdtyrnZ3Savg
 yJt0xrYQT8nntbHwfZ2Hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f2Qsnp8BlqA=:IL42gCco0yNpwyJwdxXVr5
 CC0tlKrWJqp7Pri/DlpIB4zDRQ8VvcMV34Qg0pcPaD66NyVmbg+SAtF5uuFMta+zRbhpB3ZSj
 PHc2H5p+qGsugyPECj/S8zGFytK6H709M0pR4x2zRZgsgcLicjLoK+GlZ/NcW/jYiFFUqo78R
 L/GRxoC6ZYc+cGDkFudAX0u4mzqeMB991UKz3j+LhAjMBugh6SkHXHd5O9uYsL7nWOh09Vlrs
 3iM6UyAFaomFJLDeaPHkU1zgcya7NPqyUUjXeSigAU16JAIggvlZ0zsBJ+5sBcGTKeroQvfxv
 HlerdGq6O9Fa50YcqvkqCsqkxO9N845tbeZApuCXbMb3yZ2+InXLfSZUi0kq7pU58pnvsWcWk
 bd+bz2w4xZr2wjV5TVlg02/CkiwgjPAhCI8dGHUp32MF1xjh5uzEZ5IMRMBHpHz8TVvEe4lMl
 A1xOc4tlFhadz8/gSKGW7QvvwyTA03TtweyQTq6wkH3NOHnvlpP35SGLonTPr9ST+P6FHJSav
 9BXfXWhEF5WxUKYESK+1IaS4lr59Tx+d9+0MEJDXUNh614V9ATV/YaU3lNqXBuLvDShhxIexc
 VZCUf9r+QcMxHiquc3LA1y8H6w9JhmTHa24C5slems+jPelVnLtaKZXCjiYo6NA37fm6WLx8G
 Wtv1IAPW11W1/Thahsh+SGmxwOwnQciXnPf7b7+MyQjldnq9OtYI9nQO14on1CrqfN2ML6J+T
 7Iac1HFdzgsdmj1alSY+GMdqBN0dOWf2d9bR5iOtd8FNsDSy3EzZlYc3pwPJa/O9T3mNLezK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292732>

Hi Junio,

On Wed, 27 Apr 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >>  * Just a preliminary clean-up for the next one which is on topic.
> >
> > I think it would make for a nice cleanup anyways.
> 
> There is a missing open-brace that causes a compilation error,
> though ;-)

Uh oh ;-) I guess I did not really test it...

Ciao,
Dscho
