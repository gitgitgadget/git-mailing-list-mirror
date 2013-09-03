From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Tue, 03 Sep 2013 06:05:40 +0200
Message-ID: <52256014.70203@alum.mit.edu>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com> <7vhae7k7t1.fsf@alter.siamese.dyndns.org> <CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com> <CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com> <CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com> <xmqqeh9b15x6.fsf@gitster.dls.corp.google.com> <xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com> <5224F0EE.1080205@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 06:13:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGhzD-0000mp-OU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 06:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab3ICEMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 00:12:48 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53947 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751391Ab3ICEMr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Sep 2013 00:12:47 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2013 00:12:47 EDT
X-AuditID: 1207440c-b7f016d000005997-c7-522560191621
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 99.7F.22935.91065225; Tue,  3 Sep 2013 00:05:45 -0400 (EDT)
Received: from [192.168.69.9] (p57A2446A.dip0.t-ipconnect.de [87.162.68.106])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r8345fcX006583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Sep 2013 00:05:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <5224F0EE.1080205@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqCuZoBpksPiZqsXBx3kWXVe6mSwa
	eq8wWzyZe5fZgcVj56y77B4PX3Wxe1y8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfGmV1tTAXf
	FCouLNjB1sB4R6qLkZNDQsBE4s31n8wQtpjEhXvr2boYuTiEBC4zSiy5+I4FwjnDJLFs+g1W
	kCpeAU2Jh8c+g3WwCKhKvD29hRHEZhPQlVjU08wEYosKhEnsmD6RDaJeUOLkzCcsILaIgKHE
	3vapYDazQKnEo1M/wGYKC3hLTOzrY4RYtp9ZYu2lOWBFnAIaEt/27mWFaNCReNf3gBnClpdo
	3jqbeQKjwCwkO2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJN
	jJCA5tnB+G2dzCFGAQ5GJR7ehP0qQUKsiWXFlbmHGCU5mJREefNiVYOE+JLyUyozEosz4otK
	c1KLDzFKcDArifAKfQMq501JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ
	8GrFAw0VLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VrfDEwXkFSPEB72UDaeYsL
	EnOBohCtpxh1Od41zfvEKMSSl5+XKiXO6w5SJABSlFGaB7cClr5eMYoDfSzMywVSxQNMfXCT
	XgEtYQJacm2iIsiSkkSElFQDoz+nTOthlQSJ96uMH16231zreepa9Ruhf/7mgXd2CWhXlh33
	KWPdOKV9+XuxrkMtF+3bp938FnE5RqD1SfuH9oJSuzC+Px0PnmulT7+w7bGrx8rK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233678>

On 09/02/2013 10:11 PM, Johannes Sixt wrote:
> Am 31.08.2013 01:55, schrieb Junio C Hamano:
>> People often find "git log --branches" etc. that includes _all_
>> branches is cumbersome to use when they want to grab most but except
>> some.  The same applies to --tags, --all and --glob.
>>
>> Teach the revision machinery to remember patterns, and then upon the
>> next such a globbing option, exclude those that match the pattern.
>>
>> With this, I can view only my integration branches (e.g. maint,
>> master, etc.) without topic branches, which are named after two
>> letters from primary authors' names, slash and topic name.
>>
>>     git rev-list --no-walk --exclude=3D??/* --branches |
>>     git name-rev --refs refs/heads/* --stdin
>>
>> This one shows things reachable from local and remote branches that
>> have not been merged to the integration branches.
>>
>>     git log --remotes --branches --not --exclude=3D??/* --branches
>>
>> It may be a bit rough around the edges, in that the pattern to give
>> the exclude option depends on what globbing option follows.  In
>> these examples, the pattern "??/*" is used, not "refs/heads/??/*",
>> because the globbing option that follows the -"-exclude=3D<pattern>"
>> is "--branches".  As each use of globbing option resets previously
>> set "--exclude", this may not be such a bad thing, though.
>=20
> I argued "--except should trump everything" earlier, but the case
> involving --not
>=20
>   --branches --except maint --not master
>=20
> to mean the same as
>=20
>   --branches --except maint master
>=20
> just does not make sense.
>=20
> An alternative would be that --not would divide the command line
> arguments into ranges within which one --except would subtract
> subsequent refs from earlier globbing arguments in the same range.
> That's not simpler to explain than your current proposal.
>=20
> So I like the relative simplicity of this approach. Here is a bit of
> documentation.
>=20
> --- 8< ---
> Subject: [PATCH] document --exclude option
>=20
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Documentation/rev-list-options.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-l=
ist-options.txt
> index 5bdfb42..650c252 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -174,6 +174,21 @@ parents) and `--max-parents=3D-1` (negative numb=
ers denote no upper limit).
>  	is automatically prepended if missing. If pattern lacks '?', '{aste=
risk}',
>  	or '[', '/{asterisk}' at the end is implied.
> =20
> +--exclude=3D<glob-pattern>::
> +
> +	Do not include refs matching '<glob-pattern>' that the next `--all`=
,
> +	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
> +	consider. Repetitions of this option accumulate exclusion patterns
> +	up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
> +	`--glob` option (other options or arguments do not clear
> +	accumlated patterns).
> ++
> +The patterns given should not begin with `refs/heads`, `refs/tags`, =
or
> +`refs/remotes` when applied to `--branches`, `--tags`, or `--remotes=
`,
> +restrictively, and they must begin with `refs/` when applied to `--g=
lob`

s/restrictively/respectively/

> +or `--all`. If a trailing '/{asterisk}' is intended, it must be give=
n
> +explicitly.
> +
>  --ignore-missing::
> =20
>  	Upon seeing an invalid object name in the input, pretend as if
>=20

It seems to me that this is growing into a language for expressing
boolean expressions without allowing terms to be combined in the full
generality that, say, a real programming language would allow.  Maybe
instead of trying to decide on the "perfect" grouping and precedence
rules, it would be clearer to allow the user to specify them.  I almost
hate to suggest it, but have you considered making the expression
"syntax" a little bit more flexible by allowing parentheses, =E0 la
find(1), or something analogous?:

'(' --tags --except=3D'v[0-9]*' ')' -o '(' --branches --except=3D'mh/*'=
 ')'

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
