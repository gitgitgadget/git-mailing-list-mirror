From: Stefan Beller <sbeller@google.com>
Subject: Re: Minor Bug in Renaming Branches
Date: Tue, 7 Jun 2016 06:09:09 -0700
Message-ID: <CAGZ79kaDAPAkkEWVS6pEuAxoWht5Z5GmKjs1ii9_bsTViyhnVQ@mail.gmail.com>
References: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com>
 <54505ef2-7db6-8bc4-0ffb-0ac28c7d6046@web.de> <CAGZ79kb77m8ymDkJGMaWi8yOdSphpYifDPHQ=+nZMBhRi47i9w@mail.gmail.com>
 <575649DA.4080702@web.de> <20160607074051.GT22583@mail.eric.deplagne.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Samuel Lijin <samuel.lijin@formlabs.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Deplagne <Eric@deplagne.name>
X-From: git-owner@vger.kernel.org Tue Jun 07 15:09:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGkv-0007OL-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 15:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbcFGNJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 09:09:12 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34479 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbcFGNJL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 09:09:11 -0400
Received: by mail-qg0-f51.google.com with SMTP id p34so57677678qgp.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zVRXIFm5ztnP3oSWWymgGAqdOB/6KSebrZUHcKrbzuI=;
        b=iVoM37kSQPlvTVnj5KM+XIhZwaqPyY2gq8IYUnj38TRguYtqSOyCnxJj1Lkado6mxM
         LlD+1hab7To1e/RJ7/bwlWTo7u1iYhQAwgIcztfb3ctwy8OzldH9z+/QBBTb00A3rCLl
         sOATJzwAw5un44BDqLxC8L2CzouWkgnDBNj1xZdcF2VL2doNhusW/M+genUdxuqXIC1B
         Gffwvy6s6ZrT1LLGsUcS9ex4Rh/kqq66E2gNsBWMsId1dhPPaV2oVrDMuOnhCphe0Wed
         sOlcLj6H9S/vh/L77szvm2KvnZHqdlhTVSaeYGEMw6d+kv5GK/xNTNW2CES3Pf8/22m5
         MzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zVRXIFm5ztnP3oSWWymgGAqdOB/6KSebrZUHcKrbzuI=;
        b=iePDxp0p8RnEV9pGwf43p6D39nvnVilbTBezkFlXby50PMXDXF21pxYShqQ1Rdr3Ji
         eu40HmQDJRimxbbuW/b6ZChh8xyYAUBcV2e53kiXDVAHNraPlXYlN96ky44rHozY90ry
         ReTYKpPvMAauNCr4tWpdzwk4OHPI8iuD8OY+pHECh6UkW97j9QajLYZngR50oKKuCfaJ
         K7nRGjhpvs4kO7BcNNL3I2mOJLoFT4WZjwA+5O349hqzN7Jlntr7TCm/4qw8qEjkasRS
         PXTO7SvXkGWSMVVg7yfMA1Ex3mDgWGZ0cwaKDU7Ljj3hfL3t2WoiTgjDcNdFk2/cihVF
         +NBA==
X-Gm-Message-State: ALyK8tKRXubFRyJmVBIzL5jpLE9qZ9pYmkWymXLwgHH0W9pgft9GFSBPjD8tuBTa+/2DKOygU3B1dMK6EpCpxx5+
X-Received: by 10.140.221.135 with SMTP id r129mr20951320qhb.59.1465304950278;
 Tue, 07 Jun 2016 06:09:10 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Tue, 7 Jun 2016 06:09:09 -0700 (PDT)
In-Reply-To: <20160607074051.GT22583@mail.eric.deplagne.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296676>

On Tue, Jun 7, 2016 at 12:40 AM, Eric Deplagne <Eric@deplagne.name> wro=
te:
> On Tue, 07 Jun 2016 06:13:14 +0200, Torsten B=C3=B6gershausen wrote:
>> On 06/06/2016 09:35 PM, Stefan Beller wrote:
>>> On Mon, Jun 6, 2016 at 12:17 PM, Torsten B=C3=B6gershausen <tboegi@=
web.de> wrote:
>>>
>>>> A limitation is introduced by Mac OS and Windows:
>>>> BRANCH/NAME and branch/name refer to the same object in the file
>>>> system.
>>>> As a workaround, you can pack the branch names:
>>>> git pack-refs --all
>>>
>>> Once you packed a branch into the packed refs file, you can
>>> create another loose branch of different capitalization,
>>> which then 'hides' the packed ref?
>>>
>>> That sounds error prone to me, as a seemingly unrelated branch
>>> changed its value:
>>>
>>>      git branch BRANCH 012345
>>>      git pack-refs --all
>>>      git branch branch BRANCH^
>>>      git rev-parse BRANCH
>>>      (I'd expect BRANCH^ as return)
>>>
>>> (I don't have a windows machine for testing here, so that
>>> is pure speculation)
>>>
>> Yes, another reason not to use branch and BRANCH in the same repo.
>> (You can test under Linux & vfat)
>
>   Or to have git just refuse it altogether...

Maybe we could refuse creation of case different branch
names on case insensitive file systems, but you could have
created them on a case sensitive file system, so you still
have to work with that.

This topic was discussed at the Git Merge this year (again),
and IIRC the outcome was to not restrict outselves to the
lowest common denominator, but rather =C2=AF\_(=E3=83=84)_/=C2=AF.
People who use case insensitive file systems are aware of
their limitations and would not ever want to do such branch
tricks, right? ;)


>
>   But let me guess, it's against some sort of policy...

I rather think nobody stepped up to present a
solution that doesn't suck. As by the title of this thread,
it's rather minor.

>
>   There could be some hook out there, then ?

The hook to tell the user if that branch name is allowed?

My gut reaction to that is, that such a hook would violate
the principles of the DVCS thinking. A user ought
to do anything they want locally including having naming
rights for their local branches, so we'd not want to restrict
them?

>
> --
>   Eric Deplagne
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iD4DBQFXVnqDej7DisjVpq4RAqxoAJ0eufoN3OXWKGiHrAPolS4SmOHGIwCWJHNl
> jI/aVh12/NM8YZX5oEl4Ww=3D=3D
> =3DrwxP
> -----END PGP SIGNATURE-----
>
