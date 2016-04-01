From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch 04/33
Date: Thu, 31 Mar 2016 18:37:17 -0700
Message-ID: <CAGZ79katAVbd6mMSu2Kt1SnH2f3Ujn0L4-bH82bwLudzboCyTg@mail.gmail.com>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
	<1458802034.28595.8.camel@twopensource.com>
	<56F76E2C.5030700@alum.mit.edu>
	<1459282370.2976.7.camel@twopensource.com>
	<56FB743C.3020902@alum.mit.edu>
	<1459368315.2976.27.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 03:37:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alo1d-0005dA-51
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 03:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572AbcDABhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 21:37:20 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35323 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbcDABhT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 21:37:19 -0400
Received: by mail-io0-f178.google.com with SMTP id g185so136420221ioa.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7WMI1mis6mwblmnoqWllpgQDlOYYTNpbwaA1EKZWnkA=;
        b=Y9jKpVDxtaDlHwiXzcfK916JAmH7AYgGDtf176HfhwofqVnlOLHZnc2kPR2EkiPGZ3
         9sXa8QNF5VBlgeqWjIlVBW9zzvTtxW31k8fw+WKyyyCtr+BfvRL7LBA+dEYKYrySF4s/
         orvD1EWFZ5vuhlw73ehtS7kzZL3SW1j36qi+ue60yIQERkeWd3eO+81PcxE4qHZZCL67
         oqbgXHLcmlRYWhRlIWlyiRtE6nrGbZvLE5BXyCbNyZCPI23O2NMSJHHx1L45R2FoiXZl
         GoR3OE/ncwvKBib1pTkckRIWV7x2ejJgrdOtL4vxFM0Nvonm2dXtKqNHonRAQL1h5Ax9
         vaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7WMI1mis6mwblmnoqWllpgQDlOYYTNpbwaA1EKZWnkA=;
        b=Lz6ppQgOLs4DpTYemoMV/z1Xi2QVMs7LgWSua0pwCam8emjy99zBdqgaMcq8F+nogS
         MSKNuCSv0IemX32CJyDtDqfsS8ArhupHCeox+Cq/3k6nqTdiKxNPDvU/ZjwjrWv15lrB
         GHM+7belypTifS3WKg/VOx93uWM9oGrRNpZjd+FmzgcprIztfXCit3rqe8mUf1lbRSpB
         kquUYarofG/He5NPd/YsyQU1CArPMWmTxrq70gG64XrstgeuHECxNUxWsHi9a3nbdwi+
         W3fYA5uo21++mJ9FamUAO7o5i6pytdEwaeePVfmVF2ialMeMd9jW+kchG3yHLx0Rrba6
         eJVg==
X-Gm-Message-State: AD7BkJJZ8eMxWhbl2cKTbR1qofQNwX4s6GxOURqhGjpMc0T0cMqFijLlkzYR9l55xisHcaxjkgRxBxIMRjOHUkqy
X-Received: by 10.107.184.8 with SMTP id i8mr1934188iof.96.1459474638052; Thu,
 31 Mar 2016 18:37:18 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 18:37:17 -0700 (PDT)
In-Reply-To: <1459368315.2976.27.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290504>

On Wed, Mar 30, 2016 at 1:05 PM, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2016-03-30 at 08:37 +0200, Michael Haggerty wrote:
>> On 03/29/2016 10:12 PM, David Turner wrote:
>> > On Sun, 2016-03-27 at 07:22 +0200, Michael Haggerty wrote:
>> > > On 03/24/2016 07:47 AM, David Turner wrote:
>> > > > [...]
>> > > > I incorporated your changes into the lmdb backend.  To make
>> > > > merging
>> > > > later more convenient, I rebased on top of pu -- I think this
>> > > > mainly
>> > > > depends on jk/check-repository-format, but I also included some
>> > > > fixes
>> > > > for a couple of tests that had been changed by other patches.
>> > >
>> > > I think rebasing changes on top of pu is counterproductive. I
>> > > believe
>> > > that Junio had extra work rebasing your earlier series onto a
>> > > merge
>> > > of
>> > > the minimum number of topics that it really depended on. There is
>> > > no
>> > > way
>> > > that he could merge the branch in this form because it would
>> > > imply
>> > > merging all of pu.
>> > >
>> > > See the zeroth section of SubmittingPatches [1] for the
>> > > guidelines.
>> >
>> > I'm a bit confused because
>> > [PATCH 18/21] get_default_remote(): remove unneeded flag variable
>> >
>> > doesn't do anything on master -- it depends on some patch in pu.
>> >  And
>> > we definitely want to pick up jk/check-repository-format (which
>> > doesn't
>> > include whatever 18/21 depends on).
>> >
>> > So what do you think our base should be?
>>
>> I think the preference is to base a patch series on the merge of
>> master
>> plus the minimum number of topics in pu (ideally, none) that are
>> "essential" prerequisites of the changes in the patch series. For
>> example, the version of this patch series that Junio has in his tree
>> was
>> based on master + sb/submodule-parallel-update.
>>
>> Even if there are minor
>> conflicts with another in-flight topic, it is easier for Junio to
>> resolve the conflicts when merging the topics together than to rebase
>> the patch series over and over as the other patch series evolves. The
>> goal of this practice is of course to allow patch series to evolve
>> independently of each other as much as possible.
>>
>> Of course if you have insights into nontrivial conflicts between your
>> patch series and others, it would be helpful to discuss these in your
>> cover letter.
>
> If I am reading this correctly, it looks like your series also has a
> few more sb submodule patches, e.g. sb/submodule-init, which is
> responsible for the code that 18/21 depends on.
>
> I think jk/check-repository-format is also  good to get in first,
> because it changes the startup sequence a bit and it's a bit tricky to
> figure out what needs to change in dt/refs-backend-lmdb as a result of
> it.
>
> But I can't just merge jk/check-repository-format on top of 71defe0047
> -- some function signatures have changed in the run-command stuff and
> it seems kind of annoying to fix up.
>
> So I propose instead that we just drop 18/21 for now, and use just
> jk/check-repository-format as the base.

By 18/21 you mean
[PATCH 18/21] get_default_remote(): remove unneeded flag variable
in builtin/submodule--helper.c?
You could drop that and I'll pick it up in one of the submodule series',
if that is more convenient for you.


>
> Does this seem reasonable to you?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
