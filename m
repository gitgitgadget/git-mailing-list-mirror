From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: [GSoC] Introduction and Project Discussion
Date: Sat, 19 Mar 2016 23:06:14 +0530
Message-ID: <CAJj6+1Ewdn_FNHR-qPqYzKEfQ6kgjXRBvc7dzMLK_2pPKukRvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 18:36:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahKnZ-0004BC-6C
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 18:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbcCSRgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 13:36:15 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34160 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206AbcCSRgP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2016 13:36:15 -0400
Received: by mail-io0-f175.google.com with SMTP id m184so170760163iof.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=1WbUbmRMUg0OeaQdZG9XkWvDeQukQvyeoDMPayS/zu0=;
        b=S0thAKlo2UZxS+LqZrWx4KdtJFb6lTnbBjHkm8OxpXSthppcD1J4Xw91S39uUkuRs0
         mYJblFGaxJiLqJHllSvYCO0pUBHUOQXhoEXZktJ2oE4E6NuvQYTEkI7LGdD5g/IdWmmC
         TcJp0uc6CjcaIzdLSnWhGtpPY9Y8HWdPNpgTsf8o/yIvIeNsESsHmODJwN3wzRbGOsRT
         MatBOhLDqDWRYrWBocuRXLXHbABz1mzv2m9qBC7pPRVKTMu2y+F7HgOteH5k27pZ4tJT
         BLJ6YS+vOzb1mYP7ChjPT5IJpb/s8cCk/LiX0lE7iKnZC7UzX42u8ApiLWP3kmFzAFWa
         BtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=1WbUbmRMUg0OeaQdZG9XkWvDeQukQvyeoDMPayS/zu0=;
        b=D6ElI5xmA3h/jAXGzQdxJAN5R/r3mJfE2tl66caYYhYFboQhj7vVRpf/Ah8I5IGtkY
         y4hPzBzZiAjJqtij9bnG0HgSrXqdave7VnyCFC9+aSngyo9MmkGIYLNdmUkLnziiTTRN
         FMtXXRPRge/I3cfsurWB/ey8DwhtuZUVzz4Ktt37GDZ2E+bnyFPx3kMJr/5Hb2TPaJEj
         BP2D3G7u6AxchjRmnu7Ue7cL2A03FlWP8B7YDbC50+7YMvBdgCl8CMXOmImEB7bFMEzV
         Ny41zUqaEc5dcxMBf4ZNCBNGtsTqZq2wcx8nM+V5hOBUzcrKc4pYLTTR1e3424Nw3s+a
         AG8A==
X-Gm-Message-State: AD7BkJJO+Mxqn7GMk4IICJOIAs6XIfVCFSCz7Es8jyqdxZyRsjJN+QelnhoUw9F3I9B9n4dWAKWfJEtlPAOiEA==
X-Received: by 10.107.2.148 with SMTP id 142mr17480062ioc.128.1458408974271;
 Sat, 19 Mar 2016 10:36:14 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Sat, 19 Mar 2016 10:36:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289316>

Hi,

I am a first year computer engineering student from India, studying at
the Silver Oak College of Engineering and Technology,
I had already put part of this in "[PATCH/GSoC] pull: implement
--[no-]autostash for usage when rebasing", but at that time I didn't
notice that another student was already working on the same change,
and I would like to apologise for that, it was totally unintentional.

I have since picked another microproject, "Make =E2=80=9Cgit tag --cont=
ains
<id>=E2=80=9D less chatty if is invalid", and after looking at the code=
, it
would have the same effect for any command with has a "--with" or
"--contains" option, which currently are 'tag', 'branch', and
'for-each-ref'.

I have worked on OSS in the past (and am currently semi-active as
well, working as a device maintainer with CyanogenMod, an android
distribution)

I would like to work on "Git remote whitelist/blacklist". The current
example on the ideas page [1] looks like something that wouldn't be
too much trouble to implement. Still need to dig a bit more on that.

I also saw Thomas Gummerer's idea on the list [2], seems like a reflog
on steroids?
I still don't understand the entirety of that, so some clarity on that
would be nice.
It also seems a bit complex

Apart from this, I was also interested in the "git config --unset
improvement" idea, as currently something as basic like
`git config --global foo.bar 1 &&
 git config --global --unset foo.bar`
leaves a section [foo] in the config.
I would like to try to solve this in some way without having to
rewrite the parser, but if that can't be done easily then I'm open to
doing it any other way as well.

So, to sum it up,
I would like to work on "Git remote whitelist/blacklist", and if the
mentors deem it to not take too much time / not be too hard of a task,
I could also try to look at the configuration parser.

Thanks,
Chirayu Desai

[1]: http://git.github.io/SoC-2016-Ideas/
[2]: http://article.gmane.org/gmane.comp.version-control.git/286708
