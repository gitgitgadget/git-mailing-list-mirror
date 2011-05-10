From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] completion: fix array indexing error after reverse
 history search
Date: Wed, 11 May 2011 00:19:53 +0200
Message-ID: <BANLkTimQmX+W1VQcmo9UkPP7cvkw+Se_xA@mail.gmail.com>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com> <20110510221430.GM1377@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	Stephen Boyd <bebarino@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 11 00:20:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvIF-0002Aa-0U
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab1EJWUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 18:20:34 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61687 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1EJWUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 18:20:33 -0400
Received: by qwk3 with SMTP id 3so3935654qwk.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=p2UbZH1VoTNoxj54FjqHxDtJgp7ZRb478OZKqNtqYis=;
        b=Xkp6wBmRe7QHCwAJSvqZ3In3h26f+VVArjVvoz4vpwKWlBXP/GN7LZvQ1qJMb4RklT
         DXuRSBXZ3t0z0I+VP01EfRFD0HK01Calkzx0kW2oer56NN7E9nUwUqRvASariAGuJ4SM
         KvPkbSIireNM3kKMCoBzVRwwOhdWeArJKY1zA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Hxb2t+5QyGxhwE1WutjYa+MpjFRH3aXf8211h6qmBL9pp0K9a8qrJ5piVjefs3VCOr
         0Kui9kbluT7w55MFWr0Dbjfj8OI33I0bg3RjkrbrCODIglsDyvnJ1hRpefMYNhvX/xrg
         nhgotFE8skP1M7Z3nEFmbtZc8YEYtAQ8YQrjY=
Received: by 10.229.45.203 with SMTP id g11mr6722764qcf.65.1305066033110; Tue,
 10 May 2011 15:20:33 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Tue, 10 May 2011 15:19:53 -0700 (PDT)
In-Reply-To: <20110510221430.GM1377@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173373>

Heya,

2011/5/11 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> Nice catch, although I have no idea why anyone would attempt
> completion at that point.

Wow, amazing turnaround, will test tomorrow :). I hit tab instead of
enter because I don't want to accidentally run the command.

--=20
Cheers,

Sverre Rabbelier
