From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v2 00/29] Teach guilt import-commit how to create legal
 patch names, and more
Date: Tue, 13 May 2014 23:29:55 +0200
Message-ID: <CAP=KgsTvt7btB0EO75UeW2SejeXm9u7nfPLf0J2M+Y2H=u9s5w@mail.gmail.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
	<20140513204546.GB11391@thunk.org>
	<20140513205443.GB4791@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Theodore Ts'o" <tytso@mit.edu>, Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 23:30:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKGu-000106-3y
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbaEMV35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:29:57 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:63825 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbaEMV34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:29:56 -0400
Received: by mail-ig0-f172.google.com with SMTP id uy17so5772131igb.11
        for <git@vger.kernel.org>; Tue, 13 May 2014 14:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hhUu/b24TteNlRyZl5bfpJYy119bjCA3JS0XV2IQtLs=;
        b=T1qhwtVen27cfwfs0lCuz5Bt0fTNJxeplOkGu21VbT4bC1lvenvL4ACdbprEttDCEK
         QAvSHqR57iUZjJtinHd7FykmdTe7pVqcbBmkgat3OtLXjCNhKXkD8+ywTRbX7LDLL3LG
         M69F+tH5165zR+qGT9D8y2gtjXi7k0iGfJCMHcgqYHPITrT3VrdSC5/nsU9UyjSQfh70
         /l3a/iBVupcljIG/2tdSLNSVa2OA3fiVNC0s5k7iB0UIb1mIpN/W/Kkw+r5zAqs/MylQ
         f7OiqIk6zC4FczdA+VH+eJqPANUhkdgnuyFjOCCgoKJCfM6zclco64rQsDUpfpzUAW/F
         NhhA==
X-Gm-Message-State: ALoCoQkSDHo9kLAU2Y61JEzrFnPkCc7KljDXiW/00QOn41Kr7Nlkq6u1inr0Y0H9M8Fyyhz70e/6
X-Received: by 10.42.30.71 with SMTP id u7mr1934398icc.20.1400016595645; Tue,
 13 May 2014 14:29:55 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Tue, 13 May 2014 14:29:55 -0700 (PDT)
In-Reply-To: <20140513205443.GB4791@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248859>

On Tue, May 13, 2014 at 10:54 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Tue, May 13, 2014 at 04:45:47PM -0400, Theodore Ts'o wrote:
>> On Tue, May 13, 2014 at 10:30:36PM +0200, Per Cederqvist wrote:
> ...
>> >  - Changed behavior: by default, guilt no longer changes branch when
>> >    you push a patch.  You need to do "git config guilt.reusebranch
>> >    false" to re-enable that.  This patch sets the default value of
>> >    guilt.reusebranch to true; it should in my opinion change to false
>> >    a year or two after the next release.
>>
>> We've been living with the "origin" -> "guilt/origin" branch change
>> for a year already, and in fact, these days I've gotten used to the
>> new behavior.  Is it really worth it to change the default?
>
> So, at first I was skeptical about the branch name prefix change.  I've used
> it for about a year now, and I love it.  When I first read Per's idea to
> change the default to the old-style, I was a bit sad but I understand the
> motivation.
>
> I'm open to either mode being the default since it's easy enough for me to
> change it for me (thanks, ~/.gitconfig) but I think more people should
> benefit from the added safety against accidental git-push.  (I also like
> being able to use guilt/master..master to get only the commits I care
> about.)  Thoughts?

I don't have a strong opinion on which the default value should be.
The scenario where it matters, when you run multiple versions of
guilt against the same directory, is probably very rare in practice.
If it is mentioned in the release note that it can be changed if needed,
that is probably good enough.

    /ceder
