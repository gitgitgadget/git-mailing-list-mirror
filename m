From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 11:59:21 +0200
Message-ID: <52060EF9.2040504@alum.mit.edu>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de> <20130809194214.GV14690@google.com> <20130809223758.GB7160@sigill.intra.peff.net> <20130809231928.GY14690@google.com> <20130810064717.GB30185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 11:59:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V85xg-0000QM-Nr
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 11:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968533Ab3HJJ7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 05:59:41 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45839 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968527Ab3HJJ70 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Aug 2013 05:59:26 -0400
X-AuditID: 12074414-b7f626d0000001f1-de-52060efd8093
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E2.47.00497.DFE06025; Sat, 10 Aug 2013 05:59:25 -0400 (EDT)
Received: from [192.168.69.140] (p57A2557F.dip0.t-ipconnect.de [87.162.85.127])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7A9xMEQ009955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 10 Aug 2013 05:59:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130810064717.GB30185@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqPuXjy3I4M5RGYuuK91MFm9vLmG0
	+L9jAYvFj5YeZotn/b8ZHVg9ds66y+5x7Fgrs8fdBk2PZ717GD0+b5ILYI3itklKLCkLzkzP
	07dL4M64u7qZtWAGW8XEC54NjA2sXYycHBICJhLrns1gg7DFJC7cWw9kc3EICVxmlOh8cpQV
	wjnPJHFv/0UWkCpeAW2JH4cbGEFsFgFViUsnX4LZbAK6Eot6mpm6GDk4RAXCJK78VoUoF5Q4
	OfMJWKuIgKzE98MbGUFmMgt0M0os2bKJCSQhLOAo8f3xLCaIZW8YJU4dPQuW4BSwlnjx5g8j
	yFBmAXWJ9fOEQMLMAvIS29/OYZ7AKDALyY5ZCFWzkFQtYGRexSiXmFOaq5ubmJlTnJqsW5yc
	mJeXWqRroZebWaKXmlK6iRES4CI7GI+clDvEKMDBqMTDO+EXS5AQa2JZcWXuIUZJDiYlUd4e
	HrYgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8Z56zBgnxpiRWVqUW5cOkpDlYlMR5vy1W9xMS
	SE8sSc1OTS1ILYLJynBwKEnwMgMjWUiwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMe
	FKfxxcBIBUnxAO1N4gVq5y0uSMwFikK0nmLU5XjXNO8ToxBLXn5eqpQ4LyfIDgGQoozSPLgV
	sHT2ilEc6GNh3nKQUTzAVAg36RXQEiagJdMPs4AsKUlESEk1MK6L8zn+9bikb/OV8rKG+vTr
	e40uBxUcumyx0H1f+CzOPwEvd7cUTfBtbv2wsyelU1Bv87d/u2wC/vhXzTkoK84d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232085>

On 08/10/2013 08:47 AM, Jeff King wrote:
> But I think MX records and deliverability is beside the point. Even in a
> case where we come up with a valid, deliverable address, is that what
> the user wants to have in their commit history for all time?

I intentionally don't set user.email in my ~/.gitconfig because I use
different identities (on the same machine) depending on what project I
am committing to (open-source vs. work).  After I clone a repo, I *rely*
on Git reminding me to set user.email on my first commit, because I
invariably forget to set it myself.  And for me, *any* universal,
heuristically-determined email address would be wrong for me for at
least some repos.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
