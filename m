From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 05:53:11 -0700
Message-ID: <cfd18e0f0809170553j4b7d60c4gc9942458c2d93bc1@mail.gmail.com>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
	 <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com>
	 <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com>
	 <20080917011816.GL28210@dpotapov.dyndns.org>
	 <c49095e30809162216m5c7885dbibbb022e65f43231c@mail.gmail.com>
	 <48D0AA1A.5060209@op5.se>
	 <cfd18e0f0809170328pb039331m1c4dc42fd398a4d@mail.gmail.com>
	 <20080917105620.GA13144@atjola.homenet>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Michael Kerrisk" <michael.kerrisk@googlemail.com>,
	"Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org,
	michael.kerrisk@gmail.com,
	"Michael J Gruber" <git@drmicha.warpmail.net>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 14:54:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfwY2-0007Ta-EJ
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 14:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbYIQMxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 08:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbYIQMxN
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 08:53:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:39879 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbYIQMxM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 08:53:12 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3170650rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=g6TB5rQ80yoUTsqFffyByvG8YLbOKhApS4nq+hzuiqw=;
        b=W1D1tPF05lGQ9rTXhUdLmpkDG2wM8pv5c2Ni17ZuR9Lzzr09hSnirSQ0bszV/RGXYs
         2bCHa7i5NbjCfci+2gBJsRf5b786Qn1+V2NI44+1KN6vecDlhqSOcIAdqlZA1DLEDJlX
         S0P82YmZUsCEjFnAu04/0EfS29ceNRc9NCoqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=qyexUltylgT7wxFipZ/1BWW1W8SUFJnlk7LLKdDwKcEAu2F0vItGm4MIjC62UjdG0a
         oHt8OSH/V5zX3ZASC13+SRywo42WfY3onjbP0lUV8q5zUWEFuma9Y8EWVt7V3w7MxRdB
         iHvqO+IT9gCO98McE+xOWUN/raLK1reoK5mXQ=
Received: by 10.141.66.16 with SMTP id t16mr6475064rvk.168.1221655991838;
        Wed, 17 Sep 2008 05:53:11 -0700 (PDT)
Received: by 10.141.176.2 with HTTP; Wed, 17 Sep 2008 05:53:11 -0700 (PDT)
In-Reply-To: <20080917105620.GA13144@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96106>

Bj=F6rn,

On Wed, Sep 17, 2008 at 3:56 AM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.d=
e> wrote:
> On 2008.09.17 03:28:46 -0700, Michael Kerrisk wrote:
>> Hi Andreas,
>>
>> On Tue, Sep 16, 2008 at 11:56 PM, Andreas Ericsson <ae@op5.se> wrote=
:
>> > Michael Kerrisk wrote:
>> >>
>> >> Hi Dimitry,
>> >>
>> >> On Tue, Sep 16, 2008 at 6:18 PM, Dmitry Potapov <dpotapov@gmail.c=
om>
>> >> wrote:
>> >>>
>> >>> On Wed, Sep 17, 2008 at 01:40:36AM +0200, Michael Kerrisk wrote:
>> >>>>
>> >>>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk=
 -b
>> >>>> branches
>> >>>>
>> >>>> takes about half an hour to run, the other command (which I alr=
eady
>> >>>> started yesterday) seems to be taking (far) more than a day!
>> >>>
>> >>> What version of Git do you use?
>> >>
>> >> 1.5.4.5, on Linux.
>> >>
>> >
>> > An upgrade would do you good.
>>
>> But, is it going to make this much difference to the run time?  By
>> now, the import using
>
> It should.
>
>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T
>> trunk/man-pages -b branches
>>
>> has been running for over 2 days (and I still don't know if it will
>> give the layout I want), and seems to be slowing down exponentially =
as
>> it gets further along in the import process, so at this rate it look=
s
>> like it would take several more days to complete, whereas
>>
>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b b=
ranches
>>
>> which doesn't give the layout I want, takes less than an hour.  We'r=
e
>> talking about a factor of at least 100 x in the speed difference for
>> the two imports.
>
> I guess your old import doesn't see any relations between the trunk a=
nd
> the tags/branches, right? Then the huge increase in runtime would be,=
 at
> least in part, explained by git-svn searching for ancestry. That you =
see
> those tags/1.2.3@123 things also means that the 1.2.3 tags got delete=
d
> and recreated, or at least git-svn thinks so. Maybe the ancestry
> detection goes nuts, hard to tell.

The above sounds very plausible as an explanation of what I'm seeing.

> Is that svn repo available anywhere?

It's local.  If someone felt the need to look at it to see if there is
something that could be improved in git (and maybe already is by the
current release), then I could put a copy somewhere.

Anyway, it looks like I have a fix that works from someone else in the
thread -- see my reply there.

Thanks!

Michael

--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
=46ound a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
