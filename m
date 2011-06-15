From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Wed, 15 Jun 2011 13:45:57 +0000
Message-ID: <BANLkTikkOMmp869q8x4c8PPe1AGKP4+Qfw@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com> <BANLkTin9bhtB_OPMWCVsbtKBpRXp2o=uLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Dimitris Glezos <glezos@indifex.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 15 15:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWqQT-0006Sc-4c
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 15:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab1FONq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 09:46:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50490 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab1FONq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 09:46:28 -0400
Received: by iyb14 with SMTP id 14so289770iyb.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=VjLYp9nIMSdbjHMyuA3FVb4KNXZby11GeY0EMQmlTF8=;
        b=GO/JP7wNuDYc76ihqoRiDvIpvdXga0TdvN4QocKOlyVoFbx+qDBGsqHsHLF4Gsw7Uj
         E/cSIC0+lrcEyey5sfxIn3xhEsfEqoyXo3UeCju9G4s3h5y/KTNondeZEpQ0SVtuU7ud
         tO43ugFYtzPhxgQ9Qe4EVGluX2m+s4sV0IA7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EXWVWRhzZcgRDI/DrVprlZgV84vmF5sc4bMGlN1qke2NdatAcyqixGPRPCFm6KeJ6z
         tmwhV+OLarrNuSEujc/OmaB7Pbray3PvUlHga2kFTMhJTzy2bd/JzMPdaAH93dPAqAua
         BcRgDieMfSHip23Fn2fHDQrKHJZ0Lv5b5DBwU=
Received: by 10.42.100.72 with SMTP id z8mr575391icn.448.1308145587082; Wed,
 15 Jun 2011 06:46:27 -0700 (PDT)
Received: by 10.42.217.197 with HTTP; Wed, 15 Jun 2011 06:45:57 -0700 (PDT)
In-Reply-To: <BANLkTin9bhtB_OPMWCVsbtKBpRXp2o=uLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175830>

On Wed, Jun 15, 2011 at 13:21, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Tue, Jun 14, 2011 at 7:57 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> I think it's a good idea to use a system like Transifex to manage
>> translations for git.git, so that we can attract a large number of
>> non-technical translators.
>
> Are we sure we want non-technical translators to translate Git, a
> highly technical program with many technical terms?
>
> I'm guessing that Git probably should be translated by it's users,
> because we have a lot of Git-jargon that is difficult for people who
> doesn't know Git to translate. But perhaps an initial translation for
> each language is enough to establish a language-specific translation
> of all Git-jargon, and then afterwards we can get help from
> non-technical people to improve the language? I'm just asking, I don'=
t
> know how Transifex works at all...

I think your second paragraph ALMOST has the right of it.

Open source showed us the virtue of "Release early and release often";
it's best to get people using something even if it's crap at first,
especially because people can then figure out what needs to be
bettered.

Wikipedia showed us that if we reduce the requirements to contribution
(which, if you think about it, also means that backwards compatibility
must be largely forgone), then the net result is a constantly and
rapidly improving product (albeit with minor but inconsequential
setbacks due to fools and miscreants).

So, who cares if the translation for the N=C7=81ng=C7=83ke language (lo=
ok it up)
is initially junk at first; if it's easy to fix, then it will rapidly
improve into a steady state of high quality.
