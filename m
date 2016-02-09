From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 5/7] convert: auto_crlf=false and no attributes set:
 same as binary
Date: Tue, 9 Feb 2016 15:34:54 +0100
Message-ID: <56B9F90E.2030304@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
 <1454688807-20871-1-git-send-email-tboegi@web.de>
 <xmqqzivb83d1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Feb 09 15:35:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT9Nr-0001Pf-IM
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 15:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbcBIOfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 09:35:09 -0500
Received: from mout.web.de ([212.227.17.12]:64540 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120AbcBIOfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 09:35:07 -0500
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MbyIM-1amKxF22UA-00JLHT; Tue, 09 Feb 2016 15:34:55
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <xmqqzivb83d1.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:04eqfpbNy576lP83FxpyQoA/kqsqEHVKoBhUlhamgXmfyhWQBoP
 phO5S93ajSXQ2Hv6l5vQNKy1t3wcFIq2FE62jPyaE1nPLBi69NdR/3r/eXbyeCDuscFkXub
 KUnLkpbkgwU4vsuTT9cRkWVHS3Rd5ITbbcqLAt2EBlP2yM3l47Qa02aSgE/ffPpP+XRrPlK
 E7ad4IC4VtVHeAuWogCXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wtMLvHW4hwA=:vZjX6k6C1EvJLh8d6iZrDQ
 zZetFFwnWEuZcc9h5NHcngpxSlWWw1VBqiK0qLzMSKL5qauusCy4VlUgkkXa3qKWBcQ082c+D
 fDXzll8wuy4QbX0PmOPatwyfTEfnXaXreRgzN/ZSwj4h3FaLOJsEiYuwWyJuf/k9tM2hLbt5f
 owxbX0xt2D6DVp3BxSj/CUmxL4x+fzgKTvYZ+U8WG3sZfbRu+dcgokk2mbIKylhECAoWmU6Lg
 HOcsnY5MUuLR0ey4r0w/dT7DECX5/xp+k7kK8mYc6ZCWvcSfZKF+yPYxJrzpk9g5XJslxo6vN
 b0fEqQTawP+5/GsDYbSsspXVC8n+7TB5M0bBKaGZGugpvnRm8/XI2dzh/GCeBOZd3fl1Q0ItJ
 /FIhwaj4XGeeF6H+DKDkEAfXHNcVQnH23JT2/5do6Wm33E6Ty+XKPqlpkFKNPgcDN4s6aV2Yi
 ee+CBlC5nNETsAjK04KeM78pJeykiTp93f76fE4pwaSYEm5BEVuRwCPpyLFRpPnP5feJc0sJi
 aibUtbkDbzkwurm8uhTz8e1PnHvZ7wv/0ORJPYqCnawJryPRdGa0fdQKje6OTE/cbrUaziu5d
 cPrRL7zpTh0bMEKl8bzyCI36kLX0CER4+mWz01DKqhl1m5Q7+ogHMUaBn7pll2OQHyDkfdcVH
 BIhG9pCGWLkpfJYLKzRjFI3THVeFWwCp3HBfMiDe2AAC5ybPaE24syUllGipxyo88wueMpEe2
 e5HDcqvM5yTu6g4acbgAORpT3tuIE1XpIse2NdPC6Hml1nv1Kcy1q187IdQzVPQ46c4WbJn6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285837>

On 02/08/2016 07:27 PM, Junio C Hamano wrote:
> tboegi@web.de writes:
>
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> When core.autocrlf is set to false, and no attributes are set, the f=
ile
>> is treated as binary.
> This, and also on the title, I know by "binary" you mean "no
> conversion is attempted", and it is the word used in the code around
> there, but it still makes my heart skip a beat every time I read
> this sentence--it is not like we do not treat the contents as text
> after all.
>
> In any case, I take the above sentence the statement of the fact,
> describing how the world currently is, not declaring a new world
> order.
The word binary is indeed not ideal here: no eol conversion is done.
(And the commit message could use "-text")
>> Simplify the logic and remove duplicated code when dealing with
>> (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALSE) =
by
>> setting crlf_action=3DCRLF_BINARY already in convert_attrs().
> I looked at all the places where CRLF_BINARY is checked.  The ones
> that are in this patch are clearly where "Is it BINARY?" and "Is
> AUTO_CRLF_FALSE and CRLF_GUESS both true?" mean the same thing, so
> this is a correct simplification to these places.
>
> It is not easy to see what the effect of this change to the other
> places that use CRLF_BINARY, though.
>
>  * output_eol() used to return EOL_UNSET when auto_crlf is not in
>    effect and CRLF_GUESS is.  The function will see CRLF_BINARY with
>    this patch in such a case, and returns EOL_UNSET.  So there is no
>    change to the function and its callers.
OK
>  * convert_attrs() has "If BINARY don't do anything and return".
>    Will the patch change behaviour for the "not-autocrlf,
>    CRLF_GUESS" case in this codepath?  I think ca->crlf_action used
>    to be left as CRLF_GUESS here before the patch, and now by the
>    time the control flow reaches here it is already CRLF_BINARY.
>    Would it affect the callers, and if so how?
Not sure if I fully understand the question:

The old CRLF_GUESS could mean (a) core.autocrlf=3Dtrue,
(b) core.autocrlf=3Dinput or (c) core.autocrlf=3Dfalse.
The callers had to look at the core.autocrlf them self.
This patch removes (c), the next (or over next) (a) and (b)

    if (ca->crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF=
_FALSE)
        ca->crlf_action =3D CRLF_BINARY;
}
The next patch 6/7 removes "GUESS" completely.



>  * get_convert_attr_ascii() would change the behaviour, right?  It
>    runs convert_attrs(), and with this change a path without
>    attribute when autocrlf is not in effect would get BINARY and
>    would show "-text", while the code before this change would give
>    an empty string.  Am I misreading the code, or is the change
>    intended?
>
> Thanks.
(That happened in my first (not published) version,
today we have this:)
struct conv_attrs {
    struct convert_driver *drv;
    enum crlf_action attr_action; /* What attr says */
    enum crlf_action crlf_action; /* When no attr is set, use core.auto=
crlf */
    int ident;
};

The idea is (after this and the next commit 6/7) is
that once we had run  convert_attrs() there is a clear picture
what should be done with the eols, and it is stored in crlf_action.

No further check with core.autocrlf in any calling party should be need=
ed.

In a future series it should be possible to set
*text=3Dauto
*eol=3Dclrf
to behave exactly as if core.autocrlf=3Dtrue.
But that is a change in behavior, and needs a separate series.
This series should not change the behavior, so a critical review is app=
reciated.


Does this answers the questions ?
Is a local amend possible ?
