From: Anders Kaseorg <andersk@mit.edu>
Subject: Re: [PATCH] t5516-fetch-push: Correct misspelled pushInsteadOf
Date: Wed, 4 Mar 2015 04:43:23 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1503040439100.60859@buzzword-bingo.mit.edu>
References: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu> <xmqq385nb2yg.fsf@gitster.dls.corp.google.com> <54F5D869.4010104@drmicha.warpmail.net> <xmqq8ufdc0c7.fsf@gitster.dls.corp.google.com> <54F6D20D.903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:48:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT5v6-0003ZJ-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 10:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760860AbbCDJsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 04:48:42 -0500
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:60029 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759109AbbCDJsi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 04:48:38 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2015 04:48:37 EST
X-AuditID: 1209190e-f79bb6d0000030e8-1e-54f6d3bd14ef
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 16.6A.12520.EB3D6F45; Wed,  4 Mar 2015 04:43:26 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id t249hPqO032352;
	Wed, 4 Mar 2015 04:43:25 -0500
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id t249hNJD031227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 4 Mar 2015 04:43:24 -0500
In-Reply-To: <54F6D20D.903@drmicha.warpmail.net>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IR4hRV1t13+VuIwYmPHBZrXpxmtui60s1k
	0dB7hdmB2aN18iRmj4uXlD0+b5ILYI7isklJzcksSy3St0vgytj48xpLwVaOioOX1jE1MJ5k
	62Lk5JAQMJHoefCcBcIWk7hwbz1QnItDSGAxk8T3HU9ZIJwNjBLdiy8yQzi7mCRuNNxjAmlh
	EdCSWP1jGVg7m4CaxIejX1lBbBEBfYlr556A2cwC1hK73s0Es4UF3CWmfHvNDmJzChhITPu7
	DszmFfCQmPm3nQliwUdGiQ1N/5lBEqICuhKH/v1hgygSlDg58wkLxFB1iQOfLjJC2NoS92+2
	sU1gFJyFpGwWkrJZSMoWMDKvYpRNya3SzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECA5q
	Sb4djF8PKh1iFOBgVOLhzYj+FiLEmlhWXJl7iFGSg0lJlHfZJaAQX1J+SmVGYnFGfFFpTmrx
	IUYJDmYlEd7Yi0A53pTEyqrUonyYlDQHi5I476YffCFCAumJJanZqakFqUUwWRkODiUJ3nsg
	jYJFqempFWmZOSUIaSYOTpDhPEDDTUEW8xYXJOYWZ6ZD5E8xKkqJ8waAJARAEhmleXC9sKTz
	ilEc6BVh3maQKh5gwoLrfgU0mAlo8C3FLyCDSxIRUlINjDxcVm06rH9/zHx83TZJ96bnidp2
	/Q/dNa+2PO89ty1ogXmwXewNzvvBNx62GZs1xBbzfrd4M7PNt+ME/4RZrZtvOuQtPMjW+S5x
	idsMQV37bIkFf394by+sid8UsIBFeUJNyFej/Od7A95J9uU9cMtdPZv35s0dB86V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264741>

On Wed, 4 Mar 2015, Michael J Gruber wrote:
> If there is no "pushurl":
>   "url" will be used as the "URL for fetch" and as the "URL for push"=
=2E
>   if we are pushing and there is "pushinsteadof" for (part of) "url"
>     subsitute that within "url"
>   else if there is "insteadof" for (part of) "url"
>     substitute that within "url"
>=20
> If there is a "pushurl":
>   "url" will be used as the "URL for fetch" and "pushurl" as the "URL=
 for push".
>   if we are pushing and there is "insteadof" for (part of) "pushurl"
>     substitute that within "pushurl"
>   else if we are fetching and there is "insteadof" for (part of) "url=
"
>     substiute that within "url"

Speaking of that, I recently had to reimplement most of this logic for =
the=20
openstack git-review tool (https://review.openstack.org/160152), which =
is=20
why I was staring too closely at t5516 in the first place.  It would be=
=20
nice to have a =E2=80=98git ls-remote --get-push-url=E2=80=99 analogous=
 to the existing=20
=E2=80=98git ls-remote --get-url=E2=80=99.

Anders
