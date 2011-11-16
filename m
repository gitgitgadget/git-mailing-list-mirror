From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Wed, 16 Nov 2011 11:47:43 +0530
Message-ID: <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org> <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net> <7v7h31wduv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 07:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQYp4-0000df-R3
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 07:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632Ab1KPGSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 01:18:09 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:39628 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab1KPGSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 01:18:07 -0500
Received: by wwe3 with SMTP id 3so747041wwe.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 22:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eefqZ6cLdNr1qlbWITeO3aWWP3CZaHUeCujESqVGCZc=;
        b=fi5JqoCGytUOyITuGZy81oC5ThTmkaFKm9nAZ3gj2btFKmgM5dN0arfebAnIhSvQGK
         Hg1jEW+MEfZAy+ALkZd4ZZMABRt1Av4CJnNUfNefPDgQNZfiIcAUl++8Y2YfF55Ryn7s
         JsOT71X+t/vZ7zAVoJHGiuigsDsgqUFezoSX4=
Received: by 10.216.188.145 with SMTP id a17mr4924589wen.24.1321424285176;
 Tue, 15 Nov 2011 22:18:05 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 22:17:43 -0800 (PST)
In-Reply-To: <7v7h31wduv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185509>

Hi,

Jonathan Nieder wrote:
> Just use a sane idiom. =C2=A0Which means: as few git_path() values in
> flight at a time as possible.

Makes sense, thanks.

Junio C Hamano wrote:
> Or perhaps http://thread.gmane.org/gmane.comp.version-control.git/184=
963/focus=3D185436

I noticed that sha1_to_hex() also operates like this.  The
resolve_ref() function is really important, but using the same
technique for these tiny functions is probably an overkill; something
in `Documentation/technical` perhaps?

Thanks.

-- Ram
