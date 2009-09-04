From: Gabe <gabriel.mcarthur@gmail.com>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 16:47:54 -0700
Message-ID: <524457d10909041647u562601d5q69142eefe894ac5b@mail.gmail.com>
References: <585278.66341.qm@web27802.mail.ukl.yahoo.com>
	 <658028.86274.qm@web27804.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Douglas Campos <douglas@theros.info>,
	Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Sat Sep 05 01:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjiWn-0003Cp-HE
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 01:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933956AbZIDXrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 19:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933944AbZIDXry
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 19:47:54 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:33729 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927AbZIDXrx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 19:47:53 -0400
Received: by ewy2 with SMTP id 2so852190ewy.17
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FjIj3m8a7essPBJKP64QCeshD1jiQmlRcACh4M6RrKY=;
        b=SJEHKEYzxhFdSDTRvrAQuSAFH3ANRPVCOi/xElzv0PwFMCrLvzPKAMA3gyybghmbKl
         x556GN4Zmqccmq3bh9qc93LtSqoIcwIizAKZjATJ3cd8joZoF0bmnA4kezjNIOqcjnXs
         ESNKTbBYXQkB5UrSWfbgCVt5kPN/Ux54wtp2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Akt9gAt9SMo+s24i/7JDX7g7tY8j2A3UFm9vYR5MIhrjFGATV3HAhBHoqVVgyGjzfb
         sDSW0kMgAKDdgrHln7r+YRFeNOEkhrWsemOtmqzi7MrQUOiGPyei/Vhjb/h62zjXqiG0
         PaXBfmHa3FukcoiiZEodQPoVCcxnlO3ELHe6w=
Received: by 10.216.7.141 with SMTP id 13mr2200833wep.24.1252108074392; Fri, 
	04 Sep 2009 16:47:54 -0700 (PDT)
In-Reply-To: <658028.86274.qm@web27804.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127772>

On Fri, Sep 4, 2009 at 10:28 AM, Mark Struberg<struberg@yahoo.de> wrote=
:
> Hi!
>
> Work has been done at
>
> http://github.com/sonatype/JGit/tree/mavenize
>
> Please feel free to pull/fork and share your changes! I'd be happy to=
 pull it in.
>
> @Gabe: your patch seems to got filtered by the list, I think sharing =
such big things is easier by using github. Would be cool if you could h=
elp us!

Ok, I'll fork and send a patch request shortly.  I was thinking about
it earlier, and I may add a couple of features that all OS projects
should follow (e.g. License in the jar, etc.).

As to a few questions that have been raised:
1) I pick the 'sources' folder because it's good metadata management.
Everything in the root folder should be about or related to managing
the project.  No direct source folders, as it clutters the layout.
Best to be perfectly clear where all the action is happening.  It's a
simple convention I wished more projects followed.
2) I haven't worked with the find-bugs plugin.  I looked it up, but it
seems to only generate documents in the 'site'/reporting profile.
Thus it wouldn't necessarily affect the building of the software.  It
would really only be useful if you had something like a Hudson CI
infrastructure or site generation going on to build a website and show
the reports.  I could certainly add that, though, if you like.
3) The LICENSE file can be at the top level.  Not really an issue for
me one way or another.  Just a personal preference on how I have
structured all of my previous Maven projects.

-Gabe




>
> LieGrue,
> strub
>
> --- On Fri, 9/4/09, Mark Struberg <struberg@yahoo.de> wrote:
>
>> From: Mark Struberg <struberg@yahoo.de>
>> Subject: Re: [JGIT] Request for help
>> To: "Douglas Campos" <douglas@theros.info>
>> Cc: "Jonas Fonseca" <jonas.fonseca@gmail.com>, git@vger.kernel.org, =
"Gabe McArthur" <gabriel.mcarthur@gmail.com>
>> Date: Friday, September 4, 2009, 4:49 PM
>> Hi Douglas!
>>
>> http://github.com/sonatype/JGit
>>
>> The branch will be called mavenizing or so.
>>
>> Will post this after I got the tests running.
>>
>> LieGrue,
>> strub
>>
>> --- On Fri, 9/4/09, Douglas Campos <douglas@theros.info>
>> wrote:
>>
>> > From: Douglas Campos <douglas@theros.info>
>> > Subject: Re: [JGIT] Request for help
>> > To: "Mark Struberg" <struberg@yahoo.de>
>> > Cc: "Jonas Fonseca" <jonas.fonseca@gmail.com>,
>> git@vger.kernel.org,
>> "Gabe McArthur" <gabriel.mcarthur@gmail.com>
>> > Date: Friday, September 4, 2009, 4:44 PM
>> > On Fri, Sep 4, 2009
>> > at 9:47 AM, Mark Struberg <struberg@yahoo.de>
>> > wrote:
>> >
>> >
>> > as an old saying tells us: how to climb a mountain?
>> step
>> > after step! ;)
>> >
>> >
>> >
>> > I suggest we create a fresh branch based on the
>> Shawns
>> > current version and add all the features
>> incrementally.
>> >
>> >
>> >
>> > please point out where this branch will happen, I want
>> to
>> > give some help too.
>> >
>> >
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.h=
tml
>>
>
>
>
>
