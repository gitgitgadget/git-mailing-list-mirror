From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Fix interactive rebase when the editor saves with
 CR/LF
Date: Tue, 27 Oct 2015 10:34:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510271031000.31610@s15462909.onlinehome-server.info>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <cover.1445782122.git.johannes.schindelin@gmx.de> <xmqqpp02kbif.fsf@gitster.mtv.corp.google.com> <alpine.DEB.1.00.1510261133030.31610@s15462909.onlinehome-server.info>
 <xmqqsi4xh298.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:34:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0eI-0006ur-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbbJ0JeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:34:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:53540 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbbJ0JeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 05:34:24 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0Lp8h6-1aTeqV1aOy-00eq9T;
 Tue, 27 Oct 2015 10:34:19 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqsi4xh298.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:9VPEpNdZ2rHwUnre1r6GHe3moiOK4R0WrnCgOOE4xgDKQCcrhR8
 q3DEaTuvgtOnOCfBOJsBSVFof5CjkRRcE6msEGuYOeQc7QFfk37U0y9pbusp+mpT4JB+wN1
 DGHSbwnOwXVAVoF2nw/c4OdQnUbEIv2osBKWUBnsDX1MPyHZE3V1/kzX9WzOP5bVq9JhXwT
 vamcbw3NF1P1Z+oGFvOEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kTppnKHu/v8=:LLP1uAx9wQXykfZGq1Kyzj
 uyubev0fQExYzEvHtL2buJM9jG0KgaxSvxVfnLfyJ9/uW4hgLU+9h3MHdHo+4ZFCn0L2gNnHy
 XJPSN1CT7UZ8D+H69tHWxf7gtqHDd0cIXHA8Sj8gB+obwKcTR0yqyRdMIt2IefxJNVkFBdUnV
 /weSWuYaHTxNYP0Fj8y1tOj0mL+fj5xcUTWSzu2icTeDCUvEomtg349LG7f8x6m9nG37sSJGQ
 EZg+aZ60gXsy8mVsAs+9QJV7AYCKSOr+Qe1/dyIFUQDRsuNFdcDXcH6PqNUTw1tRUnoKqv7Zu
 xPBgf1hHxe/61C2QUdaIWA/a/4aPeGOlExqGIJtf2oK9gF8QlwaKEYMeGXWsdf8cOnemlLlNu
 3VhII5qKKzZ7taDGix6+W9cYih5+rpxRhGZT3B/C5SyX480t3D0GH9S0lBJc2gGIb5u2AjraT
 ecxl2VP0cUbNb3wIAPUJgLwWlLkg6Veye9tb3yrSCbeDg2OgAa6V6HQmYl67WXvy0XMkpTUzq
 rfo61gEfrH/cXNRdx/MrfLLP68GKhAfsclmnSYqGuMpkhacboVmTBpjbPyvw6Bywu1bxHIKVk
 8mHOUgKn0/y3Cfty7kj/QhMJJG/iBNic0+CdKXo33xdRg+wj7ZvTgrwV8niiHCqvuga8aXlpx
 U8z++7Gpuwf5HNROlSbFA0121Qt90UXeqbFij/LTtG3z6eUN2LA/I3EFGzRnjGf1CZIzR9tRP
 dTxnTyKPPs6/R+i/K5rxmO4T/5hJ5ppkVMTVV/pYLKgqg9cAe7x2aAXPa7zMWJx7tXUf0VVB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280250>

Hi Junio,

On Mon, 26 Oct 2015, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > A simple test with CR/LF line endings in a script reveals that it is
> > pretty solid:
> >
> > 	x=a
> > 	case "$x" in a) echo b;; esac
> >
> > prints out 'b', as expected.
> 
> I do not see what this has to do with anything.

You probably missed the context. Brian pointed out that my patch said
"printf ''" when it should have said "printf '\n'". I responded that my
commit says the right thing, but somewhere along the lines of transforming
beautiful Git commits into mails it must have been lost.

The explanation you quoted is the essence of the problem of my script to
prepare mails for submission to the mailing list: the script works in
Bash, but fails in Dash. And as my script has the shebang "#!/bin/sh" and
as Ubuntu defaults to using the Dash as its /bin/sh, we now have the full
explanation why my first mail showed an incorrect patch.

Ciao,
Johannes
