From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH RFC v2 00/19] Enable options --signoff, --reset-author
 for pick, reword
Date: Thu, 03 Jul 2014 12:33:22 +0200
Message-ID: <53B53172.4030803@alum.mit.edu>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 12:40:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2eRN-0005W1-HK
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 12:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbaGCKk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 06:40:29 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54975 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756955AbaGCKk1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2014 06:40:27 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jul 2014 06:40:27 EDT
X-AuditID: 12074411-f79d86d000006a97-f6-53b531759dc7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BA.B8.27287.57135B35; Thu,  3 Jul 2014 06:33:25 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0163.dip0.t-ipconnect.de [93.219.1.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s63AXMRZ030744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 3 Jul 2014 06:33:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqFtquDXYYNUhVotDc++xW3Rd6Way
	+NHSw2xx8JikA4vHzll32T2e9e5h9Jhy7z+rx+dNcgEsUdw2SYklZcGZ6Xn6dgncGc0b3zIX
	nOeuaNs1n6WBcQFnFyMnh4SAicTr+zdYIWwxiQv31rN1MXJxCAlcZpRoOHeXGcI5wyRx9tMi
	dpAqXgFtie8P3jCB2CwCqhLzvk4Hs9kEdCUW9TSD2aICQRKzP8+DqheUODnzCQuILSJgLnF8
	xyywOLOArcTbjnfMILawQKzEttMfGUFsIYEAiYuTIWxOoOtaFz8BqucAuk5coqcxCKJVR+Jd
	3wNmCFteYvvbOcwTGAVnIdk2C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmurl
	ZpbopaaUbmKEhLngDsYZJ+UOMQpwMCrx8DrabwkWYk0sK67MPcQoycGkJMpbobk1WIgvKT+l
	MiOxOCO+qDQntfgQowQHs5II7219oBxvSmJlVWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFq
	EUxWhoNDSYJXwQCoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UwfHFwBgGSfEA
	7ZUFaectLkjMBYpCtJ5iVJQS5+0HOUgAJJFRmgc3Fpa8XjGKA30pzKsP0s4DTHxw3a+ABjMB
	DWZjAhtckoiQkmpgtJkx4yhP7FrRY9vXeaSc/HNZyt71bu03/+N9Fw4eyr4qnhX368fT0FOu
	koKqX18znL+SvjX0/85Z7p1bbUwXMQkbdgb8cFTseeZ7PmhX2dYdV+76OtkVaR2e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252858>

On 07/02/2014 07:47 PM, Fabian Ruch wrote:
> [...]
>  2. Add user options to main commands
> 
>     Enable options --signoff, --reset-author for pick, reword (19/19)
> 
> The last stage was added in this reroll. It enables the parsing of
> line options for to-do list commands, which is still restricted to
> options without arguments because it is unclear how spaces can be
> parsed as characters rather than separators where needed. For
> instance, if we were to support
> 
>     pick --author="A U Thor" fa1afe1 Some changes
> 
> then read(1) would hand us the tokens `--author="A`, `U` and `Thor"`
> instead of `--author=A U Thor`, which we would want to relay to
> `do_pick`. Interpreting the shell quoting would help. However,
> eval(1) seems to disqualify itself as an interpreter because the
> to-do list entry could potentially contain any shell command line.
> This could be both a security and a usability issue. For this reason,
> the patch series still hasn't graduated from being RFC.
> [...]

It is not required that a patch series solves all of the problems in the
universe.  If these patches implements some useful features robustly,
and if there is no reason to expect that future enhancements will
require the user interface to be changed in a backwards-compatible way,
then there is no reason that this patch series has to be held as an RFC
hostage to some hypothetical future.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
