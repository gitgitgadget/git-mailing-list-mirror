From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] revert: allow mixing "pick" and "revert" actions
Date: Mon, 9 Jan 2012 01:47:33 +0530
Message-ID: <CALkWK0mYbBsZN1UX9YM0VWQezZsBpJCcEgKirCggtNXs0HZ-8g@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-5-git-send-email-artagnon@gmail.com> <20120108194014.GI1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:18:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzBp-0005Pj-9J
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab2AHUR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 15:17:57 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44756 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab2AHUR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 15:17:56 -0500
Received: by werm1 with SMTP id m1so2187455wer.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KP+f4t/k0a0QHOmjsS0PKDsoZnnGBD1HCsexmbqTgYw=;
        b=o80TXBTrkqZ51JaDl3ZH7FOuYut8d7bEVJF0swr0uvc3nUP0XLKMuKhysBcoFM9d++
         dL5M8nuI17vdMVs1GLeb7n1H050ENnQo1HNGDP8AcLU5gzdU+N8xnWUPfzeDehHlklQN
         /E4H7bWJlLKk4qWoMXbhmr+50ViauDvr2qSos=
Received: by 10.216.209.99 with SMTP id r77mr6297215weo.25.1326053874176; Sun,
 08 Jan 2012 12:17:54 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Sun, 8 Jan 2012 12:17:33 -0800 (PST)
In-Reply-To: <20120108194014.GI1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188128>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> Parse the instruction sheet in '.git/sequencer/todo' as a list of
>> (action, operand) pairs, instead of assuming that all lines have the
>> same action.
>
> Yes, I've always liked this one.
>
> Haven't re-read the patch to avoid wasted effort if there are changes
> when the previous patches in the series change. =C2=A0Maybe it would =
be
> possible to send as a standalone?

If I don't get manage to get the series right in a couple of re-rolls,
I'll do that.

-- Ram
