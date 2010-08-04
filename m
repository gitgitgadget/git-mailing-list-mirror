From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Wed, 04 Aug 2010 12:38:25 -0400
Message-ID: <4C599781.2020603@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 18:38:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OggzE-0003Cd-Ba
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 18:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab0HDQib convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 12:38:31 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62493 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab0HDQia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 12:38:30 -0400
Received: by qyk7 with SMTP id 7so1357402qyk.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=gAx3XOdo2vzs+5FidbJV/CcFqHqVo1xy44IRg0Ohz5A=;
        b=vPKk6Ie2bWhRMZkdxAF7AU/4+5bMm/R1oyATZLcv07t6bQBLqgDbDWrg3ztURH8E7C
         8x3KUJa1r/zrskTJaly+0m3NlpdlcqRmoYL+OxTuSdn2oO61DqDOCcWfBne8GGsNCJ7G
         uwM8v86lZg52jRgzlA3tbFryvegxnClmaWzgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=wt7UUqqDoTilEAOwjg8s2b46FvDrq6vs2UYp0htmJnYaG8ojQK/CilLKoczPAYJ+vf
         WK1fwPHM9rz8zy3R+kyqZP0g9ib9M4tBv1MzpPHVpG+vmBcmdwItvdQMs/a87Ogg1HAG
         6RZ04Z9W1Z+cIYw+TzX4H0ywhpzaFJu4Q+Fkc=
Received: by 10.229.224.76 with SMTP id in12mr2600396qcb.81.1280939908519;
        Wed, 04 Aug 2010 09:38:28 -0700 (PDT)
Received: from [192.168.5.103] (pool-173-56-160-133.nycmny.east.verizon.net [173.56.160.133])
        by mx.google.com with ESMTPS id r29sm3124010qcs.1.2010.08.04.09.38.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 09:38:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Lightning/1.0b1 Thunderbird/3.0.6
In-Reply-To: <AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152586>

On 08/02/2010 05:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Aug 2, 2010 at 18:32, Joel C. Salomon <joelcsalomon@gmail.com=
> wrote:
>> I'd figured to play with Git in an unusual way: to create a reposito=
ry
>> for the U.S. Constitution where amendments are presented as patches.
>> E.g., instead of the First Amendment being placed at the end (as is
>> usual) I'm putting it in Article 1, Section 9 (Limitations of Congre=
ss).
>> Proposed amendments get branches, which get merged in later.
>=20
> I'd like to ask where this project is being hosted. I've wanted to
> play with importing law into Git, and it would be interesting to
> follow this project.

It's local to my machine for now, especially since I can't (yet?) get
the dates right. Also, I'm rebasing as I tweak the TeX code.

Law-into-RCS has been on my mind since I learned out what RCSs are for.
 Read any bill that the US Congress passes: there's an intro, a whole
lot of boilerplate, and then:

SEC. 101. EXTENSION OF CHIP.

    Section 2104(a) (42 U.S.C. 1397dd(a)) is amended--
            (1) in paragraph (10), by striking ``and'' at the end;
            (2) by amending paragraph (11), by striking ``each of
        fiscal years 2008 and 2009'' and inserting ``fiscal year
        2008''; and
            (3) by adding at the end the following new paragraphs:
            ``(12) for fiscal year 2009, $10,562,000,000;
            ``(13) for fiscal year 2010, $12,520,000,000;
            ``(14) for fiscal year 2011, $13,459,000,000;
            ``(15) for fiscal year 2012, $14,982,000,000; and
            ``(16) for fiscal year 2013, for purposes of making 2 semi-
        annual allotments--
                    ``(A) $3,000,000,000 for the period beginning on
                October 1, 2012, and ending on March 31, 2013, and
                    ``(B) $3,000,000,000 for the period beginning on
                April 1, 2013, and ending on September 30, 2013.''.

SEC. 102. ALLOTMENTS FOR STATES AND TERRITORIES FOR FISCAL YEARS 2009
              THROUGH 2013.

    Section 2104 (42 U.S.C. 1397dd) is amended--
            (1) in subsection (b)(1), by striking ``subsection (d)''
        and inserting ``subsections (d) and (m)'';
            (2) in subsection (c)(1), by striking ``subsection (d)''
        and inserting ``subsections (d) and (m)(4)''; and
            (3) by adding at the end the following new subsection:
=2E...

Sure looks like a patch series to me.

> There's some Icelandic law currently enacted that hasn't been changed
> since the 1200s. Getting that into Git would be interesting.

Extremely.

I'll put my Constitution project up on GitHub in a few days.  Just note
that I *will* rebase and publish.

--Joel
