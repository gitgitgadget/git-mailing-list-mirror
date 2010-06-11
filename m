From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Git sideband hook output
Date: Fri, 11 Jun 2010 17:11:18 +0200
Message-ID: <AANLkTimPI-A_4H-vYtHIyfbSLERDo0vu-kbB3Qu3ZT06@mail.gmail.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
	<20100608214632.GN14847@spearce.org>
	<A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
	<alpine.LFD.2.00.1006090934320.30664@xanadu.home>
	<A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
	<20100610183019.GR14847@spearce.org>
	<AANLkTikQQh4sUA7h2k1jvQ7aMgYyq7WFetJvJZvqpVxt@mail.gmail.com>
	<AANLkTikYBB1DsGRRsu4pSNr1j8fFXD-99c4lRAaBqd3M@mail.gmail.com>
	<3B9F4351-4608-455E-B433-A5337A946F8A@wincent.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>, Scott Chacon <schacon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	git list <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 17:11:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON5tE-0003sd-PM
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 17:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0FKPLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 11:11:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33876 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab0FKPLT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 11:11:19 -0400
Received: by gye5 with SMTP id 5so749984gye.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=4bVeJIU1ENvDd/PEkfoUZ6qq+fWnL2oeNuG2KAL5TYg=;
        b=KkKGIrEyYel/EUYsR0Nvq3NOe4wSzawYooKlu+1BSbUJcntyyHoIzp7EUnNL5LE2y8
         is9JxT2NtTsQO6UxaTbkKdjYXv7cad8QtvPjcM/zYTIOudxjeylhOQId560j84j4Rxrd
         8aZs3QivxPhi5j3ZY3RVVEVnyoqT6tA7MNtSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=L+a5Ok6f+lt40yXoO0eUTb0sSCvOdvSO6KB5fWm3c7Gmul3s1l5xwXsTDyW74ueImX
         /CaJ/94QQFEaRmqf9nQLsb2LaRaFRI9HS/SBn1H2vdwL2rvMoT3Io8u+JeV5WaD8D+f+
         pT3XYRzNKnq4ly2O//hlvl192fnmfb59ad9Sk=
Received: by 10.216.85.85 with SMTP id t63mr875120wee.86.1276269078357; Fri, 
	11 Jun 2010 08:11:18 -0700 (PDT)
Received: by 10.216.53.132 with HTTP; Fri, 11 Jun 2010 08:11:18 -0700 (PDT)
In-Reply-To: <3B9F4351-4608-455E-B433-A5337A946F8A@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148953>

On Fri, Jun 11, 2010 at 4:45 PM, Wincent Colaiuta <win@wincent.com> wro=
te:
> El 11/06/2010, a las 16:34, PJ Hyett escribi=F3:
>
>> Hi,
>>
>>> On Thu, Jun 10, 2010 at 8:30 PM, Shawn O. Pearce <spearce@spearce.o=
rg> wrote:
>>>>
>>>> If its really a problem, maybe "remote: " prefix should turn into
>>>> something shorter and language agnostic, like "<< ". =A0But thus f=
ar
>>>> we hadn't had to worry about it, since we didn't have translation
>>>> support in Git... =A0(though yes, I see that is changing now).
>>>>
>>
>> I'm also in favor of making the default '>>' instead of 'remote:' if
>> nothing isn't an option.
>
> Funny, as '>>' is basically meaningless. At least 'remote:' has seman=
tic value (ie. it indicates _where_ something is coming from).
>

How about '> ', which often means "quote" (e.g in e-mails)? Would that
be appropriate?

--=20
Erik "kusma" Faye-Lund
