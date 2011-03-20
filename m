From: Daniel <daniel@netwalk.org>
Subject: Re: dependable submodules
Date: Sat, 19 Mar 2011 21:32:45 -0700
Message-ID: <AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>
	<7vd3lmv2k1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 05:32:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1AK2-0004m2-6X
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 05:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186Ab1CTEcr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 00:32:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58266 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1CTEcq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2011 00:32:46 -0400
Received: by wya21 with SMTP id 21so4938828wya.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 21:32:45 -0700 (PDT)
Received: by 10.227.37.28 with SMTP id v28mr2846035wbd.75.1300595565226; Sat,
 19 Mar 2011 21:32:45 -0700 (PDT)
Received: by 10.227.2.148 with HTTP; Sat, 19 Mar 2011 21:32:45 -0700 (PDT)
X-Originating-IP: [216.228.174.132]
In-Reply-To: <7vd3lmv2k1.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: wgdpJFk2_WT2N-QJZOLBwTUII4k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169486>

On Sat, Mar 19, 2011 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Daniel <daniel@netwalk.org> writes:
>
>> IOW, I may have
>>
>> =A0 =A0 myrepo/somefile.txt
>> =A0 =A0 myrepo/another_project/.git/...
>> =A0 =A0 myrepo/another_project/another_project_file.txt
>>
>> and I'd like to, when I clone repo, to be able to get all files from
>> repo independently of the remote repo's existence.
>
> Cloned repositories from your repository can say where they get from
> "another_project" embedded in it in .git/config of the clone of the
> superproject. The supermodule may have .gitmodules that points at git=
hub
> or whereever your original upstream repository resided, but that is
> supposed to be used to only give you the default.
>
> When "another_project" you borrowed really dies and becomes useless f=
or
> anybody, you may update its entry in .gitmodules of the superproject =
to
> point at the public repository that inherited that submodule project.
> The project might be simply abandoned, in which case you end up being
> that inheritor.
>

So would it be correct to say that even though those files are
remotely fetched on a clone of the repository, they are actually
revisioned and stored in the super project?

This would have to be true for me to be able to still be able to
access those files in which case the project was abandoned (or if I
lacked internet access).

-d


--=20
"America was founded by men who understood that the threat of domestic
tyranny is as great as any threat from abroad. If we want to be worthy
of their legacy, we must resist the rush toward ever-increasing state
control of our society. Otherwise, our own government will become a
greater threat to our freedoms than any foreign terrorist."
=A0- Ron Paul, Texas Straight Talk, May 31, 2004
