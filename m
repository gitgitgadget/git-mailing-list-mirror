From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 21:09:32 +0100
Message-ID: <5488A87C.4030505@alum.mit.edu>
References: <1417830678-16115-1-git-send-email-sbeller@google.com> <20141206020458.GR16345@google.com> <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com> <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com> <20141209201713.GY16345@google.com> <20141209202738.GC12001@peff.net> <20141209222337.GA16345@google.com> <20141210084351.GA29776@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:09:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyna2-0005NQ-5O
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 21:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbaLJUJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 15:09:44 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49839 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755357AbaLJUJn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 15:09:43 -0500
X-AuditID: 1207440e-f79d26d000001b6e-13-5488a880b653
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id AC.70.07022.088A8845; Wed, 10 Dec 2014 15:09:36 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0BBF.dip0.t-ipconnect.de [93.219.11.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBAK9XHW025452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Dec 2014 15:09:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141210084351.GA29776@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqNuwoiPE4P0cLouuK91MFg29V5gt
	3t5cwmjxo6WH2WLz5nYWB1aPnbPusnss2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ9w7uJK5YC53xeNNe9gbGH9zdDFyckgImEicfXifGcIWk7hwbz1bFyMXh5DAZUaJ348+
	gSWEBM4zSWx9qwRi8wpoS0xfdoQVxGYRUJW4v/0GWA2bgK7Eop5mJhBbVCBI4uSe6+wQ9YIS
	J2c+Yeli5OAQEXCWuL1eHmQ+s0ADo8SHA5vZQGqEBfQlju9sZIRY/IxJov3oBBaQBKeAnsS2
	H5vAbGYBdYk/8y4xQ9jyEs1bZzNPYBSYhWTHLCRls5CULWBkXsUol5hTmqubm5iZU5yarFuc
	nJiXl1qka6yXm1mil5pSuokREuJ8Oxjb18scYhTgYFTi4V1xtT1EiDWxrLgy9xCjJAeTkijv
	4TkdIUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeHcvAMrxpiRWVqUW5cOkpDlYlMR51Zao+wkJ
	pCeWpGanphakFsFkZTg4lCR4+5cDNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSD
	YjW+GBitICkeoL3+IO28xQWJuUBRiNZTjIpS4rwZIAkBkERGaR7cWFjiesUoDvSlMC8nSBUP
	MOnBdb8CGswENPhFYivI4JJEhJRUA2OjQtMVgz7xSj075v3n0hI6fEtyNivMuHnskORiOcGO
	l943PerPvH+h1X7fKVPYILirPj9lUozCsq/TDjMXTlsidEr2vXSnsnvUtGm8k8/v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261243>

My vote is for putting the API docs in the header files:

* Functions are documented right next to their declarations (which the
compiler guarantees are up-to-date), removing ambiguity and avoiding
some redundancy.

* It is obvious at a glance which functions are documented and which
still need docs.

* It is easier to remember to update the documentation when it is near
the code, and easier for reviewers to remember to pester authors to do so.

I also like it when function declarations in header files include the
names of their parameters, as (1) it's an efficient way to give the
reader a good hint about how the function should be used, and (2) it
makes it easier to refer to the parameters from the docstring.

I agree that there is an important need for introductory/conceptual
documentation about and API, but I think this fits fine as a large
docstring at the top of the header file.

I personally don't have much use for formatted documentation but if that
were a need I would think that a standard tool like doxygen could be used.

I have been trying hard to add good header-file docstrings for code that
I have worked on, and even for code that I had to read because I needed
to figure out how to use it. I would find it a pity for that work to be
squashed into Documentation/technical/api-*.txt, where in my opinion it
is less discoverable and more likely to fall into disrepair.

Michael
