From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Finding all commits which modify a file
Date: Tue, 24 Jan 2012 02:15:50 +0100
Message-ID: <CA+gHt1Cfn3H2-d5PN-E6Q0XTNC7V7i+xkS4DRaTc=jYXLhDU9g@mail.gmail.com>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
 <4F1B4764.3010501@gmail.com> <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
 <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Tue Jan 24 02:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpUzi-0003AO-6V
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 02:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab2AXBQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 20:16:12 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60585 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab2AXBQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 20:16:11 -0500
Received: by pbaa10 with SMTP id a10so1943535pba.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 17:16:11 -0800 (PST)
Received: by 10.68.135.4 with SMTP id po4mr26423522pbb.68.1327367771384; Mon,
 23 Jan 2012 17:16:11 -0800 (PST)
Received: by 10.68.56.164 with HTTP; Mon, 23 Jan 2012 17:15:50 -0800 (PST)
In-Reply-To: <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com>
X-Gm-Message-State: ALoCoQkm2zsE/nfeJ4rTzDOIgbtzURI5zNCBFPWDVEixu2nnUzqSz+cF79wp8zJa0qEAF3I6LPi5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189033>

On Tue, Jan 24, 2012 at 1:58 AM, Santi B=E9jar <santi@agolina.net> wrot=
e:
> [Note: CC main authors of the code surrounding the patch]
>
> On Mon, Jan 23, 2012 at 5:14 PM, Neal Groothuis <ngroot@lo-cal.org> w=
rote:
>>> On 1/20/2012 3:35 PM, Neal Groothuis wrote:
>>>> I'm trying to find /all/ commits that change a file in the
>>>> repository...and its proving to be trickier than I thought. :-)
>>
>> On 1/21/2012 6:16 PM, Neal Kreitzinger wrote:
>>> Does git-log --all help?
>>
>> I don't see how it would. =A0The commits are all reachable from HEAD=
, which
>> would seem to be the problem that --all would correct.
>>
>> What I'm trying to do is find the commits in which a file differs fr=
om
>> that same file in any of its parents.
>
> If you add parent rewriting (--parent, --graph or see it in gitk, wit=
h
> --full-history) you'll get your B2 commit as it adds commits to have =
a
> meaningful history. But I don't think this is what you are asking for=
=2E

Note that even if it get listed, you won't get a diff for foo.txt
because it is an evil merge as the result is not the expected (using
the three way merge) one but is equal to one of the branches.

HTH,
Santi
