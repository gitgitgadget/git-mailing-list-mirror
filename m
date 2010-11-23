From: =?ISO-8859-1?Q?Tarek_Ziad=E9?= <ziade.tarek@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 13:49:24 +0100
Message-ID: <AANLkTinj3ryChGKV8c6fHSD=aickmz0TMos4k0RYGKvo@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
	<AANLkTinFMn4V3c3yV6j72eqj5=v4jW7Uh3fmNDOyYjnT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 13:49:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsJQ-00056t-2y
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 13:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411Ab0KWMt1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 07:49:27 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36437 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0KWMt0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 07:49:26 -0500
Received: by bwz15 with SMTP id 15so7053066bwz.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 04:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I5QQ/hgZ2KuvIvyDMbmBNL579GhcjNVDZecWWJli6bQ=;
        b=s3FubgAzxc1fQymeoaRq2PHt/kZ9HIKViHU+cIvTQD9u54YLoc1hkTAMHgEHMeu6Dy
         lrC9CB7wnoDgl9SuJ9wx0h1MJkurRZ3s44Vppz6u7bgplxCTsjIyLU45OX4R3Wzo9EDl
         sW6PxW+0ss3J0jO3JrcRKcfn/WU+Oo7GnHLQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l/xhT06mxcvjVH/DMLSfjyRVwSlJ8rLJDmPJifGQs22FijoMqotxC0qfjAvlmBQ1Qy
         vSMe+TXGOANc4pjtpQp0SJBz5soLenfn3wZIsOE/fV5U89E7Yil8XltlzfPFcXoB3N0g
         aS03StzVkg0fKYduG3oEJFPDq+2SvmGTHneVI=
Received: by 10.204.54.147 with SMTP id q19mr3327356bkg.69.1290516564286; Tue,
 23 Nov 2010 04:49:24 -0800 (PST)
Received: by 10.204.54.207 with HTTP; Tue, 23 Nov 2010 04:49:24 -0800 (PST)
In-Reply-To: <AANLkTinFMn4V3c3yV6j72eqj5=v4jW7Uh3fmNDOyYjnT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161953>

On Tue, Nov 23, 2010 at 1:40 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Tue, Nov 23, 2010 at 7:23 PM, Tarek Ziad=E9 <ziade.tarek@gmail.com=
> wrote:
>> Hello,
>>
>> I am new to Git and I tried to run "git st"
>>
>> I have found one small bug: "status" is not listed in the help scree=
n
>> Git displays in that case.
>>
>> $ git st
>> git: 'st' is not a git command. See 'git --help'.
>>
>> Did you mean one of these?
>> =A0 =A0 =A0 =A0reset
>> =A0 =A0 =A0 =A0stage
>> =A0 =A0 =A0 =A0stash
>
> It's heuristics, based on the assumption that you mistype a command b=
y
> a letter or two.
> It gives helpful suggestions most of the time, but
> you can't expect it to be always right, especially when "st" is not a
> mistyping. "git --help" does show "status" though so I guess it's ok.

Yes, I understood this, but given the list of base commands git comes
with, if "st" gives "stage" and "stash", it would find it logical to
give also "status", by listing commands that starts with 'st'

st
stage
stash
status

That's what the tab completion does:

$ git st<tab>
stage    stash    status


Cheers
Tarek

> --
> Duy
>



--=20
Tarek Ziad=E9 | http://ziade.org
