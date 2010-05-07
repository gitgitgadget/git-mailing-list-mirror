From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Fri, 7 May 2010 16:56:17 +0000
Message-ID: <AANLkTinhh8TXY9r9Jf394YKYXDxpU65qjg7MbPcb12Ls@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	 <1273180440-8641-1-git-send-email-avarab@gmail.com>
	 <AANLkTik6z4cvUzjfq-q61tgk_MhqWKc_A55i3VauPSQC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 07 18:57:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAQs4-0007zn-23
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 18:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab0EGQ5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 12:57:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34990 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab0EGQ5e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 12:57:34 -0400
Received: by gyg13 with SMTP id 13so737399gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Msyk72AMtLOAAJhwJlpg3kBTLjUpXOWYmyuUg3mi23E=;
        b=YpO9ckef0dGwec4Fo/SkqGD7k2bARmFPlmB72BsUlPOmw9VjaaC7gy3K80VeI907Pz
         HgohAQ4BCCYjs2gf3EQNvfnB9yi9scrJX2M3oaye8P31oaUpDMQKZdQdt3qaBqGcGTQe
         cHig/0yl6YvdyJ+M7paxEND1mwxjFYOmrTGIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HI0H9Dihh+mKsbLNxkuwajuD8zi2fxFs0hLRllquOR+VklWVsfoh2pXAxXArwj/ins
         O+ue2A3Teb4QmjW2z7qBqauk38uszu2NnQC7q0ULAJpDd7Qyrx5j1J75dDmVytO+HJP4
         o599tDyoiaY7mueQcplMuNv3JjvxdsrKFyQvs=
Received: by 10.231.173.129 with SMTP id p1mr53722ibz.85.1273251377475; Fri, 
	07 May 2010 09:56:17 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Fri, 7 May 2010 09:56:17 -0700 (PDT)
In-Reply-To: <AANLkTik6z4cvUzjfq-q61tgk_MhqWKc_A55i3VauPSQC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146542>

On Fri, May 7, 2010 at 06:00, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> On Thu, May 6, 2010 at 23:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>>
>> Not-signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
> So you don't agree to the Developer's Certificate of Origin, don't yo=
u?

Signed-off-by is for "if you want your work included in git.git"
(according to Documentation/SubmittingPatches). I don't think this
patch is ready for inclusion as-is, but I wanted to solicit comments
on the general approach.
