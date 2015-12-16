From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: No auto CRLF conversion in Commit Message comments
Date: Wed, 16 Dec 2015 17:45:16 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512161738080.6483@virtualbox>
References: <FBEAE9E9FAB4174499E31C0F26B4BACD2DED2E66@SRV00048.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Harfoot A.J." <A.J.P.Harfoot@soton.ac.uk>
X-From: git-owner@vger.kernel.org Wed Dec 16 17:45:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9FCf-0008SU-3g
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 17:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965945AbbLPQpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 11:45:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:51233 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965686AbbLPQpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 11:45:19 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MHX4u-1aCY3F0lUC-003KE7; Wed, 16 Dec 2015 17:45:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <FBEAE9E9FAB4174499E31C0F26B4BACD2DED2E66@SRV00048.soton.ac.uk>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FkppZD4AVF9nsIdWroBfvWOrbBPlVKfynbUxtG4xVI3KYrBTkQ1
 ++qTsjYUUB4G/xF0iFE/sOGEkToI1l0DT0zIp8LGU3xG3R/IM+M0yCGq0ENHL9sSjtwGxV5
 nBrkiIqkItyDhiz9iPTHyTt9FeH7N2S8NyPJr0SJjCQvYDKD2/c2d5QFZ45PuvGOFwHYTzX
 LRvixj0NfJ3PXdZjz0S+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oCunGS7xVrs=:qXQBehiTjrkkXffvopUD+x
 y5opUiDC5BL49HsVr9BFxFXN1o8IJM7WWLDck75n+7oGGF04fs7jGAieZWCevqQWHaBVZAo3O
 ORWnp04q7DH0XyCFgCuREzi8ZTK9xQL5dLjxHZS7w1Bp16oZQR9oC5YFIkjRJ3zxgOXsiFAoK
 knEWVsB0p0EoyasjAa2GfrcGHxknNClA5T9y26ep0F+LVXXKxik+3KtfeEflClS5HNO9RwU+u
 mWaWglvYxenh4DZ8iBOGb1M0icv46Q7kFY0++AtuKiU1+EZFwME+I8kZgeiqm/nioSnWG3AHY
 cVZyBojZVktp19z9PT7Ir7w4eU6oMbpRowE/oHT/Bj94iPE0bqL76po7tBr8VrCXMYc7ZX8xv
 SLXP7Scwi3ReeEY/ISDqPpibj5fGHAXO9irPWSHaa8EHRFn7KcJL0tjxlh4bUQY4z8H+icl68
 F2/bcxLoPaVRyoujMQl7pE5soPSzubIpSer7IM1EhAbjvcsF/CCSyMYoI1HwA7KkmkURv5MN2
 Ut73r6he97oKVc7rBxifheAtAlf15E5x0HqEHLD9EhAwJq+CzTuIYQLUfJApF3yHldZ3SRNRE
 80Gip7A7vnFRTldU+3RTahVsPY5jtcX3W0SbaMfBjSnAiykkoQQRbpIXWmtX30qoRxyzKikxo
 agxEaGOMKc0wQJcJp1mQ3542XpYCCEp94lZk3Hd2nwTMPJ+unXwKB0pKNGekNsLUlo7D7+udV
 EfdA+oUTwZkILAn+FEAcskJSd6trmmX50aH4VTVvLK4SlzKoluWiDIZ2S9F8uejp+8ZpQgtl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282577>

Hi A.J.,

On Wed, 16 Dec 2015, Harfoot A.J. wrote:

> I'm new to Git, so apologies if this is already available, but after
> some searching and experimenting I haven't been able to resolve it.
> 
> I am running Git 2.6.4.windows.1 on Windows 7 64 bit.
> 
> I have the global configuration variable core.autocrlf=true
> 
> When I commit, the commit message template file is loaded into my
> configured text editor (in this case Windows Notepad), however the
> comment lines are terminated with LF, not CRLF, and so are not displayed
> as new lines by Notepad.

The core.autocrlf=true setting affects only Git's operation when it adds
file contents to the index or writes files from the index.

However, if you have `core.editor = notepad`, it should Just Work because
there is a `notepad` helper that performs the LF<->CR/LF translation
transparently.

> In the opposite direction, the output of 'git log' redirected to a file
> has all EOL characters set to LF, when originally entered as CRLF, so
> automatic conversion is working

Somehow I doubt that `git log` transforms CR/LF to LF...

> I have tried to generate a custom commit message using the
> commit.template variable, but the commented lines are appended to this
> file, creating a mixture of EOL characters!

I am afraid that the only way to keep that consistent would be to ensure
that your commit.template has the same line endings as your editor
produces.

Ciao,
Johannes
