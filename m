From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Mark win32's pthread_exit() as NORETURN
Date: Wed, 2 Mar 2016 20:11:00 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603022010410.3152@virtualbox>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de> <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de> <56D5A955.8010904@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	tboegi@web.de
To: stefan.naewe@atlas-elektronik.com
X-From: git-owner@vger.kernel.org Wed Mar 02 20:11:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abCBO-0002T3-RE
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 20:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571AbcCBTLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 14:11:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:65186 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939AbcCBTL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 14:11:29 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LlDx4-1a0UF73QDG-00b0fG; Wed, 02 Mar 2016 20:11:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56D5A955.8010904@atlas-elektronik.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:uEmYpYN/oXTjXNyHZp0qMkeXBXolESzwWTQKEhMU8PQTOyczjsP
 bCHHKU+EDMrVN3x4zHJao5DwaL9wzuPx7bH/yUOLjq4EAtm74KhwBIgacvxzvxVIXfRD0Vl
 Gj4tNJLtgSoO1stL+Dzqtme66IIVgIYCFin4QKVe0KWDHfh2yFKAO1gw3zqbfXp6PrbwLrC
 2jtDy5VHsKYB6CswYg7zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jCmqXLBItLM=:rwn98sIFEwanhnrxOv8vvi
 TepJGSIfA/SvluU8ncdG1JrXZ6ssCWBLtZlnthBqHPzfDLkCYne6iM7wvK+/P/GANbevc8f2c
 rFUvh7t/nvBS789KLGRMlAyK2PygYjwZymFnTjrraPjV6DnTg30vo8YTT6RYc5bypxo/WJsvF
 52SEWyKbrUxLAcUAljqMD0GTkXOzv4RaaqDQHB36j7i/qIh5BRox0QQ8Z/2QmgZI9oIG8XVeS
 Lw9M6Ywdb1CIWLgXnhP0vFzvTNOQuNq2MuJWO4Fr6+qaVm84eEXrqTyhkhzgfehUTY9eMcS/0
 U9PwR5EyaqSg81tgFLj/vQdowcxH7py7gVToeUpE4OIhKvLPSm0JpPHZcdG+FsIi4lo5WS3+X
 FIMolVcYEw0Z95wA3dpiBIE1JWCpAXvi9oKc6p89SiVDbLoOqHTpWgGzwYwkh5d+t++2TssGO
 DWosNRBBGUXMYoOtX07ldWCHoNyeyYowgZ/cIewUNYXHfkWUz/WxSP2NnSKAssLT8SmhgJ8Zq
 5mgTZ+k6/0XVexD2864RtAcYahkaueb/EObi2KiImL4x8AVkWls6z+ntdzSQqi6elXCvOWYY5
 3htmbOJS9RNJD3tZTqUhuQdNXm1MDY3SO+x/QTkMS+uAmK3ntbeHAeiP3eKQfaRtGSDpo+Wfe
 2SzDPzO/qKxkamu/c69p2jAfFgQWNPzEWGJQID5QHKn+PExnOVOQt7nV6yQurOTjBL9t1fuEc
 dLDVtYmfqZdtqdm9v3uXSaXGID820V9zRxD7Qc950YWRSOfS/UeN459FYQyWWc56CzGw7DZo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288147>

Hi,

On Tue, 1 Mar 2016, stefan.naewe@atlas-elektronik.com wrote:

> Am 01.03.2016 um 15:13 schrieb Johannes Schindelin:
> > The pthread_exit() function is not expected to return. Ever. On Windows,
> > we call ExitThread() whose documentation claims: "This function does not
> > return a value.":
> 
> Does this really mean that ExitThread() does not return ?

I fixed the commit message in v3.

Thanks,
Dscho
