From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/1] connect: [host:port] is lagacy for ssh
Date: Sun, 5 Jun 2016 14:56:29 -0400
Message-ID: <CAPig+cQRVtEXrv-s1pTBK1vym2JN5ZWUE5i0eNdH0CEDxoqz-A@mail.gmail.com>
References: <xmqqinxozzuj.fsf@gitster.mtv.corp.google.com> <1465124993-3379-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 05 20:56:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9dE4-00025g-H5
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 20:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbcFES4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 14:56:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35476 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbcFES4a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 14:56:30 -0400
Received: by mail-it0-f66.google.com with SMTP id z123so3911906itg.2
        for <git@vger.kernel.org>; Sun, 05 Jun 2016 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BAsVWLNhJXlVGeyCz3bVN4QgAF1ciDfrjcZF2od7Qas=;
        b=KNYCzT69Nn0GYoj7z2+EBkHQdBMHYhVaD8EGUGxNfxjOO4QGt7WR3YRc/sYBIUKHzW
         VmeDmcrRzTv02haFeNolScX4yuJ2rCHsEyn6aMvjIkyb6tssX7L5MTKrU+zrvCS3UWxB
         ZIQzm9yW1KfSUs18mmwKI3JNqR4xdaVcA1TUQXextmVErurOonigmWZXxlSulQqRoxBq
         L5G75W8qvvvZjlte2qLK1oHI1Fx8OccSgjYNTo2R+OzrqAfIWBFOmN70PlbECqrrezAj
         Sk0AYumm9iG8RuxzageIN8Mo8ppBUoGhr/2U5Lz8WUC4BKo3EWcspDgOJTXXhW9TAD9g
         MqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BAsVWLNhJXlVGeyCz3bVN4QgAF1ciDfrjcZF2od7Qas=;
        b=JiNSPWoo9Yh3xDTEsXGO57ulipV78OTE2d5JfXgvoWGSUMCYiYwHW8HuGzvYECedOU
         de9QbruEzK7ewNxa1Da4+BWs/PV7zdJIr+YytRs2VjPDGbgPHpH55Z95M8exVPSybDxG
         Pd44dy3jo+nu9BjikMzBbL5uctJG1HbOaFwMBjSLG1J0EBKZcq2aSdQmIhliJZpqY6nv
         inRxIAaaRWMOX1ZvndZ/WVyD1T+k1jfvenGhtDAWwp9eDGuJVrqaCxpNb7+qtPKqMHyh
         JHdoZAR0hrmxoEizF0yP0XRrlKUvfap/y04mBUJ9oMbjczqO4pwFvItDUn13lecBcpj1
         7DOA==
X-Gm-Message-State: ALyK8tKJeMndbMv921MDPXjLY2JWs6WL71+sDQ52XNrp5OPTRmfP1Sqn/3E28t7z2MJXti7Ro1uWwAkephl7vQ==
X-Received: by 10.36.207.137 with SMTP id y131mr12202578itf.32.1465152989576;
 Sun, 05 Jun 2016 11:56:29 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Sun, 5 Jun 2016 11:56:29 -0700 (PDT)
In-Reply-To: <1465124993-3379-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: 2iTHY62S6AXKfDc-GlWHr_5gOBU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296477>

On Sun, Jun 5, 2016 at 7:09 AM,  <tboegi@web.de> wrote:
> connect: [host:port] is lagacy for ssh

s/lagacy/legacy/

> Early versions of the parser in connect.c handled
> git clone [host:123]:/path the same as
> git clone ssh://host:123/path
>
> Keep that feature as legacy, but disable it for all other protocols.
> Everything inside [] should go into the host part.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
