From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 13 Mar 2016 16:28:55 -0700
Message-ID: <CA+P7+xp3drFd9rSkxSH9P4PfxFrXvDU9kFib1dtBFdVC5R+ZRg@mail.gmail.com>
References: <56E3BE3E.9070105@gmail.com> <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
 <56E5B27D.7010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 00:29:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afFRo-0004cy-F3
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 00:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbcCMX3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 19:29:16 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34946 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbcCMX3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 19:29:15 -0400
Received: by mail-ig0-f176.google.com with SMTP id vf5so48776570igb.0
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 16:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WfIHz0s9skkw3nKjWF9QVH3t3IEQGbVtp9um0sHOLNM=;
        b=cVXMv4BKuT5P6yqk9OWB0kDSUb8o6gLoabufjLi8hyzzsVCdTP64z49oHy+JuG5zz7
         +sbPVwzZPF8V10pvhqzJESPagZD8Irhvb8c4/YznQ/kf7n88m1VkN91fC9MTivWjRbHE
         o6kVQNKguHT8c79t0FUmF9fnmEKdeCLTRQy3sZU8d3nZ/ILzarr+aROGgw/iyRqklmph
         XPWk9GnulpJnFAv9YsDSJfXj5BKcfOKy9gFZUEjVU01Qvk7tuO4rgNOGrRwYfBWvPe3M
         1/Dnf4ak1VXno7c6S9EkBYGhP9ORZTl77jE+f1pIhFUiN9wgig3zJm5o0aeaTCtUxZJo
         m7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WfIHz0s9skkw3nKjWF9QVH3t3IEQGbVtp9um0sHOLNM=;
        b=fJVfp/Z8y9Liy9zrpZlysiY3pjezbUVX+FKoiBvq2lBDt/SWMjaJ/6ldTfO8Iq1Ddy
         lmIDYrVFfxXfTjSj6QoRbQ19UWPDs8hb6cSchAziUW2rQtpIYnPfUzm76ypvkYpUP60X
         KZhqDkh53gUSWzRaJJs/Tv/VC5Mx5QN5vJHN0AuRa88ehKbY9FN2gaLE6iyzDoolQwmZ
         fZ0ou6Vu1X+H8Fvjoq/H3NJaWpMSWDWY+qlMqdhX0cv9BgjoA4Rya9Z46DVAGUDHFTJI
         eBH/VzzzwYxFYkQk9R+2yxRfex81wxO+HxYCcNbaX+9g3m8LEwOdzaRDSIzt3uC8jxS4
         c1Iw==
X-Gm-Message-State: AD7BkJKbTPSSHg7xB/DgTfPIxWvYzMuKWpV+8r7BWaX6mMd4SVXHcXoMfIuCpypZ1mto0j2GEp1rTdZxDHTNGQ==
X-Received: by 10.50.43.168 with SMTP id x8mr14917125igl.92.1457911754356;
 Sun, 13 Mar 2016 16:29:14 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Sun, 13 Mar 2016 16:28:55 -0700 (PDT)
In-Reply-To: <56E5B27D.7010808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288761>

On Sun, Mar 13, 2016 at 11:33 AM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
> Coincidentally, my approach too is a wrapper around git as you suggest.
> The approach is simple and straight forward, but I wasn't sure if it would be
> accepted on the list, mainly because it may not look consistent with the current
> interface `git command [options]`. Perhaps a configuration like
> `core.beginnerMode` [4] might be apt? By default, it can be false, making git
> behave normally. When set, a safety-check can be run before the command is
> executed to ensure it's not potentially destructive. Very much like a wrapper
> but on the inside. There can be an option like `--no-beginner` to override
> this configuration from the command-line. I was wondering if there should be
> command-specific options as well, such as `beginner.allowForcePush`,
> `beginner.allowRebase` etc. for a finer control over what commands git would warn
> the user about. By default, all are set to false, and warning is shown when any
> of them is encountered. Another configuration that may be considered is
> `beginner.strict`, which when set would just print the warning and die, instead
> of giving the user an option to continue (though I'm a little unsure whether
> this one would be a good idea).
> One thing that bothers me about this approach is that unlike the explicit 'ggit'
> wrapper, an internal wrapper would add (unnecessary?) overhead for most commands,
> thus impacting the performance. Will that be an issue?
>

If I recall correctly, a configuration setting was previously
discussed but mostly discarded as a solution since any changes had
better not impact any current scripts. Having to add "--no-beginner"
for all of them seems unacceptable. Especially since many scripts may
do potentially dangerous operations in a safe or useful way.

Thanks,
Jake
