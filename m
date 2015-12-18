From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] mingw: emulate write(2) that fails with a EPIPE
Date: Fri, 18 Dec 2015 17:10:48 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512181709310.6483@virtualbox>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de> <ca357ac83a9990d6c88b637b76c6cc7f30d3f7be.1450372051.git.johannes.schindelin@gmx.de> <xmqqwpscc22e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 17:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9xcZ-0000kp-3L
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 17:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbbLRQLC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 11:11:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:49379 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbbLRQLA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 11:11:00 -0500
Received: from virtualbox ([37.24.143.211]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MOkQc-1a504h3Db4-0063Mc; Fri, 18 Dec 2015 17:10:53
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqwpscc22e.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:iSi+r/y9q6Asp+LZwLKO7z9cwsr/7hb+xBztTRviwN19vG5WnNu
 PfXdZC+a+L6mkXevrN5O2iUkEDsSgQNFXEQi3UGJg3gg/QNYZRpZe+119dQUIMmJn3U81+I
 4NdhymiDyiZD2m+IDESJR0mXtNduv3psBO/S1lU2AcjNlMIs/haO8k6xgs3+Y+ALuO/R6XD
 MFuX6ZZuf2KVyatsR0JRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pbq7hsPHVP0=:rNXNIN5LkH89Axok9WgHxh
 Mihj6GPfitwqHijsCiX73SSv+BCErOsytBC0d9c41leVOX8UxgHKZwleM0+22i6sGdC0cXOKq
 aiVwqlwQSl7NcgqMifNFUwosgKwEuPSBF+7ef2CPXc4SZOc2jdxTeWaKoUzVZNNqXr8/FVMGp
 vZxQFK3c7dfcBQTHz5Ckj9zY4qzEPa3Uw/LZmRkiQMcZHL6y7GJqTkbGo+NYlJSPbQ9uzYQ50
 /R5Vz1ZtrP2gU3kutwyQFctYiJQ+6MkCS0Ag4E+s9URsOtl4PuoocTl1izaxkD9VpXt29AWt5
 7cfeR8Jd2wHLBZU1uyF6ytb0+G26mQQ6va2gqwno4RXO5q5Y4wJo9/put0RuntVEIbaztkQ5m
 +ZTzWATBunVHyGF+TI6NRCqeqCcDdBgJ3dh3tS2T+p3MCXqcmzRxns28gU0v2lrJ3ieuqhgpF
 4y9LjC167b/yLVrIdiy4aq2TkZQmBo6QJV7qYNQ+B4shZAXzYwvk7wnL0CzvzCIK5o83Sm+JL
 O315VdEeXmrFHbUiQltQIEhtrLOq0hb/LhKOTjrbc2sqjVtBzxDYXVurNiCl6TeSzzuE3ULB3
 sTlFZG9bHNomlN6QK6PBYzCJg8Ay7YwryKXbkkTlD24d2d6jWwDWfpHdlHDH12mReqClq0STR
 JuLdMHr4bctDTFudmIaJh8ojGmvG7ZRqgWRlnsx1GN2cOQp+m6ONSAxpFazteY8nvO/KUW0lV
 2M4bsx4mtqLouioB4UFj1lmZAZdpC/SLGgSE5aoeYijOnT77WPSHVxDG0ZubsMgx0hJvYNzE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282707>

Hi Junio,

On Thu, 17 Dec 2015, Junio C Hamano wrote:

> PLEASE DON'T DO THE BELOW TO THE SAME MESSAGE AS THE PATCH ITSELF.
> "git apply" would not read and understand the next line as a natural
> language sentence for obvious reasons.
> 
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Interdiff vs v1:

Whoops. This is an obvious bug in my patch series submission script. Will
fix.

Sorry,
Dscho
