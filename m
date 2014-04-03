From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/22] Lockfile refactoring and pre-activation
Date: Thu, 03 Apr 2014 13:42:35 +0200
Message-ID: <533D492B.9090505@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <20140401204447.GJ21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 14:58:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVg2e-0002Qc-MW
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 13:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbaDCLmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 07:42:40 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45833 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751832AbaDCLmj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2014 07:42:39 -0400
X-AuditID: 1207440d-f79d86d0000043db-aa-533d492e9d1b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BB.51.17371.E294D335; Thu,  3 Apr 2014 07:42:38 -0400 (EDT)
Received: from [192.168.69.148] (p5B1562A0.dip0.t-ipconnect.de [91.21.98.160])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s33BgaaW007532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 3 Apr 2014 07:42:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <20140401204447.GJ21715@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqKvnaRtssG6ijkXXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7oxXk46wFyxkrbj49hV7A+Mk
	li5GTg4JAROJCe/uMkPYYhIX7q1n62Lk4hASuMwocWrBO2YI5yyTxKupPUwgVbwC2hJLN3eB
	dbAIqEpcPTSPHcRmE9CVWNTTDFYjKhAkcXjDKVaIekGJkzOfgG0TEZCV+H54IyOIzSxgLbHi
	9WGwemEBJ4mtrdvA4kICRRIPbrSBxTmBak5sOgN0EQfQdeISPY1BICazgLrE+nlCEFPkJba/
	ncM8gVFwFpJlsxCqZiGpWsDIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10gvN7NELzWldBMj
	JJx5dzD+XydziFGAg1GJh9dCyiZYiDWxrLgy9xCjJAeTkigvk7ttsBBfUn5KZUZicUZ8UWlO
	avEhRgkOZiUR3nVWQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv
	GZChgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDojS8Gxi9IigdoLy9IO29xQWIu
	UBSi9RSjLseGbWsamYRY8vLzUqXEeS+AFAmAFGWU5sGtgCWvV4ziQB8L894CqeIBJj64Sa+A
	ljABLeFeZwWypCQRISXVwOg4S0fGaB2LmkHqk+cNfW++RkZ5Zqy45K+9NfKWW2Jap6XH/58C
	BeomZXzZlqeETBts5y+/9ou/p3jnRfP9c1KW3lmVnb3lSVbYfabZDz4+mtAwsfHR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245732>

On 04/01/2014 10:44 PM, Jeff King wrote:
> [...]
> I think all of the patches look good. I'd prefer to hold back the final
> one (and probably 19/22, which has no purpose except to prepare for
> 22/22) until seeing its application in practice.

OK, I shuffled 19/22 to the end of the patch series, just before 22/22.
 That way both can be taken or left (probably left for now).

> Thanks for a very pleasant read.

Thanks for being a very pleasant (and thorough) reader :-)

I'm still working on the backlog of comments and then I'll get back to
the list with v2.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
