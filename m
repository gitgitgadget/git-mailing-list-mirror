From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from
 repo.git/config
Date: Tue, 02 Jul 2013 11:12:11 +0200
Message-ID: <51D2996B.8070503@alum.mit.edu>
References: <15tsj20cizd.fsf@tux.uio.no> <7vtxmgruhc.fsf@alter.siamese.dyndns.org> <vpq1u9kunba.fsf@grenoble-inp.fr> <7vwqrbmh4d.fsf@alter.siamese.dyndns.org> <5188B165.3050709@alum.mit.edu> <7v1u7iapzw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Marc Branchaud <mbranchaud@xiplink.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtwdK-00042G-8h
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab3GBJMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jul 2013 05:12:18 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51748 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753623Ab3GBJMQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jul 2013 05:12:16 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-39-51d2996f75b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 06.9B.17335.F6992D15; Tue,  2 Jul 2013 05:12:15 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r629CCZt024692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Jul 2013 05:12:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7v1u7iapzw.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUgTYRzvudvOm9vF4/mypxWWKwuqpWHEWRF9KLiIJAsjilyXnm613dbd
	Fs4PtSiTtpa9gi4qM8EobCCZWRGyKEsi3DRq9GYlplYOegGjD3a3Yfrl4cfze+PP/0/idExt
	IK2CixcFzmYkUlV0yvock6MhWpx/7no+0zr0FmM6OnyA8fX7McYb6MeZ6M+QmjkyKDLjx07i
	TOhWXco6ku0Mvkthz/zqVrNDgQeAjUTns69f+QHr938j2J9t2WxX32diC7lTu2Yv5zq4zVop
	5K3do7VEPrarneczq/ofxAgvOJ7mAySJ4Ar0/QPvAxoZZqHe9yHCB1JJGvYB1HP/PqYQNHyJ
	odCjVQqm4BLUOdYMFKyCueje7fEEJqAJNZ08iimZmXA76v+bm5SnoWcNgyoFZ8CF6MzxsErJ
	x+FjDNV2NyW86XA36vU2YMniYYC6H75IEBq4En34FE+4cbgUjZ0awJN4LjrafhE/DWBwWklw
	miw4TdYI8Bsgm7O57SY7Z7VJfJlJKuMEgRdNBcvsVtcyvtzdBpLrmHkX1IbmhAEkgVFHzbsc
	KabV3EHJYw+DWSRmzKTO1keL6Zl7HeUeCydZzKLbxkthgEjcmEHFNslyqpzzVPOiY5KaTaqM
	emph86IiGlZyLn4/zzt5cZKdQ5JGRB1QQtNEvpKvqrDaXFM0RmqU8FRDhsQL5bzIuV0Ws7JU
	syRvVaF0cu9VxU5JTs4u/yatPaCQ7Bq/HQdkLN4uv+Gnd+KAVgkOgTfoKY9igIrB4hb+101e
	5CjQy9OnU02KSiff6//UUbkQkwv3H0oUurgpyuAFRcSOgR/s6pUt9YY8bUMfLH09 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229382>

On 07/01/2013 11:58 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
>> My understanding is that we are waiting on two things:
>>
>> 1. Consensus from the community.  I would characterize the feedback =
on
>> the mailing list as limited in quantity but strongly positive [1-4] =
and
>> I think that most/all of the wishes for post-receive-email features =
that
>> were originally omitted from git-multimail have been implemented in =
the
>> current version.  Some of the mailing list feedback was about earlie=
r
>> versions.  Do you want people to give feedback specifically about th=
e
>> current version?
>>
>> 2. For me to figure out what part of the git-multimail history I thi=
nk
>> should be included in the Git project, do any necessary repository
>> rewriting, and submit a pull request to you.  The fact that I haven'=
t
>> gotten to this is due to the fact that I've been busy getting git-im=
erge
>> [5] ready to present at GitMerge.
>=20
> Ping, now GitMerge is over?

Yes, and its reverberations are slowly getting under control, too :-)

> No need to hurry, but just to make sure this didn't disappear from
> everybody's radar.

I definitely haven't forgotten it.  I wasn't so happy with the script's
Python API, and was holding off on the final submission to avoid castin=
g
the old way in stone.  But I finally had some time over the last two
weekends to convert to what I think is a more sensible system [1].  (I
also improved the test coverage considerably.)

=46eedback would be very welcome, especially from people who have tried
out the old Python API.  I am even willing to personally help people
adapt to the new API, as it would help me verify that real-life
customizations are now indeed easier.  (=C6var, any news?)

This week I want to convert $WORK to the new version; after that I woul=
d
feel comfortable submitting to Git contrib.

(By the way, the changes don't affect how the script can be configured
via "git config" settings, or its backwards compatibility with
post-receive-email.  The improvements are all to the Python API.)

I have a logistical question: git-multimail doesn't have its own mailin=
g
list, and GitHub doesn't offer one.  I was thinking about setting up a
Google group, but a few people at GitMerge suggested that I instead
direct discussion of git-multimail to the main Git mailing list.  I
would slightly prefer that, but I would first like to make sure that th=
e
extra traffic (probably not much) would be welcome on the Git mailing l=
ist.

Michael

[1] "master" branch at https://github.com/mhagger/git-multimail

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
