From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sun, 28 Jun 2015 08:46:44 +0200
Message-ID: <558F9854.5080605@alum.mit.edu>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com> <1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr> <xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com> <CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com> <CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com> <558F8B55.1070708@alum.mit.edu> <CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 08:51:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z96RB-0000IU-4b
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 08:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbbF1GrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 02:47:00 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53209 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282AbbF1Gq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jun 2015 02:46:57 -0400
X-AuditID: 12074413-f79bd6d000007ac2-89-558f98575d57
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 22.04.31426.7589F855; Sun, 28 Jun 2015 02:46:47 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2F50.dip0.t-ipconnect.de [93.219.47.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5S6kiSE007240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 28 Jun 2015 02:46:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqBs+oz/U4FuXrMXMmdYWt2e2MFt0
	XelmsmjovcJs8X/HAhaLJa8fMTuweVxtDvDYOesuu8exY63MHhcvKXt83iQXwBrFbZOUWFIW
	nJmep2+XwJ2xpfssY8FDwYrf/w8yNjC28XUxcnJICJhI3G69xA5hi0lcuLeerYuRi0NI4DKj
	xPyOuSwgCSGBc0wS/38VgNi8AtoSp+/fYwWxWQRUJabevMoMYrMJ6Eos6mlm6mLk4BAVCJJ4
	/TIXolxQ4uTMJ2BjRATUJCa2HWIBmc8s8J1R4tHn/2CLhQWcJKZ82s4MsXgis8TOHxAJToFA
	if/vDzGC2MwC6hJ/5l1ihrDlJZq3zmaewCgwC8mSWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1
	Wbc4OTEvL7VI11wvN7NELzWldBMjJNSFdzDuOil3iFGAg1GJh9dDtz9UiDWxrLgy9xCjJAeT
	kihvbzdQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv1gSgHG9KYmVValE+TEqag0VJnFdtibqf
	kEB6YklqdmpqQWoRTFaGg0NJgtd0OlCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlG
	PChW44uB0QqS4gHaawjSzltckJgLFIVoPcWoKCXOWwCSEABJZJTmwY2FJbBXjOJAXwrzHpkG
	VMUDTH5w3a+ABjMBDV7l3QcyuCQRISXVwOjjVSgTdTCJr0w9jc/LQ795bsehl3JdNT/lD0SW
	M84923mF1bYvwl7ekr3prOks5+vq0UJ7dndNy5B6NyWI/ehS7j3Wl2/PXHJ/38/9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272869>

On 06/28/2015 08:15 AM, Junio C Hamano wrote:
> On Sat, Jun 27, 2015 at 10:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>
>> I would like to remind everybody of my old claim that it would be
>> possible to teach `git bisect` to infer by itself which term means
>> "older" and which term means "newer":
>>
>>     http://article.gmane.org/gmane.comp.version-control.git/244036
> 
> But then one mistake at the beginning and the user will be on a wrong
> track during the whole bisect session, no? Unless you make absolutely
> clear when making the "intelligent" decision what Git inferred, that is.

Definitely, `git bisect` should tell the user what it inferred.

> For something complex like bisect, I highly suspect that a tool that is
> more intelligent than the end users (more precisely, a tool that it thinks
> it is more intelligent) would hurt them more than it helps them.

This isn't about making bisect "more intelligent than the end users". It
is about not forcing the user cumbersomely to spell out redundant
information because the tool is too stupid.

If I mark one commit "broken" and another commit "fixed", and the
"broken" commit is an ancestor of the "fixed" commit, then it is pretty
obvious that I am looking for the commit that caused the transition
"broken" -> "fixed". The same if I mark one commit "xyzzy" and the other
one "plugh".

I understand that the user might make a mistake when marking the initial
commits, but as soon as bisect says

    Commit <sha1-abbrev> is an ancestor of <sha1-abbrev>, so I
    will look for the commit that caused the transition from
    "xyzzy" to "plugh".

then I hope the user will notice and correct her/his mistake.

For example, a session could be started with

    git bisect start --mark=broken <committish> --mark=fixed <committish>

and from then on

    git bisect broken
    git bisect fixed

Or, if the user doesn't want to specify both endpoints on the `start` line,

    git bisect start
    git bisect --mark=broken [<committish>]
    git bisect --mark=fixed [<committish>]

Essentially, specifying `--mark=<name>` once would make `<name>` a
shorthand for `--mark=<name>`.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
