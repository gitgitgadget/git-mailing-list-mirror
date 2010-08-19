From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] git-notes: Run partial expensive test everywhere
Date: Thu, 19 Aug 2010 15:50:09 +0000
Message-ID: <AANLkTikfwbtKt2WrxzRyKHnP3ySGtBF33=z_rJwjPx5Y@mail.gmail.com>
References: <1281470164-27008-1-git-send-email-avarab@gmail.com>
	<1281483468-24388-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 17:50:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7Nq-0005TF-HP
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 17:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0HSPuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 11:50:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58115 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0HSPuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 11:50:12 -0400
Received: by fxm13 with SMTP id 13so1150557fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+abHHUgIARtCTC8V6g+1DpU9RH8YXyqXI9ozGX8SYOA=;
        b=qnDX1rTc8O1uG+RQX4r9gNnj4vNh5IoqbqU2oJ/DsmxYdINuWCarL6xtTbFOqLlqJz
         Tkc2LrSHK8IIZonf6k1vSBlqD6/6BziJ14CKBFvJkl113FIitmibhfz5ktx2pSYhWP4P
         eQwCHrz72vGRNEeGuW+MB09QeNOY56J/RXKEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=njzp5JwxHynLP9l4EnIT1rF/ywXkZRGjoK1DJ6Fq4AmEXhQfQL06V7l5oJkDlMBdTF
         ukRqBThpzk3cbe41GkRloKXHfzbSGTeP0ob7Q1OWtIWsMBO3wYn6ZB1tDvvxmFMDyImk
         GdLmf84W3P/DV5MxgJmZi9UU46GBq1xwOPhaY=
Received: by 10.223.119.133 with SMTP id z5mr9571878faq.62.1282233010103; Thu,
 19 Aug 2010 08:50:10 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 08:50:09 -0700 (PDT)
In-Reply-To: <1281483468-24388-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153928>

On Tue, Aug 10, 2010 at 23:37, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> +test -x /usr/bin/time && test_set_prereq USR_BIN_TIME

It turns out that this fails on Solaris because its /usr/bin/time is di=
fferent.

Maybe this should just check if /usr/bin/time --version is ^GNU ?
