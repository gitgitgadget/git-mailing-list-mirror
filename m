From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Wed, 15 May 2013 00:27:15 +0530
Message-ID: <CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
 <7vwqr1jw67.fsf@alter.siamese.dyndns.org> <CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
 <7v8v3hjt57.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:58:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKQF-00011X-14
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247Ab3ENS55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:57:57 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:49244 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111Ab3ENS54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:57:56 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so1876866iec.1
        for <git@vger.kernel.org>; Tue, 14 May 2013 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZPLBJKeIaIAdNxJT1A9mrxmCF2uD41rLXh2odhDuIls=;
        b=t71ln2yRKETI3K17o6rjcAYgkeSQAu8QKkRuM9xH4FZPUxi03BGGyXALDZlkDqjKns
         DUPviBd/b0Z7rLe2Guk1lfgo466wQhpB4ObEeR/qcW/Qt8csBeZQG8nMZa/osqxqmTSy
         Ck17+bMpNbVTzcmqjGAKWh6+78z+0AzDIGqni+7VBGWipNAweyryEV00rQQD+O8I7Eug
         L0+ugRUFEbxxd7F0M30uWvIXlPbsww4WzwSFkRn1xn1Vpy5GQkxOJSFZAA4BhG2KI3st
         ngNIF6C08Z7ExzvOsn9k3dtYL1RTMY2dmUdXLQNX6AmfCIDSnneaMBV+F96417iqt6PV
         Qr+g==
X-Received: by 10.50.66.197 with SMTP id h5mr3044415igt.63.1368557876146; Tue,
 14 May 2013 11:57:56 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 14 May 2013 11:57:15 -0700 (PDT)
In-Reply-To: <7v8v3hjt57.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224316>

Junio C Hamano wrote:
> I do not use zsh but with bash+readline the old tradition lnext can
> be used (see "stty -a" output and it typically is set to ^V), i.e.
> \C-v followed by \C-i should give you a literal HT.

Just looked it up: zsh has quoted-insert (^V) after which I can TAB.
Still doesn't solve my problem though: I don't type out structs; I
paste them the X clipboard (Emacs).  And that doesn't work either on
bash or zsh.

What can we do to improve the interface?
