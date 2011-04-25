From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.5
Date: Mon, 25 Apr 2011 12:57:35 +0200
Message-ID: <BANLkTi=P699Rc3Y0KQL5BBY7A_3YhbyDew@mail.gmail.com>
References: <7v39l7mlwh.fsf@alter.siamese.dyndns.org>
	<BANLkTikhkCDZ5Crw+KGWBprXd6qoFOH8kg@mail.gmail.com>
	<m3oc3uwrja.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastien Douche <sdouche@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 12:57:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEJU7-0007jJ-37
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 12:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758332Ab1DYK5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2011 06:57:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60788 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758312Ab1DYK5h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2011 06:57:37 -0400
Received: by bwz15 with SMTP id 15so1536570bwz.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MldWjUB/cfnn6R2aiRfOeekFtbIKG7sZMdvhqyehAtk=;
        b=V4oYp2pPqpA2n5mzY3uUCA/00yLUIv6Hc5jTNS4XIYufYsggyKtlHfBc1VLR03vmV/
         y0dGgcZsxvz2yKajeqY6ZozYF7dkQuDzHjgNzhvzzxC/8XecgXYNAp5jpm1G+SkfL4UV
         eW6dhIXXX5Y/xNOyZVEl8x36EiB//ECfgf3cY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AbgnoxYyIVCuddt2aKGaFylAFd8KLxosBtHC2lPwglrmj70YNrEnE9pjQ6z4OvWtcE
         qvAiAqKwdRfxO3YjNbYIa/Cb2hPtl4vqZujC7VHjwb4kHitFuFQazm7mojrhesqBOUEH
         RCJ/fi/bKc1ACExj1XdaztrjtSft/HIj8FXc0=
Received: by 10.204.154.88 with SMTP id n24mr847900bkw.38.1303729055895; Mon,
 25 Apr 2011 03:57:35 -0700 (PDT)
Received: by 10.204.101.132 with HTTP; Mon, 25 Apr 2011 03:57:35 -0700 (PDT)
In-Reply-To: <m3oc3uwrja.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172026>

On Mon, Apr 25, 2011 at 12:32, Jakub Narebski <jnareb@gmail.com> wrote:
> Sebastien Douche <sdouche@gmail.com> writes:
>> > =C2=A0* The codebase is getting prepared for i18n/l10n; no transla=
ted
>> > =C2=A0 =C2=A0strings nor translation mechanism in the code yet, bu=
t the strings
>> > =C2=A0 =C2=A0are being marked for l10n.
>>
>> Where are pot files for Git and Gitweb?
>
> Actually only programs in C and shell scripts are prepared for
> translation. =C2=A0Currently there is no infrastructure for translati=
ng
> scripts implemented in Perl... including Git.pm module and gitweb.

Just the C programs actually, the series for the shell scripts and
Perl will be resubmitted in the 1.7.6 cycle.
