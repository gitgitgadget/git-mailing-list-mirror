From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2] Makefile: Improve compiler header dependency check
Date: Sun, 28 Aug 2011 13:47:46 +0200
Message-ID: <CALx8hKTx3r=ow+=jsCyvZGRJ6Yr+w9TT7=Uyi4y4+beOou45AA@mail.gmail.com>
References: <20110827162645.GA10476@elie.gateway.2wire.net>
	<1314478844-55379-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 13:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxdrq-00053V-10
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 13:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab1H1Lrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Aug 2011 07:47:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36375 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1H1Lrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 07:47:48 -0400
Received: by fxh19 with SMTP id 19so3667215fxh.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kcBzIxu+Dn+ghi2w3QxcTuBJUsbuGb53WD8/9TVYlCs=;
        b=dkn0K0oBhVxmkQ2x5N7OSkbsrXE+tRavDc59sSlw5ormenvsaa3QwhDnHFslp+4y7i
         yOn1A3PltlWXoI9qpGzWQJ5Dk57hqQe4rsYws3HaTxrxm/fZ4E97QXAQehxifaSR0c74
         msI7iZJ+3VAhIJ0redw7jE6p5knLhg6aREBNs=
Received: by 10.223.39.216 with SMTP id h24mr5166553fae.31.1314532066756; Sun,
 28 Aug 2011 04:47:46 -0700 (PDT)
Received: by 10.223.143.19 with HTTP; Sun, 28 Aug 2011 04:47:46 -0700 (PDT)
In-Reply-To: <1314478844-55379-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180265>

On Sat, Aug 27, 2011 at 23:00, David Aguilar <davvid@gmail.com> wrote:
> Make the check use the same flags as the invocation to avoid
> false positives when user-configured compiler flags contain
> incompatible options.

[...]

> I'm not sure if "sh -c" is necessary but I did notice that other
> parts of the Makefile use $(SHELL_PATH). =A0The check was adjusted
> to use that as well.

I'm not sure either. I just used what I saw at other places in the Make=
file.

[patch snipped]

Looks good to me. Thanks!

- Fredrik
