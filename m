From: Sorin Sbarnea <sorin.sbarnea@gmail.com>
Subject: Re: Unable to build git on Lion - missing config.h from Perl header files
Date: Fri, 19 Aug 2011 22:43:35 +0100
Message-ID: <CAGDPfJoG_ksfL5vqzGWe5jqW646CKB=Qxm9_G5d=ZHMWfixweA@mail.gmail.com>
References: <611AB1F99D784B92B1F7278139D6EED5@gmail.com> <CAGDPfJr01SPXvqDkYwingJ0Vu9DZx7GXO4G2uhFFfOWPvm1Rgw@mail.gmail.com>
 <9B588F2F-ACDF-4DA7-BE30-E075CA729731@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 23:44:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuWrB-0002xG-Bo
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 23:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab1HSVn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 17:43:56 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53950 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab1HSVn4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 17:43:56 -0400
Received: by vxi9 with SMTP id 9so2934180vxi.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vRz01yY2phPYIJQkwpNF/cfB7/cw709HJ04wiLhYCt8=;
        b=tmzWmPD4NxBrCqOyHd1nPRuwKrCOBFF5476vJJwEoBWYTc2wP96juiKxQdpwvxr0O9
         iD5UzYxTLJMQc5ivgyyAkORk+9Dxh4VIDwsBWOF4Op562sinIYTAUllAXH7LfrQjFvmH
         HBO71A5JkC9XdlgcQmgTZv5r+Yl2iRa9QptG4=
Received: by 10.52.97.227 with SMTP id ed3mr229746vdb.442.1313790235103; Fri,
 19 Aug 2011 14:43:55 -0700 (PDT)
Received: by 10.52.116.97 with HTTP; Fri, 19 Aug 2011 14:43:35 -0700 (PDT)
In-Reply-To: <9B588F2F-ACDF-4DA7-BE30-E075CA729731@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179728>

This was a clean-new Lion install, not an upgrade. I just installed
Xcode on alternate location /Developer41 instead of /Developer

Yes, I did a `make clean` but it has no effect.

The problem is that on Lion there is no config.h in the perl
directory, only a perl.h file.
--=20
Sorin Sbarnea

On Fri, Aug 19, 2011 at 21:58, David Aguilar <davvid@gmail.com> wrote:
> On Aug 19, 2011, at 9:31 AM, Sorin Sbarnea <sorin.sbarnea@gmail.com> =
wrote:
>
>> Hi,
>>
>> I came across the following problem while trying to build git (1.7.6=
) on Lion
>> https://github.com/mxcl/homebrew/issues/7091
>>
>> The only files existing in
>> /System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/ are
>> libperl.dylib andperl.h.
>>
>> make[2]: *** No rule to make target
>> `/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/config.h'=
,
>> needed by `perl.mak'. =C2=A0Stop.
>> make[1]: *** [instlibdir] Error 2
>>
>> If possible it would be a good idea to continue the discussion on
>> homebrew bug tracker
>>
>> Thanks,
>> --
>> Sorin Sbarnea
>
> Did you upgrade to lion from a system where you were building previou=
sly? Did you try "make clean"?
>
> --
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D=
avid
