From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: 'git add' regression in git-1.7?
Date: Fri, 19 Feb 2010 00:15:02 -0500
Message-ID: <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
References: <hll45t$50o$1@ger.gmane.org> <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com> 
	<hll65c$87a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 06:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiLD8-0007if-Lz
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 06:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab0BSFPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 00:15:23 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:41052 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab0BSFPW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 00:15:22 -0500
Received: by yxe38 with SMTP id 38so7155884yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 21:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lkBlMHi3aUIFbLUWnf4YkD7++gPwhJTjEIkvKWYpmGg=;
        b=t86Gut7stdKkbYh25+0N7MBK62DtBtQUGLvGhYn8fEDOcnSnp2W+jMBmEtB8/bl2Gk
         4wuFoqkIMtIQCiql+RAZMZK6xMvFGVeKvH6naO/jhnx4rQvTnytQJ6zq+YQDgeM/88Bi
         6KYMJ6g0icjpGKP05lWCpj5MQHq5MaqQ0VowI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Eruk+NPZn5C4IOzYLBBMLHMycOEq/H2l/HFcxhSuLevdkcBlfY9NrMmuf/qRmQmkMG
         c3s+TfNpMrMDS3cG674XgULZ1lVoobRSiNtYXlaK9OWSmoIaD9kPudojOzBICHDhbm9B
         DsRiuUGyYNi2GbGjpLAMkANBbEniXIH83S4OU=
Received: by 10.150.55.17 with SMTP id d17mr920268yba.155.1266556522082; Thu, 
	18 Feb 2010 21:15:22 -0800 (PST)
In-Reply-To: <hll65c$87a$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140408>

On Fri, Feb 19, 2010 at 12:04 AM, SungHyun Nam <goweol@gmail.com> wrote=
:
> Well, before sending the previous email, I checked the
> RelNotes-1.7.*.txt, =A0and could not find such a change by searching
> 'git add'. =A0So, I thought it's a regression.

As far as I know, git add has refused to add ignored files for as long
as I can remember.  Maybe there was briefly a bug in this behaviour
that was later fixed...

If you use 'git bisect' on the git repo, you could probably discover
what happened, in case you're interested.

Avery
