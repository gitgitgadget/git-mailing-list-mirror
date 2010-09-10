From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/5] gettext docs: the git-sh-i18n.sh Shell interface
Date: Fri, 10 Sep 2010 22:58:12 +0000
Message-ID: <AANLkTi=AFp+8+tHRNjiXbp_CymNLqCZQhMGcMe-1gsKe@mail.gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
	<1284147353-18000-5-git-send-email-avarab@gmail.com>
	<7vaanpgqg6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 00:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCYI-0006kX-Ku
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 00:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab0IJW6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 18:58:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58271 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0IJW6Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 18:58:16 -0400
Received: by iwn5 with SMTP id 5so2630887iwn.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0YDj6eHmn8/0hecKGTNB4tADQqKj6j2WLOt22FvbRCc=;
        b=QezG1clOApHPLtHYQOfpg9Kgx32v0j6sLzwfdPcF9NOiji98H28BNN17mU3/Owjq8T
         CD4/L0NDMKXD/q/9iyCJEb7CkVoqz81uOfVe39oAZDd/8y0Bfxb4C8MQmvlpkJrnr0p/
         jeLRHPWOlrxG4zFGky2LmmMGtVV7JanDpuS8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oICt9LfJnfbYkSTCHUcEy3+p664AzDZb/z64C74dPE7+h0blqXxS9YSsw442b5YZTc
         NJgkK6IR7wsfgWT3hZJOMSwc6RCY8l6HuaUBCX/IxanRYeeeYgE1DPGKP+GGMLkyn8L4
         XGiUp44TZG13sZ68s/TSLf0xgnWDi0PU5u0fU=
Received: by 10.231.183.67 with SMTP id cf3mr1661858ibb.187.1284159492407;
 Fri, 10 Sep 2010 15:58:12 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 15:58:12 -0700 (PDT)
In-Reply-To: <7vaanpgqg6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155980>

On Fri, Sep 10, 2010 at 22:54, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> + =C2=A0 =C2=A0 =C2=A0 git log --reverse -p --grep=3Dgettextize git-=
am.sh
>
> Running this from the tip of ab/i18n reveals that one commit introduc=
es a
> whitespace breakage ;-).

That breakage was actually intentional (and I *think* I noted it
somewhere). The existing "Did you hand edit your patch" in git-am.sh
already indented with spaces, and I didn't change it while I was at it
to keep the patch on-topic.

I was going to fix a whitespace fixup later.
