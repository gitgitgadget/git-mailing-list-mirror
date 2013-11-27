From: Nick Townsend <nick.townsend@mac.com>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 26 Nov 2013 19:28:45 -0800
Message-ID: <FE55CF9D-FE21-4DCA-A819-0B3E6D378C57@mac.com>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
 <5294BB97.7010707@web.de> <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
 <52953CB7.8020300@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 27 04:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlVoX-00080M-Av
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 04:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab3K0D3R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 22:29:17 -0500
Received: from nk11p03mm-asmtp001.mac.com ([17.158.232.236]:61281 "EHLO
	nk11p03mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793Ab3K0D3Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 22:29:16 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MWW00807KCQFL00@nk11p03mm-asmtp001.mac.com> for
 git@vger.kernel.org; Wed, 27 Nov 2013 03:29:15 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-11-27_02:2013-11-26,2013-11-27,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1311260227
In-reply-to: <52953CB7.8020300@web.de>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238404>


On 26 Nov 2013, at 16:28, Ren=E9 Scharfe <l.s.r@web.de> wrote:

> Am 26.11.2013 23:18, schrieb Junio C Hamano:
>> Ren=E9 Scharfe <l.s.r@web.de> writes:
>>=20
>>> Thanks for the patches!  Please send only one per message (the seco=
nd
>>> one as a reply to the first one, or both as replies to a cover lett=
er),
>>> though -- that makes commenting on them much easier.
>>>=20
>>> Side note: Documentation/SubmittingPatches doesn't mention that (ye=
t),
>>> AFAICS.
>>=20
>> OK, how about doing this then?
>>=20
>> Documentation/SubmittingPatches | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitt=
ingPatches
>> index 7055576..304b3c0 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -140,7 +140,12 @@ comment on the changes you are submitting.  It =
is important for
>> a developer to be able to "quote" your changes, using standard
>> e-mail tools, so that they may comment on specific portions of
>> your code.  For this reason, all patches should be submitted
>> -"inline".  If your log message (including your name on the
>> +"inline".  A patch series that consists of N commits is sent as N
>> +separate e-mail messages, or a cover letter message (see below) wit=
h
>> +N separate e-mail messages, each being a response to the cover
>> +letter.
>> +
>> +If your log message (including your name on the
>> Signed-off-by line) is not writable in ASCII, make sure that
>> you send off a message in the correct encoding.
>=20
> OK, but the repetition of "cover letter" and "e-mail messages"
> irritates me slightly for some reason.  What about the following?
>=20
> -- >8 --
> Subject: [PATCH] SubmittingPatches: document how to handle multiple p=
atches
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Documentation/SubmittingPatches |   11 +++++++++--
> 1 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
> index 7055576..e6d46ed 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -139,8 +139,15 @@ People on the Git mailing list need to be able t=
o read and
> comment on the changes you are submitting.  It is important for
> a developer to be able to "quote" your changes, using standard
> e-mail tools, so that they may comment on specific portions of
> -your code.  For this reason, all patches should be submitted
> -"inline".  If your log message (including your name on the
> +your code.  For this reason, each patch should be submitted
> +"inline" in a separate message.
> +
> +Multiple related patches should be grouped into their own e-mail
> +thread to help readers find all parts of the series.  To that end,
> +send them as replies to either an additional "cover letter" message
> +(see below), the first patch, or the respective preceding patch.
> +
> +If your log message (including your name on the
> Signed-off-by line) is not writable in ASCII, make sure that
> you send off a message in the correct encoding.
>=20
> --=20
> 1.7.8
>=20
>=20
That seems clear to me.
At any rate I=92m going to rework this based on the collective input an=
d will submit them again.
Please check my other replies as there are some discussion points!

Nick