From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 6/8] longest_ancestor_length(): require prefix list
 entries to be normalized
Date: Tue, 06 Nov 2012 08:34:28 +0100
Message-ID: <5098BD84.8040109@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu> <1351440987-26636-7-git-send-email-mhagger@alum.mit.edu> <50901B31.7000402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVdgN-0007Ni-Ka
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 08:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab2KFHef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 02:34:35 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:44367 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752495Ab2KFHee (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2012 02:34:34 -0500
X-AuditID: 1207440d-b7f236d000000943-e3-5098bd89c407
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 86.DD.02371.98DB8905; Tue,  6 Nov 2012 02:34:33 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA67YSlL007367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Nov 2012 02:34:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <50901B31.7000402@ramsay1.demon.co.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqNu5d0aAwfR9UhYblq5htui60s1k
	0dB7hdniydy7zBZHT1lY/GjpYbbYPW0Bm8X6d1eZHTg8ds66y+7x8FUXu8ez3j2MHhcvKXs8
	nniC1ePzJrkAtihum6TEkrLgzPQ8fbsE7oz/v3wLlrFU/L67nLWBcQdzFyMnh4SAicT7hQ0s
	ELaYxIV769m6GLk4hAQuM0pcfP2IGcI5xiQxf+8LRpAqXgFtiXWv5rKB2CwCqhIfnzwHs9kE
	dCUW9TQzgdiiAmESa/YcYoKoF5Q4OfMJ2AYRoJrF806CDWUW+MUocWlGLytIQlggVWLlpY3s
	ENuWMEo0bp8C1sEpYCxx+fgVsM3MAjoS7/oeMEPY8hLb385hnsAoMAvJkllIymYhKVvAyLyK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIyQaeHcw/l8nc4hRgINRiYdXSGxG
	gBBrYllxZe4hRkkOJiVRXqHtQCG+pPyUyozE4oz4otKc1OJDjBIczEoivDu2AeV4UxIrq1KL
	8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8vbuBGgWLUtNTK9Iyc0oQ0kwcnCDD
	uaREilPzUlKLEktLMuJB0RpfDIxXkBQP0N4pIO28xQWJuUBRiNZTjLocHxvnPWQUYsnLz0uV
	EuetASkSACnKKM2DWwFLfa8YxYE+FuZdClLFA0ybcJNeAS1hAlqy/dIUkCUliQgpqQbGcLGH
	bXdy/vspGDp8Vln42W9ehsrhed15oSEPj215U2e94fqyu+HyLPOnTmr83Mb3d+YC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209100>

On 10/30/2012 07:23 PM, Ramsay Jones wrote:
> [...]
> Just to be clear, this is true for the MinGW port to Windows, but *not*
> the cygwin port.
>
> [...]
> 
> ditto

Thanks for clarifying these points.  It seems like this patch series is
not going to be usable (because of fears that it might cause performance
degradation in some as-yet-unexplained scenarios), but if that situation
seems to change then I will incorporate your corrections.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
