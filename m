From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sat, 24 Jan 2009 10:21:14 +0200
Message-ID: <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
	 <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
	 <831vuvfh7t.fsf@kalahari.s2.org>
	 <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
	 <83wscndv57.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Sat Jan 24 09:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQdms-00049I-6S
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 09:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbZAXIVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 03:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbZAXIVR
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 03:21:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:59913 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZAXIVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 03:21:16 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2816313fgg.17
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 00:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pc7HzQY5rrvKrdel8V0UfEDzVm9gnkgd7m0xcAFQBiU=;
        b=Lv5Tt90cOTqLoKbmEyG/XFk7oMp5EyvcLg4AfM8u18OMmLwvfODHEaFsJKA1f+uTqZ
         tc21Kp65dxgzV7z6vIjkDY470avsA4adtQ+ZIHsfjWDgZGhOeeHQKxZbE9/kg/Vknxfs
         6Y8DVeZL4tjzw5iQs5J4d+11EjideHANMLAwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NoV6KHV37V8xBAQkLgIWGWangCr3vXMBCaPXsqK80tl6JpdDjmJkhPpH83ZzGc8GVv
         2MY1CF+Ju+6rNIPaq/bpeRINmTBIdjUt6Ra1+WBsrfK8VijjwiRDaL/2TT/KsidwAp+a
         a6BxyI3PzzZCJ1QKSX3rO+y4ia0g4TspVGM+o=
Received: by 10.86.80.17 with SMTP id d17mr339648fgb.14.1232785274756; Sat, 24 
	Jan 2009 00:21:14 -0800 (PST)
In-Reply-To: <83wscndv57.fsf@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106958>

On Thu, Jan 22, 2009 at 8:59 PM, Hannu Koivisto <azure@iki.fi> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Jan 22, 2009 at 6:17 PM, Hannu Koivisto <azure@iki.fi> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> This brings back my previous question: where is the home directory in
>>>> a Windows system?
>>>
>>> It's where %HOMEDRIVE%%HOMEPATH% points to.
>>
>> I thought it was something like that. Do we want something like that
>> in the manual, or should we assume Windows users know that?
>
> I should have added that Unix programs (i.e. Cygwin programs and
> even some native ports) probably use %HOME% which may be different
> from %HOMEDRIVE%%HOMEPATH%.  I recall that if you haven't
> explicitly set up HOME in Windows environment, Cygwin sets it up
> magically from passwd or falls back to %HOMEDRIVE%%HOMEPATH%.  I
> have no idea if msysgit respects %HOME% if it is set or always uses
> %HOMEDRIVE%%HOMEPATH% or something completely different (user
> profile, most likely).
>
> It certainly may be that "home directory" is a foreign concept to
> some Windows users.  Some might know it as a user profile or a
> personal folder (just guessing, I'm pretty isolated from less
> experienced Windows users), even though user profile is a separate
> concept from "home directory" (note that there is %USERPROFILE%
> which by default is the same as %HOMEDRIVE%%HOMEPATH% at least in
> XP).
>
> In any case, what Cygwin git does should be expected by Cygwin
> users.  If msysgit wanted to be a really native Windows application
> and store the configuration where Microsoft thinks it should be
> stored, it probably shouldn't store the config under "home
> directory" to begin with (I'm guessing that's what it does) but
> under %USERPROFILE\Application Data\Git (...FILE\Local
> Settings\... in case non-roaming storage is wanted).  And in that
> case the manual might be misleading for msysgit users.  See
> e.g. <http://msdn.microsoft.com/en-us/library/ms995853.aspx>.

Isn't that enough argument to stop assuming the user knows where is
the "home directory"?

-- 
Felipe Contreras
