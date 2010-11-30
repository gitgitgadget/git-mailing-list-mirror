From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
Date: Tue, 30 Nov 2010 09:09:42 +0100
Message-ID: <AANLkTindvz=7OmYaL6AL_oAj50U9PLnRrbSpjgR92z7C@mail.gmail.com>
References: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com> <ADC46761-DFF5-486D-B604-05BA8C8631EB@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 30 09:10:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNLHw-0004mC-Ka
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 09:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab0K3IKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 03:10:04 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40216 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252Ab0K3IKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 03:10:03 -0500
Received: by iwn5 with SMTP id 5so1185325iwn.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 00:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=PgX67AZZB8zgwD6b1spL7DIENPy0FqyzGC9XnPi0cMI=;
        b=CNVoJka2wHx1+1uy6qtOhN/Le3/pksBocrCLedoceJ2O18p+FxZZJSOsX9PtTw6pgZ
         hJIxmyCvgZ1D1El8agMURftJ4QYCn2EX6tpbL44TncpDywXXviWsdAcdRD17H6aecXT2
         jp5snW+erbbh44nX3f1MSwdMnZ58h8SPFoSnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WWaToK3zYMphijfm+gotYblacjhKCxSC+zqFqq9URWnlDoN1B9g9ApbzROc/dfM8HN
         KM7kjrWPxcKVgdRdpeBcwfZRuewm8zFO8jC/VTGblqrvPHDUV2ExC2bMt/lXL4hYv0up
         UFzqP2fnoqc4FVMjL2XZzat9NqUFzGR5zWxD0=
Received: by 10.231.39.137 with SMTP id g9mr6870299ibe.101.1291104602648; Tue,
 30 Nov 2010 00:10:02 -0800 (PST)
Received: by 10.231.153.203 with HTTP; Tue, 30 Nov 2010 00:09:42 -0800 (PST)
In-Reply-To: <ADC46761-DFF5-486D-B604-05BA8C8631EB@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162474>

On Mon, Nov 29, 2010 at 11:57 PM, Kevin Ballard <kevin@sb.org> wrote:
> On Nov 27, 2010, at 3:15 AM, Giuseppe Bilotta wrote:
>
>> This allows people (like me) that forget to sign off their commits to do
>> a single rebase pass e.g. while preparing the patchset for submission.
>
> You're probably already aware, but git format-patch supports the -s/--signoff
> flags to sign off commits as they're prepared. There's even a config var
> you can set to make this the default (format.signoff = true).

That works if you're sharing your patches with format-patch, but not
for example when asking for a pull. Maybe I should extend the commit
message to include this case.

-- 
Giuseppe "Oblomov" Bilotta
