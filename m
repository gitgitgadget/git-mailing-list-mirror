From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Sun, 14 Nov 2010 23:04:04 +0100
Message-ID: <AANLkTiktg4aZ7VfdXUT9XF4RK7MuCvzevB5jSRaNiE1L@mail.gmail.com>
References: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
	<20101114215442.GC16413@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 23:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkgG-0002cL-JE
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 23:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab0KNWEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 17:04:07 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47997 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab0KNWEG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 17:04:06 -0500
Received: by iwn10 with SMTP id 10so5940030iwn.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 14:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BER4Li9AnjBOJUpVNc1UFry++czxT9v9FALbN8CUmZI=;
        b=v5KdV2/dO+grQHevnHVknek0r/QqGhZjFGAlK9WFgV1SAilitv0vby+PmCI5l8NxWN
         eS2KMLCN8CLkDayXGsS+N8wcFnRaXu30TRE63yH92v1h/26cyUj7o+NPOHMahVW27Ori
         a1gKlxJC0bfeduxyw+u39YUKGGzqDvsB4SzdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=teuFFpXe9BLSdIAf8b0R9OamUI2/MPm4Jac9sesJBbwNIK9wMefsyA+H37k72O8Gqr
         X9pbQ/hvF0L4hTmsgEDDcg+RVokZr4jNnjcxwLPq0K58yL9UEORPaHKOlOXgDHj2BxZP
         D2d15t4D+RF7HHm6X6vAe/GOMWdmrBQEOPgi8=
Received: by 10.42.207.202 with SMTP id fz10mr74881icb.374.1289772244449; Sun,
 14 Nov 2010 14:04:04 -0800 (PST)
Received: by 10.42.167.1 with HTTP; Sun, 14 Nov 2010 14:04:04 -0800 (PST)
In-Reply-To: <20101114215442.GC16413@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161454>

On Sun, Nov 14, 2010 at 22:54, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Bert Wesarg wrote:
>
>> There is one feature that the upstream git gui lacks[1]: This grep g=
ui can start
>> the git editor on every line by clicking with button 2 in the result=
 area. The
>> git editor will than be started with the environment variable FILENA=
ME and
>> LINENUMBER set but no argument given. This makes it possible to dist=
inguish
>> between normal, blocking edit operation (like git commit) from this
>> open-and-forget type of operation.
>
> This sounds like an excellent sort of thing to add to git grep -O, to=
o
> (which currently has very limited support for editors' line number
> features). =C2=A0But what will it do with typical non-git-specific se=
tups
> like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0VISUAL=3Dvim
>
> or
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EDITOR=3D"gvim --nofork"
>
> ?
>
> Do existing editors support LINENUMBER in the environment?

I don't expect this, I have a wrapper script around my editor to scan
the environment for these variables and pass the block/non-block
option to the editor.

Bert
