From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Our merge bases sometimes suck
Date: Sat, 14 Jun 2014 00:14:42 +0200
Message-ID: <539B77D2.3020307@alum.mit.edu>
References: <539A25BF.4060501@alum.mit.edu> <539AC690.6000906@drmicha.warpmail.net> <539B1E59.1030604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvZkH-0005jN-L3
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 00:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbaFMWOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 18:14:45 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58559 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741AbaFMWOo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 18:14:44 -0400
X-AuditID: 12074413-f79bc6d000000b9e-a5-539b77d45f36
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BD.85.02974.4D77B935; Fri, 13 Jun 2014 18:14:44 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB39AE.dip0.t-ipconnect.de [93.219.57.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5DMEgTr000683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 13 Jun 2014 18:14:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <539B1E59.1030604@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHulfHawwbrVnBZrXpxmtui60s1k
	seLqHGYHZo/WyZOYPXbOusvu8XmTXABzFLdNUmJJWXBmep6+XQJ3xuSJv5kKFvJXrFp1k6mB
	cSNPFyMnh4SAicTv8zdYIGwxiQv31rN1MXJxCAlcZpQ40PcRyjnPJLHx9nYmkCpeAW2J9d+P
	sIPYLAKqEq1/7zKC2GwCuhKLeprBakQFgiRmf57HDlEvKHFy5hMWkEEiAgsZJba8nsUMkhAG
	GrTgxV+wBiGBAolfZ3qA4hwcnAKaEp090iCmhIC4RE9jEIjJLKAusX6eEEgxs4C8RPPW2cwT
	GAVmIVkwC6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0UlNKNzFCAld4
	B+Ouk3KHGAU4GJV4eBkUZgcLsSaWFVfmHmKU5GBSEuWdmAsU4kvKT6nMSCzOiC8qzUktPsQo
	wcGsJML7JBsox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4GUHRqiQ
	YFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChK44uBcQqS4gHae6IMZG9xQWIuUBSi
	9RSjLseJJyfbmIRY8vLzUqXEeQtAigRAijJK8+BWwNLUK0ZxoI+FeVlALuEBpji4Sa+AljAB
	Lbm5eBbIkpJEhJRUAyOfyqy0y6kh722zFm79I3d20uXV1yQ2rVDsC+6sC817WxsoHsQnJWuf
	FvRs3rTt4mXBJ1m38n1vZ/tz4dtZg09WdhYyMiLXDu2TalnLbWpz1HnnzdVl+wPu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251644>

On 06/13/2014 05:52 PM, Jakub Nar=C4=99bski wrote:
> I don't know if it has been fixed, but there is a difference
> between "git diff A...B" when A and B have one merge base, and
> "git diff A...B" when there are more than one merge base.
>=20
> When there is one merge base, "git diff A...B" returns simple
> unified diff equivalent to "git diff $(git merge-base A B) B".
> It is unsymmetric.
>=20
> But where there are more than one merge base, by design or by
> accident for "git diff A...B" git 1.9.2 / 1.7.4 returns
>=20
>    git diff --cc $(git merge-base --all A B) A B
>=20
> which is *symmetric*, and is combined not unified diff.

Thanks for the information.  This doesn't seem to be the case in git
2.0.0.  For example, commit 8c0db2f519 in the git project is a merge
with two merge bases:

$ git --version
git version 2.0.0
$ c=3D8c0db2f5193153ea8a51bb45b0512c5a3889023b
$ git merge-base --all $c^1 $c^2
a15f43312f6962959e8daa33df0cf5357852a4b8
9a0e6731c632c841cd2de9dec0b9091b2f10c6fd
$ git diff $c^1...$c^2 | head -20
diff --git a/Documentation/git-rev-parse.txt
b/Documentation/git-rev-parse.txt
index d638bfc..29b5789 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -77,6 +77,14 @@ OPTIONS
 	path of the top-level directory relative to the current
 	directory (typically a sequence of "../", or an empty string).

+--git-dir::
+	Show `$GIT_DIR` if defined else show the path to the .git directory.
+
+--short, --short=3Dnumber::
+	Instead of outputting the full SHA1 values of object names try to
+	abbriviate them to a shorter unique name. When no length is specified
+	7 is used. The minimum length is 4.
+
 --since=3Ddatestring, --after=3Ddatestring::
 	Parses the date string, and outputs corresponding
 	--max-age=3D parameter for git-rev-list command.
diff --git a/git-archimport.perl b/git-archimport.perl

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
