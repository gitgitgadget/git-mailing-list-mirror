From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git submodule: update=!command
Date: Wed, 18 Mar 2015 20:45:17 +1300
Message-ID: <CAFOYHZBAZ+Oy-tFDGuiUmA7JcwPG=LPPkmX=Z=Rpg4gV+cXFMg@mail.gmail.com>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
	<xmqqy4mvmjs9.fsf@gitster.dls.corp.google.com>
	<1426625989.1809668.241718517.07249CD6@webmail.messagingengine.com>
	<xmqqtwxjmj21.fsf@gitster.dls.corp.google.com>
	<CAFOYHZC2Af80EgNgnd7a_DyYnaivthA6vnDEdknQ4ebQfgdGmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ryan Lortie <desrt@desrt.ca>, GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:45:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY8fM-00059l-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 08:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbbCRHpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 03:45:20 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33832 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbbCRHpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 03:45:18 -0400
Received: by pdbni2 with SMTP id ni2so35367349pdb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a9sfCa+TTMmAn8O9cMR2Bq/Yi8/tyqNzzKtdLCDHKD8=;
        b=RA4c3Y9uT8gVwETj2RVqzdY3fYJTLkgiXzXR/LMUoTkeVoQFIXktHCe//T8mtgkDIZ
         5c7EG9Jwv1wfSe1VJzcEULtQe1G8ovxGij2rF5NduwR0lz4G0A1AH/FH4upscxT8ev76
         If2tbEQDmiYWYbN/ByX8CgHZjFxpLmg1dOGvkRlW0Fn8G8d6EycFTVQ+LMEeMFwdxWZq
         n2EjJ72neu/Gz64wGqV65/MsbP4hv4O8QcVECKN8Ymz1uk685ND7EiI3QQcFVV2f89Cg
         mItSoGx93TL++QVU5L6JImRIwHpFbgO8xJuazfzdoO8VxIT5JCoMDoZU4yJ61MJScaWw
         1zcg==
X-Received: by 10.66.164.66 with SMTP id yo2mr159346165pab.59.1426664717815;
 Wed, 18 Mar 2015 00:45:17 -0700 (PDT)
Received: by 10.70.0.171 with HTTP; Wed, 18 Mar 2015 00:45:17 -0700 (PDT)
In-Reply-To: <CAFOYHZC2Af80EgNgnd7a_DyYnaivthA6vnDEdknQ4ebQfgdGmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265690>

On Wed, Mar 18, 2015 at 8:43 PM, Chris Packham <judge.packham@gmail.com> wrote:
> On Wed, Mar 18, 2015 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ryan Lortie <desrt@desrt.ca> writes:
>>
>>> On Tue, Mar 17, 2015, at 16:49, Junio C Hamano wrote:
>>>> With more recent versions of Git, namely, the versions after
>>>> 30a52c1d (Merge branch 'ms/submodule-update-config-doc' into maint,
>>>> 2015-03-13), the documentation pages already have updated
>>>> descriptions around this area.
>>>
>>> sigh.
>>>
>>> That's what I get for forgetting to type 'git pull' before writing a
>>> patch.
>>>
>>> Sorry for the noise!
>>
>> Nothing to apologise or sigh about.  You re-confirmed that the old
>> documentation was lacking, which led to an earlier discussion which
>> in turn led to Michal to update the documentation.  If you check the
>> output from
>>
>>     git diff 30a52c1d^ 30a52c1d
>>
>> and find it appropriately address the problem you originally had,
>> that would be wonderful, and if you can suggest further improvement,
>> that is equally good.
>
> I think 30a52c1d could be improved with the following snippet from Ryans patch.
>
> "For security reasons, this feature is not supported from the
> `.gitmodules` file"
>
> Or something along those lines.

Which is actually down the bottom if I take the time to read the whole diff.
