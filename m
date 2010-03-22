From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 11:39:36 +0100
Message-ID: <81b0412b1003220339n80ab38bh9e1a70c197538ac2@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
	 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
	 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bo Yang <struggleyb.nku@gmail.com>, gitzilla@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 11:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntf2u-0007UF-AF
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 11:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab0CVKjj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 06:39:39 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:63807 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab0CVKji convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 06:39:38 -0400
Received: by bwz3 with SMTP id 3so5234380bwz.29
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mebta/DQ9eP0qVV6TtRIgnN3fvbxjCG6/TfDybB3i2A=;
        b=eNf548a7FmQzo3jAsewqmJy9NzXImnh2Vy8onn/hvbiXgGbNJj4A8BU5a8XU48uz5/
         cZx1aDmGcz4fYkfSjqPtbQ20KKoX3ouDar7fnSLdXE1Wn1F+LVR9xZEH+w4/o/mMI2zj
         U+TD4pcPdt7fTgOqA7mDlYKAdNz8kr88Yr4uo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GALRwOXjaLaYMrDywNIQD825tAvjWp+sETGfbvfv7QyHSK8QywWoX7FwioKEOZa4me
         sHPmp2wnlQaZufABm+pknnM5scFxUxBfG7Otrth1u/hPDtJKSYRvzVuCYN0T0NDDqyZt
         5VMhtWLYaoJj0GZYUuX7UZCAtY72uFH2oir90=
Received: by 10.204.32.196 with SMTP id e4mr4511169bkd.131.1269254376995; Mon, 
	22 Mar 2010 03:39:36 -0700 (PDT)
In-Reply-To: <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142915>

On Mon, Mar 22, 2010 at 06:32, Junio C Hamano <gitster@pobox.com> wrote=
:
> While I don't seriously buy "multiple files" either, if that is reall=
y

yeah, _really_

> needed, I could be pursuaded with =C2=A0"log -- path1:10-15 path2:1-7=
", or
> "log -L path1:10-15 -Lpath2:1-7 -- path1 path2" or something similarl=
y
> ugly like these, but that is not how we generally name things, and it
> probably shouldn't be a new option to "log" anymore.

But then, how about putting the "path" last in the argument,
so that the unambiguosly defined part of the format comes first?
Less need for quoting of ":" (or "@") in pathnames.
