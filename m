From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: mail-patch-series.sh, was Re: [PATCH v7 0/3] Add support for sending
 additional HTTP headers (part 2)
Date: Mon, 16 May 2016 15:35:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605161531090.3303@virtualbox>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de> <34DE0A16-F0B2-4379-8E02-5235D34FDD76@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 15:35:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2IgO-0004Tg-0J
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 15:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbcEPNfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 09:35:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:52376 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbcEPNfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 09:35:33 -0400
Received: from virtualbox ([88.128.80.193]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M0h9K-1bsKVS1oje-00utv9; Mon, 16 May 2016 15:35:28
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <34DE0A16-F0B2-4379-8E02-5235D34FDD76@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+8hke0j9OztEKw62AUXDndsQB4FmL9KAOCVMY0ADG8A2WH+OaRn
 BWXtcp8KkV7BqTx+xrBXVrRzhRUlb1O6kv+tASb1HtnZbHXAJ14zRTu4IqXpd83QPINauqb
 OOTadus+Hrt46Z/6qtUwOMLUm9T/M9/intddc4DCVytxAIjH1Fu+Oq3se6PqpcQHC70XDWs
 u3B5Es0rzlWfipdHDFvPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5Vo5np+oSiM=:lxSf65txdq2GSXvPGcw5UF
 +SdCKJd4Mgjl0UjAxMKNxDFHFkiVivMm1knG5gsCTjszEy7TrEMYC7XG14vKJFgsMrbky2IFW
 Jj5P3THMjGfOnfF9c2CDCfRxxKwZ1WX8L7Xi5pve1jFZc5QsEkjFMj8oUUBa3mlih8vgq0UdL
 WJSrw9+Zpocl46WYCG7/x8LyWXuArOfmMeYJC2aFBaVF6gmGaMkFPYhPwoup+f2JFR6VaHc9V
 MPBGPuugeAmwS/YX6CIWejH5Bad+uR4zgklJeskuZIAvWAcqG3U/jRLTzoUeVetpzl1yTkVju
 uAxfXak4VfHZXutT0OMee/7bbutrtYdNsTuMjKRDbnxeTC7/mDV6ebyQRMvtNy9czeyxiEsVd
 lmn4on2gYBieZg3sC/BrFr425gODSr1i+ndKjqT07JCgBHlk7sYXrgvm9YsnDlWb9Kf8sb49O
 d4KhlfV53WMRWo/h2Gud16uVbT5hWqqTUYpCUMFCC0A8c1/3/n6G80SoqJO0QgZGXIx+/aUag
 gOV8PGafiofIB6ypM/FbHzPZXsQPdztB50Ki2dTjC/VAoUI+cx/59PKKbDbYQmp6kIfe7Jiw/
 /p/4ZVasPrkYwtzOU897jMuIg8Ap9Hb8hgq3bfQIW6GOgZw3ER/j/8hj8Nuydw/E1KeiHPlsc
 UyqLnExo1GNmrWNFs3YzXqbwKt5FxbkgX+XZj9DhyJBjI0r7ZaOsIUi4M0ZnW95hSy2jEvUna
 y0cXkcA+XiVeWZJVdOCiDvNKHse/9YpDfQli5WVWxP40oDFALL/a81vW4WBHg+5gBUJj74Hm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294736>

Hi Lars,

On Tue, 10 May 2016, Lars Schneider wrote:

> > On 09 May 2016, at 08:18, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> > 
> > [...]
> > 
> > Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v7
> > Interdiff vs v6:
> 
> Published-As and Interdiff are really neat. I assume you have some kind
> of script to create all this? If yes, are you willing to share it?

Thanks for prodding me. I had planned to clean up my script and make it
public for a long time already, as I think that submitting code to the Git
project is quite a little bit too tedious, even for old timers like me, in
particular when compared to the ease of opening Pull Requests a la GitHub.

So now I cleaned up my script a bit and published it here:

	https://github.com/dscho/mail-patch-series

Ironically, I welcome Pull Requests for this script ;-)

Ciao,
Dscho
