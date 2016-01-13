From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Wed, 13 Jan 2016 19:53:58 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601131953010.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de> <5695E4FB.2060705@web.de> <56967CA3.7040103@ramsayjones.plus.com>
 <xmqqh9ihpfav.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:54:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQZ4-00075p-7s
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566AbcAMSyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:54:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:59803 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbcAMSyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:54:09 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M5tof-1ZzoAr3hgP-00xu9l; Wed, 13 Jan 2016 19:54:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqh9ihpfav.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:QAgbP0rGjKfqtDB08hNL5F7bZSbkL4eg+wCGmSQnJzsrKJ3V9yW
 mAVNAPeGAOWxP+DDUpctBcsTQAl8zDVo/NaF42nlRIfpqJEDGN2WG0sePyQHObIew7T5m9T
 OhvfIXRqrEWKX93fKgl0rwp0WdjZccz3b3PRid8QJNAfhuVbXcNW5FxVuN6lTbANGnFbi96
 Uy07ambksCLConkN0t4eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UssrygRCRbg=:z5tAQ/I/VBzQeRiH8kScvo
 h1tLphGHYX43ANIoG6LHDIdYk9q1GR7b6X7rmmU6PRfLNJmqqRxgCG22VbrcD56hj90uRr58/
 FMFQIxrkDC4PBXWB+0e2oV75K1iVY3Mm4dJMGKmLsPBmfJ8vn2X0PQ/grMFlxEuWBEPUgCD/9
 GFdTOp1dQoDc7W588dEZcszC/KW/DjBABAMSWWa7V+tjv3/8DwqptXMHLCWgAjgtydf8bJtN3
 f5zDg4fuB/pfZ3ssPRCZX0qiDDm8gmpV4RZKQD1qHa4n+yoBLT5Ugcroq8yarwXsG5dmzMcEX
 WHRhOe68aiy1FpnGAeQul1vy9LozOkInNN8gKnBFgsIEibuSm9TS94LfC1hSLtvEKcQoipEak
 bkwzj7zofVUzyW9G1CEZ0P2eCILlmY6JYeAqgwpNLaUXWkXNIyFB2OfuWqWo8Vohjqp6e+zKA
 4RwGobN2P6gRc58tjUfgvnxiZScjiju++OxAzA5z2nV51J88n6z0jMCMUDP2QuAurG90zE6i3
 RtvYB+hGgbHY2YxwpeMuLENUxkp3EQoSiHK0HqaGxUzIilBwFspuLXcUEeQKFiplCoHa8V0s8
 uhWLgFeO3hYvXh/kvhRrp7Ej3rGixwEK0abJ3m9ICUSdQU3QVjh5qof0FPu7zLScz1onctzcl
 0+XxtY4dj8SOxBQ9OQs9RuR2Wz2sog/SzUsu3rqUTVFl3PXp9/0d88XkfXA+q4rSCYN/pQvwt
 2iIeUoHaX9ETZJIJatG+R8wZC+TdRZBDtW8z6Uc7NdzDTKRjveQ4/uiIcp6EBfOWzI3+GnhO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283968>

Hi Junio,

On Wed, 13 Jan 2016, Junio C Hamano wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > This particular section documents what is almost certainly a bug
> > in the cygwin basename() and also documents my choice of 'fix'.  (ie.
> > in my implementation I chose to return '/' for '//', which is one of
> > the possible options that POSIX allows.)
> > ...
> > POSIX says, in part [1]:
> >
> >     If the string pointed to by path consists entirely of the '/'
> >     character, basename() shall return a pointer to the string "/". If
> >     the string pointed to by path is exactly "//", it is
> >     implementation-defined whether '/' or "//" is returned.
> >
> > [1]
> > http://pubs.opengroup.org/onlinepubs/9699919799/functions/basename.html
> >
> > So we should expect other systems to differ, even if they support POSIX. (and maybe
> > not just this test case.)
> 
> Doesn't that mean the test shouldn't be insisting on the output
> being one that you arbitrarily pick?  It feels to me that it is
> wrong to say "We require // to become / unless we know we are on
> such and such systems".  Instead, shouldn't it be doing "We feed //
> to the function.  Either / or // is acceptable; any other value is a
> bug"?

I guess that is the best solution of all. I'll try to modify
test-path-utils.c accordingly tomorrow.

Ciao,
Dscho
