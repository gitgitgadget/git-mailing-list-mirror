From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sat, 24 Jan 2009 16:04:11 +0200
Message-ID: <94a0d4530901240604o5ae0d321h17dc6aabeefe9d53@mail.gmail.com>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
	 <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
	 <831vuvfh7t.fsf@kalahari.s2.org>
	 <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
	 <83wscndv57.fsf@kalahari.s2.org>
	 <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com>
	 <alpine.DEB.1.00.0901241438370.13232@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Hannu Koivisto <azure@iki.fi>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 15:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQj93-0007X5-86
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 15:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbZAXOEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 09:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbZAXOEO
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 09:04:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:29537 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbZAXOEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 09:04:14 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2891985fgg.17
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JqH72WKazuEae9fjeCAHIv6Fd2cICpSCO8zNLRex6JM=;
        b=cl6JE/WeBdJCZOkOnE04+JnEhTDTTPUsqpcMB6n5ATYntewmwQf7jKhsJ78ZFhZuvm
         t3aGCSEHad8W0+XaSlSJCVglIoOTQUaXyLKbE1oxF3OwruOXa13nKAG9INLnAidMR3Om
         hmxn65hB4GSovKrwyto1Yu3Yh/F6j5mkpiVXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ilk90RpSirtPIIY7K08BQMnUOSrYXpw6NZsGjzdXccK+WPvP3YSYIUd57zFzRxf4OL
         zBHWpwedIp8MEQ9QC2Vp3xgAP2UWYS/k/5xxMSY46FXP++IxG58nPTmND7n1WqADM9jb
         vH+Um0qftlsR3MtJRAG5Bn/5sR6/c8MQUd+Fc=
Received: by 10.86.94.11 with SMTP id r11mr13012fgb.53.1232805851951; Sat, 24 
	Jan 2009 06:04:11 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901241438370.13232@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106967>

On Sat, Jan 24, 2009 at 3:42 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 24 Jan 2009, Felipe Contreras wrote:
>
>> On Thu, Jan 22, 2009 at 8:59 PM, Hannu Koivisto <azure@iki.fi> wrote:
>> > Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >
>> >> On Thu, Jan 22, 2009 at 6:17 PM, Hannu Koivisto <azure@iki.fi> wrote:
>> >>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >>>
>> >>>> This brings back my previous question: where is the home directory in
>> >>>> a Windows system?
>> >>>
>> >>> It's where %HOMEDRIVE%%HOMEPATH% points to.
>> >>
>> >> I thought it was something like that. Do we want something like that
>> >> in the manual, or should we assume Windows users know that?
>> >
>> > I should have added that Unix programs (i.e. Cygwin programs and
>> > even some native ports) probably use %HOME% which may be different
>> > from %HOMEDRIVE%%HOMEPATH%.  I recall that if you haven't
>> > explicitly set up HOME in Windows environment, Cygwin sets it up
>> > magically from passwd or falls back to %HOMEDRIVE%%HOMEPATH%.  I
>> > have no idea if msysgit respects %HOME% if it is set or always uses
>> > %HOMEDRIVE%%HOMEPATH% or something completely different (user
>> > profile, most likely).
>> >
>> > It certainly may be that "home directory" is a foreign concept to
>> > some Windows users.  Some might know it as a user profile or a
>> > personal folder (just guessing, I'm pretty isolated from less
>> > experienced Windows users), even though user profile is a separate
>> > concept from "home directory" (note that there is %USERPROFILE%
>> > which by default is the same as %HOMEDRIVE%%HOMEPATH% at least in
>> > XP).
>> >
>> > In any case, what Cygwin git does should be expected by Cygwin
>> > users.  If msysgit wanted to be a really native Windows application
>> > and store the configuration where Microsoft thinks it should be
>> > stored, it probably shouldn't store the config under "home
>> > directory" to begin with (I'm guessing that's what it does) but
>> > under %USERPROFILE\Application Data\Git (...FILE\Local
>> > Settings\... in case non-roaming storage is wanted).  And in that
>> > case the manual might be misleading for msysgit users.  See
>> > e.g. <http://msdn.microsoft.com/en-us/library/ms995853.aspx>.
>>
>> Isn't that enough argument to stop assuming the user knows where is
>> the "home directory"?
>
> Why does it appear as if we always have to bend over for Windows?  That is
> really frustrating.
>
> In any case, the only thing the user would need to know the location of
> $HOME for is for .gitconfig.  And for Windows users I suggest using the
> dialog in git gui (for the variables that are editable there), which
> should cover most of what the user needs.  For everything else, they
> should use "git config".
>
> Because if you really start with explaining where the home can be on
> Windows, you would also have to cover why "%USERPROFILE%" does not work in
> Git bash.  And before you know what is happening, you have a big ass
> Windows chapter in the user manual that revolves around anything except
> Git.

Huh? That was exactly my point.

It's much easier for everyone to just use git config --global than
explain how create and edit the .gitconfig file. If this is explained
it shouldn't be in the "Telling git your name" section.

-- 
Felipe Contreras
