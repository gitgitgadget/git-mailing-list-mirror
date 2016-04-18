From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge branch --no-commit does commit fast forward merges
Date: Mon, 18 Apr 2016 08:26:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604180825170.2967@virtualbox>
References: <874mb0kkkk.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christoph Paulik <cpaulik@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 08:27:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1as2eI-0002QZ-QK
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 08:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbcDRG1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 02:27:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:53038 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbcDRG1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 02:27:00 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LhfZR-1bW09Y3uOP-00msN7; Mon, 18 Apr 2016 08:26:58
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <874mb0kkkk.fsf@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:rmiLrZNc4RV8UTaQDfZle9zxenqroWmxW3rHJGUUlEq9KFTFZU8
 893+rL1atnzKI27VEx8L5e4GYYAnpRgHTT64tfMDEr5DZElA2aYqwFB3cAZFovcEPD+g1aN
 dcQR3bC8OJ4dwg47yTJJdck0GjKoIzql7KMcXZMJE4XC+d+y1mMqrLtT08ESMDh6lw+WdaU
 V2w0SOHwRDNkE7F7D4lXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:67qCbTddrQQ=:bOETiYe3pcYw716cni4ZUD
 metZXiSIPsMSG1sdky/2cP65/GPP8szHN1wIUhLSR0e1RAIZtCl1Kjs2vw/Srnu0U0Z8towVR
 Dr1s4OfPveQIHZUtRtoSrqI65sAS5entvNFDJ8bFhNXq0om0fGoJuJrKMRgOO9kSc8BGVKcb+
 vFi8bgFEtjJPEMiTaKg6djyhKAXe5EwxTHTw8dlbRisS0kNQGt+m6sAAzBr4JWAbwbWQjR/fs
 LKOAihw5U1eWvB25Q6CO/bwXf+DJ1xBbuGBff6/B4GHbL07gpXLte+JYGghikMVblBqAODOl9
 3B1jyYi7u6G3lIJL2GDSBOrvwN4i4DuyBy2yTyy33pEzLm3C2AOyNSC63GNgt0prlkAPldy3D
 RVBmnEl83Wdy+Ih7/P9Te8pJJEUtIuSKNnjLP0jycXSsvs9h2pSHp6Ggjd6TVnIQDEsm0yGei
 EC8SEibchFiQhAff2J4qtLI/S+L61trFwrqC9P/kqyMjkVwV0c3Q0JrY655IKHD2cCRhp8smi
 EcOv0BERI+0X4PZcDmmkoGnsNyPII6vU4JEPyGZAC+Gl4q37wKaIAuvmTaw4Zdc+Jn0iOvYvU
 KcR8HHMEgYvfG8MQo6PCsCwkXf9m1FKjaWUR64Wv5NADgDcfbGov0WFHH6tneXoPmICo1TaJO
 1NCEqM0pI2GUBKXGtyDNa7T7AkTDTaTNFHOCPR5FHykE57tcuSn5/bMU+JzwbhYxe+3GBLYz/
 3r98TN+lQiQd0Q1B+4O/UTL0W3khKoInozTEa+sndzPZ0aXMFHNxzX4oAPYzzQChHp3/ywic 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291797>

Hi Christoph,

On Sun, 17 Apr 2016, Christoph Paulik wrote:

> git merge branch --no-commit does commit fast forward merges leaving
> users no way to change the merge results.

No, this is not a bug. Please note that a fast-forward does not perform a
commit at all (and therefore "does commit fast forward" is an inaccurate
description).

> The command only works as expected when also adding the --no-ff flag.

Then you need to fix your expectations ;-)

A fast-forward *avoids* committing altogether. In that light, the current
behavior is correct.

Ciao,
Johannes
