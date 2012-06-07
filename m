From: Leila <muhtasib@gmail.com>
Subject: Re: introduction
Date: Thu, 7 Jun 2012 00:00:44 -0400
Message-ID: <CAA3EhHJaLuz05XJ51pbe=iHzPjg3vcgQAx9ceg00p+006yFQhg@mail.gmail.com>
References: <CAA3EhHJCRF05Q0xzzOWupVMjmKPbWAq1KNcU9Mmp8g1iH2B0zA@mail.gmail.com>
 <CAA3EhH+P_JeVGhRmL-kHOc0cTCiGQmv505XjgAv0kT1PAfjTyw@mail.gmail.com> <4FCDCB8B.4000103@schu.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Michael Schubert <schu@schu.io>
X-From: git-owner@vger.kernel.org Thu Jun 07 06:01:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScTuf-0006aL-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 06:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745Ab2FGEBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 00:01:06 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46384 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab2FGEBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 00:01:05 -0400
Received: by vcbf11 with SMTP id f11so91595vcb.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 21:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MNR/pvfxAKLehTMUlhr2NBzhz9He2eBQkcMJMgt5+s8=;
        b=J/HyXuK8D3ru2kFnvuW3l0WLi4q6+OQcukxTgFEUVK1LHNPsnGeGaola+DyyY02O2P
         lD71N1fnsi4ajEyF2jHjvcE5QYASvFTTJPZlFFrrYM49OrM+nkud1Qso37WBDP789Bta
         rIVoicI+TLprXaIpHQzXZdq/7b/j6Zm29sr1o3b7B0Ulfudywi8XyTq6fCMLAGeWXfnY
         b/xmcm9o7WCC+d1okKhLeFtRgcfYpP6DbZcuHvw9j39LjxlZ2RRKchMcTnCMDlYMkiLw
         Sf0JGrJwi4BcoKHUJSkSkMIOpJWVma+G3m1EJlq9AxjRMm0jErd6PHFjoAq00ZEJ2bi2
         mNjw==
Received: by 10.52.172.203 with SMTP id be11mr548807vdc.40.1339041664682; Wed,
 06 Jun 2012 21:01:04 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Wed, 6 Jun 2012 21:00:44 -0700 (PDT)
In-Reply-To: <4FCDCB8B.4000103@schu.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199366>

On Tue, Jun 5, 2012 at 5:04 AM, Michael Schubert <schu@schu.io> wrote:
> On 06/04/2012 10:36 PM, Leila wrote:
>> 1) Commands are cryptic: I was thinking I could provide a wrapper to
>> simplify the commands, for example to undo a local commit, I can
>> introduce a "git undo commit", that wraps "reset" and will undo the
>> last commit. Or maybe "git rollback" is a better name?
>
> There's Legit [1], Easy Git [2] and probably more.

Ok fair.

>
>> 2) git undo command, that will undo the last command (if possible)?
>
> Not possible in general.

Undoing adds and commits? But I guess there isn't a long list here..

>> 3) Just like we have git-svn, maybe a svn-git?
>
> ?
>
>> Any help or if you can point me in the right direction, I'd appreciate
>> it. I can also start out by fixing some bugs to get into it. I
>> couldn't figure out how to see a list of bugs though.
>
> There's no bugtracker, just the ML.

Thanks!

> How to submit patches:
> https://raw.github.com/gitster/git/master/Documentation/SubmittingPatches
>
> You could check "old" GSoC Ideas:
> https://github.com/peff/git/wiki/SoC-2012-Ideas

Thanks I've reached out to Peff and Thomas.

>> How does one contribute to your documentation? Would it be submitting
>> a patch just like with code?
>
> Yes.
>
> HTH.
>
> [1] http://www.git-legit.org
> [2] http://people.gnome.org/~newren/eg/
>
