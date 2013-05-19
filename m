From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: About overzealous compatibility
Date: Sun, 19 May 2013 09:27:38 -0500
Message-ID: <CAMP44s0egmU8jd2+JS3WVcW6R+CMWxbRpSKDaJ5fs7S8Fj+v=A@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	<7vk3my33vb.fsf@alter.siamese.dyndns.org>
	<CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
	<7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
	<CAMP44s3xdWzVviPvrN7D1fTG6Lwgg-dEzju--VuiwZA-8bV+MQ@mail.gmail.com>
	<7vtxlz1pr1.fsf@alter.siamese.dyndns.org>
	<519885a591924_7301727e144294f@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 19 16:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue4aP-0003Mz-2A
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 16:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab3ESO1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 10:27:40 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53652 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab3ESO1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 10:27:39 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so5806231lbf.0
        for <git@vger.kernel.org>; Sun, 19 May 2013 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1YmuIGWaVjwDE9DxeGRDQRnbcc9YeAQznS+wOYgbkuA=;
        b=0Sy3pKrRnql5C12FcthYoeXtDSLfJ5DpaIyOva96GU+huXCkm9vXK53qx2CVJCXd4F
         PmGd1Kw796hofrTjtx/KDkxHmzcVmc5sNO+zfNHYVx44Dy+SMbaI/kz1lZNlXzL023Ho
         4xzw2B2uDa12ttFNKgZC+r+6YBt9nkLolvc4VKH0YRguL1lq2KGODgLJa5WJSlloVi1g
         GD5qevgHmy2MsISfyCWp5uYnUA/4sHH7io5Lo5utvUQ7Ae3wbxDviKRRK3F8V/kkRBJW
         QxDoqU8dxM8uVIyOsi4mE0D/9S6atWlgYW4TSokmVL8y8tfKCMFuLmSXyVKTJNNmZDgE
         Lz3w==
X-Received: by 10.112.63.169 with SMTP id h9mr11198529lbs.135.1368973658198;
 Sun, 19 May 2013 07:27:38 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 07:27:38 -0700 (PDT)
In-Reply-To: <519885a591924_7301727e144294f@nysa.mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224887>

On Sun, May 19, 2013 at 2:56 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > On Fri, May 17, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> >> So when "the user" is running "git fetch" on "mywork" branch that
>> >> happens to be forked from a local "master",...
>> >> we still need to have FETCH_HEAD updated to point at what we would
>> >> be merging if she did a "git pull".
>> >
>> > No, we don't need that. That is only needed by 'git pull', and in
>> > fact, it should be possible to reimplement 'git pull' so that it skips
>> > FETCH_HEAD when the remote is local.
>> >
>> > These are mere implementation details.
>>
>> You seem to be incapable to understand what backward compatibility
>> is.
>
> Really? Do you even remember the time when you changed out of nowhere
> all the 'git-foo' commands with 'git foo' and all hell broke loose?
>
> I remember some lonely voice of reason shouting for clear deprecation
> warnings:
>
> http://article.gmane.org/gmane.comp.version-control.git/94262

After re-reading this old thread, I noticed that you didn't get a
straight answer, nor was there a neat conclusion, and the good replies
might have been lost in the noise. So this is what you should have
done:

1) Fix all the tests and documentation to use the 'git foo' form, so
everything is consistent and the proper form of the commands is
explained.
2) Release v1.6.0 turning on annoying deprecation warnings telling
people to stop using 'git-foo'. This wouldn't have had the same bad
effect that v1.6.0 had, because you added at the same time a
configuration to turn the annoying message off, so users, and
administrators can choose to ignore the warning, and then they
couldn't complain when the 'git-foo' links get removed for real.
3) To be absolutely sure that people get the message that there's a
big change, name the release v2.0.

I think 3) would have been overkill; v1.7.0 would be OK, but 2) was
definitely needed, and 1) would have been great.

I think it's extremely cheap that you accuse me of not understanding
backwards compatibility, when I did for zsh's completion[1] exactly
what you should have done for v1.6.0: add an annoying deprecation
warning.

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/210024

-- 
Felipe Contreras
