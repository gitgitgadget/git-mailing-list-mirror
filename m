From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed <paths>
Date: Sun, 15 Aug 2010 08:38:16 +0000
Message-ID: <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
	<20100814210505.GA2372@burratino>
	<7vvd7chcj4.fsf@alter.siamese.dyndns.org>
	<87tymwzjbk.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ralf Ebert <info@ralfebert.de>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 15 17:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkfZu-0007Nh-6R
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 17:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758216Ab0HOP4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 11:56:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48152 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757839Ab0HOP4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 11:56:45 -0400
Received: by iwn7 with SMTP id 7so763627iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nT5YYjhr42tiZl9Hm36S8Cdi2B9ZajS5awLLFtQnO98=;
        b=Vitm/bTZq+TOqZA9nDeba/LbJrSWPc03Pa7/Vhz4Pw9OZx1QfQ6z8PPugdUgWLIB5V
         i37n80iWzi23F5e2D6BM+WQNbOH2YilY9WYcPZn5qU6qQBN1vPaXs09VpWxzVLJ/Gg2s
         Kxg8fUm9/qA2JW2MoxKA5AMs6W9N0/q5jChrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FErvmhvcrn3MAGY6xJusWzbNARWbPASe8TIUCLinZmi0sRgPhxkexXsWCq321E23UO
         takfrcD8yrjj3ikW+bZ9SRccZMBXwBB/XGvJGohEXYrZxThgiKkL2UntkiVDA5/Jqz48
         tyMFxB2vNM2tsRAkECj/HEx6u3vStmbsjlqr8=
Received: by 10.231.150.7 with SMTP id w7mr4224997ibv.14.1281861496247; Sun,
 15 Aug 2010 01:38:16 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 01:38:16 -0700 (PDT)
In-Reply-To: <87tymwzjbk.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153605>

On Sun, Aug 15, 2010 at 02:43, Miles Bader <miles@gnu.org> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>>> =C2=A0warning: --mixed with paths is deprecated; use 'git reset -- =
<paths>' instead
>>
>> That sounds helpful.
>>
>> We've been saying this form is deprecated since 1.5.4; a better
>> alternative may be to make this into an error in the next release,
>> though.
>
> On a similar note, how about a more helpful error message for
> "git reset --hard PATH"? =C2=A0It took me _ages_ to figure out that I
> needed to do "git checkout PATH" to get that effect...
>
> e.g.:
>
> =C2=A0 $ git reset --hard load-lua.cc
> =C2=A0 fatal: --hard cannot be used with paths; use "git checkout -- =
<paths> instead"

Do you have suggestions for alternatives for "git reset [ --soft |
--merge | --keep ] -- <paths>" too? Since I'm working on this anyway I
might roll that in.
