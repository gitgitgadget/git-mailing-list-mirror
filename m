From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [git-multimail] smtplib, check certificate
Date: Fri, 22 Apr 2016 08:41:36 +0200
Message-ID: <5719C7A0.50403@alum.mit.edu>
References: <571949D2.10507@le-huit.fr> <vpqoa92rxew.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Simon P <simon.git@le-huit.fr>
X-From: git-owner@vger.kernel.org Fri Apr 22 08:48:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atUtb-0008AP-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 08:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcDVGsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 02:48:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59084 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760AbcDVGsu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 02:48:50 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Apr 2016 02:48:50 EDT
X-AuditID: 12074411-e2bff70000000955-5a-5719c7a31d05
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 32.BE.02389.3A7C9175; Fri, 22 Apr 2016 02:41:39 -0400 (EDT)
Received: from [192.168.69.130] (p548D60EC.dip0.t-ipconnect.de [84.141.96.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3M6fb3g001088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 22 Apr 2016 02:41:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <vpqoa92rxew.fsf@anie.imag.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLv4uGS4wcNNJhZdV7qZLC59Xs9q
	0bHiDJsDs8fEL8dZPT4/a2Xx+LxJLoA5itsmKbGkLDgzPU/fLoE74+TH80wFW1grTsx2bWA8
	zNLFyMkhIWAicfD7O9YuRi4OIYGtjBIbTs9mhHDOM0ncmDWJCaRKWMBcYvHrVnYQW0QgQuLI
	hCPMILaQgJvE8afNYDXMAuIS6+aeB6thE9CVWNQDEufg4BXQlOic4AsSZhFQlVj9+hNYq6hA
	iMS2dd9YQWxeAUGJkzOfgB3EKaAtsX/LGzaIkXoSO67/YoWw5SW2v53DPIGRfxaSlllIymYh
	KVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyREBXcwzjgpd4hRgINR
	iYf3Q4NkuBBrYllxZe4hRkkOJiVRXoVtQCG+pPyUyozE4oz4otKc1OJDjBIczEoivBbHgHK8
	KYmVValF+TApaQ4WJXFeviXqfkIC6YklqdmpqQWpRTBZGQ4OJQleBmAsCgkWpaanVqRl5pQg
	pJk4OEGGc0mJFKfmpaQWJZaWZMSD4jG+GBiRICkeoL3vwfYWFyTmAkUhWk8x6nIs+HF7LZMQ
	S15+XqqUOO/Fo0BFAiBFGaV5cCtgCekVozjQx8K8j0BG8QCTGdykV0BLmICW8N8VBVlSkoiQ
	kmpg5LL6xMZhwcsZrGD0wOf8aYOM9Ua692S3VPacPXJSbcae2m7jvo68eQc4t5Xl7Drx9qVX
	v56YzFXJJw8mPHquyWud9Zlh4SzDr91Pnv86lrbq93L/d0vkp8tef3N26/NPazy+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292176>

On 04/22/2016 08:05 AM, Matthieu Moy wrote:
> Simon P <simon.git@le-huit.fr> writes:
> > This patch is inspired from
> > 
> > https://github.com/graingert/secure-smtplib/blob/master/src/secure_smtplib/__init__.py
> 
> Please, add your sign-off and a proper commit message to your patch,
> see:
> 
> https://github.com/git-multimail/git-multimail/blob/master/CONTRIBUTING.rst

I hate that we even have to worry about this stuff, but
graingert/secure-smtplib looks to be GPLv3, whereas git-multimail is
GPLv2 (like the Git project and Linux); *not* "GPLv2 or later". So if
"inspired" means "incorporated copyrightable content" then this patch
might be problematic.

Michael
