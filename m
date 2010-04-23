From: Daniel Grace <negativeview@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 15:33:54 -0500
Message-ID: <h2r62a3a9cb1004231333o593a373bvecf8ce7a4e6cd734@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	 <20100422155806.GC4801@progeny.tock>
	 <87wrvzs590.fsf@frosties.localdomain>
	 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	 <87sk6n4426.fsf@frosties.localdomain>
	 <alpine.LFD.2.00.1004221651590.7232@xanadu.home>
	 <87vdbitu9v.fsf@frosties.localdomain>
	 <25441792-181D-456D-8182-F33B49209EFF@wincent.com>
	 <87aastx6sa.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 22:34:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5PZi-00014x-31
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 22:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756987Ab0DWUd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 16:33:57 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:40833 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab0DWUd4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 16:33:56 -0400
Received: by qyk9 with SMTP id 9so13722997qyk.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UbCNnWOeNkGvXFV/PWaDz4hckRt7v4bMmAOECxDJba4=;
        b=hNx6E76MTJtbR8PHEysrNAz8atnG2euc53MSVKtQaGWAGGsjw8mUt1+HaIvVTdAekd
         SiBu0HF93q8doyfwI6QHgjmGk/9hgzNopu9e0ABXlDPB0KRGbI4laRKoI2TjdsMgUjrx
         wD6tt40FqMV42MJMHNfjTookOLgqYaznayyjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IAxoICDLUbHTo4WUFQsF0iqDPlex+OBgUbriFNTVUvjgTBDkhHsNYANCanu42KtdBX
         BFUSTJ9ervIZ4/ZJsZyruxboM4G2ZvyKhlJfKTMc0T4ypDBE4u7Qhir0MLGudFMARIzZ
         rJywCxjWNYzSSpi6hQDGoI18AJqVjZltPg9e0=
Received: by 10.229.38.69 with SMTP id a5mr720504qce.15.1272054834927; Fri, 23 
	Apr 2010 13:33:54 -0700 (PDT)
Received: by 10.229.81.6 with HTTP; Fri, 23 Apr 2010 13:33:54 -0700 (PDT)
In-Reply-To: <87aastx6sa.fsf@frosties.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145640>

On Fri, Apr 23, 2010 at 3:17 PM, Goswin von Brederlow <goswin-v-b@web.d=
e> wrote:
> Wincent Colaiuta <win@wincent.com> writes:
>> El 23/04/2010, a las 11:03, Goswin von Brederlow escribi=F3:
>> And in the event that the changes you want aren't accepted, you're f=
ree to either fork the tool or pick another one which does conform bett=
er to your expectations.
>
> But you are already rejecting it in the design phase before there eve=
n
> is a patch.

This is common in open-source. If you come to the mailing list talking
about a feature, without a patch, the maintainers let you know how
likely they are to want to write or maintain that feature. You haven't
given them a patch they could trivially merge in, so it reads as if
you're asking them to write the feature. Why write a feature that they
would never use?

Writing it yourself is one way to get a feature included that the
maintainers wouldn't use themselves. But you have to realize that
they're still thinking about having to maintain that feature. Every
new feature adds work to them, making sure that their future work does
not break it. There will be some features that are just deemed not
worth that effort by the people that control the official repository.
This is why forking is sometimes (rarely, but sometimes) acceptable.

>> In the present case experience has shown that the index and the way =
it can be exploited are an incredibly useful thing. Not only that, it's=
 a differentiating feature of Git and it sets it apart from other SCMs,=
 in a good way. We could mindlessly homogenize to be more like other sy=
stems, or less "surprising" for users coming from other systems, but we=
'd be throwing away something valuable in the process.
>
> If I would ask to disable the indexing feature then you would have a
> point. But I am not. I'm asking to add something that allows to use g=
it
> in a less "surprising" mode that, with the --a-if-empty option, does =
not
> alter anything else. Git would still have all its great, big, shiny,
> differentiating features to set it apart from other SCMs without forc=
ing
> them down the users throat.

Nothing is being forced down anyones throat by Git. Git doesn't
somehow force you to use Git from here into eternity. You state later
that you *have* to use many different systems. But it's not Git that
forces you to do so.

> I personaly have to work with different SCMs every day and every time=
 I
> have to switch minds to work with each specific one. Making git commi=
t
> work less surprising would be one less thing to keep in mind.

This sounds to me like you should try to simplify your setup. I know
that sometime it's not possible, but you're fighting an unwinnable
battle. If you're truly using that many different systems with
overlapping functionality you are destined to be confused. Period.
Most SCMs now do a good job of migrating data and in some cases (git
svn, for instance) sharing data on an ongoing basis. There are also
tools around that handle multiple SCMs behind one consistent
interface.

> You like that Git is different so don't use the --a-if-empty option. =
You
> will have lost nothing by allowing that option in. So far I have read
> arguments from people saying they don't want to USE the option. But n=
o
> arguments why there could not be such an option. And I'm not the only
> one that would welcome such an option. Is there no room for a comprom=
ise?

I'm not one of the maintainers, so maybe I'm speaking out of turn, but
as I pointed out above, they are losing something for letting in
options. They will have entered into an implied contract with their
users to keep that feature working in the future, putting a burden on
future development efforts. This is not without cost.

Daniel
http://www.doomstick.com
