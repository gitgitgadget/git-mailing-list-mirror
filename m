From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying
 HEAD~<number>
Date: Mon, 03 Mar 2014 10:16:49 +0100
Message-ID: <53144881.6090702@alum.mit.edu>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com> <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-3-git-send-email-pclouds@gmail.com> <CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com> <CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com> <vpqlhwsr3ww.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 10:17:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKOzh-0003YT-06
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 10:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbaCCJQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 04:16:58 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60676 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753951AbaCCJQz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 04:16:55 -0500
X-AuditID: 1207440d-f79d86d0000043db-c7-531448861e9b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 12.8A.17371.68844135; Mon,  3 Mar 2014 04:16:54 -0500 (EST)
Received: from [192.168.69.148] (p57A2466F.dip0.t-ipconnect.de [87.162.70.111])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s239GoTt001322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 3 Mar 2014 04:16:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <vpqlhwsr3ww.fsf@anie.imag.fr>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsUixO6iqNvmIRJssOKztkXXlW4mi0uf17Na
	dE95y2jxo6WH2aJzqqzFmTeNjA5sHjtn3WX3mPjlOKvH8qXrGD2e9e5h9Fj8wMvj8ya5ALYo
	bpukxJKy4Mz0PH27BO6MYwuWMxd08lW07JvE2sC4nLuLkZNDQsBE4tznHcwQtpjEhXvr2boY
	uTiEBC4zSkw8sooZwjnHJLHs9SSmLkYODl4BbYnlk01BGlgEVCUW3DjEBGKzCehKLOppBrNF
	BYIlVl9+wAJi8woISpyc+YQFpFVEQF/i52Q2kDCzwB9GiaXbc0BsYYEoiedLutghVl1lkjh1
	+g3YQZxAq2bt6WAH6ZUQEJfoaQwCMZkF1CXWzxOCGCMv0bx1NvMERsFZSJbNQqiahaRqASPz
	Kka5xJzSXN3cxMyc4tRk3eLkxLy81CJdI73czBK91JTSTYyQOODdwfh/ncwhRgEORiUeXoOl
	wsFCrIllxZW5hxglOZiURHlfu4kEC/El5adUZiQWZ8QXleakFh9ilOBgVhLhzV8GVM6bklhZ
	lVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuAtcwcaKliUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+K3fhiYPSCpHiA9vKCtPMWFyTmAkUhWk8x6nLcbvv1iVGIJS8/
	L1VKnHczyOECIEUZpXlwK2BJ7xWjONDHwrxBIKN4gAkTbtIroCVMQEu6DcGWlCQipKQaGIu2
	/uk3OZEgVLvrgfSt/+bbVhwzMjGx3xD+OIdhXiXLU/GtO5Z8axY+bMBu2lc886dK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243203>

On 03/02/2014 04:55 PM, Matthieu Moy wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
>> On Sun, Mar 2, 2014 at 3:53 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>>> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>>> This is "rev-list style", where people can do "git rev-list -3" in
>>>> addition to "git rev-list HEAD~3". A lot of commands are driven by=
 the
>>>> revision machinery and also accept this form. This addition to reb=
ase
>>>> is just for convenience.
>>>
>>> I'm seeing some pretty strange results with this. If I use -1, -2, =
or
>>> -3 then it rebases the expected commits, however, -4 gives me 9
>>> commits, and -5 rebases 35 commits. Am I misunderstanding how this
>>> works?
>>
>> Nevermind. I wasn't paying attention to the fact that I was attempti=
ng
>> to rebase merges.
>=20
> Your remark is actually interesting. Most (all?) Git commands taking
> -<n> as parameters act on n commits, regardless of merges.
>=20
> So, this commit creates an inconsistency between e.g. "git log -3" (s=
how
> last 3 commits) and "git rebase -3" (rebase up to HEAD~3, but there m=
ay
> be more commits in case there are merges).
>=20
> I don't have a better proposal, but at least the inconsistancy should=
 be
> documented (e.g. "note that this is different from what other command=
s
> like 'git log' do when used with a -<number> option since ..." in the
> manpage).

This might be a reason that "-NUM" is a bad idea.

Or perhaps "-NUM" should fail with an error message if any of the last
NUM commits are merges.  In that restricted scenario (which probably
accounts for 99% of rebases), "-NUM" is equivalent to "HEAD~NUM".

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
