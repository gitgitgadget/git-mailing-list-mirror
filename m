From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/6] Fix the shallow deepen bug with no-done
Date: Fri, 7 Feb 2014 07:47:23 +0700
Message-ID: <CACsJy8AdOdVCma8FYeDM0kTd=Bgo-atpXmxFvmK4rzH6jOZEzQ@mail.gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com> <xmqq4n4cyr61.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 01:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBZbr-0004nl-94
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbaBGArz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 19:47:55 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:39821 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbaBGAry convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 19:47:54 -0500
Received: by mail-qc0-f169.google.com with SMTP id w7so4725857qcr.14
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 16:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KVSNkyFPo2D30re1bR+dii14CtiNlxXPWgzo7yCt9NQ=;
        b=rUt5U8FMH8ybO6L7gG2OmcDVx2/g/ljVwH3DXWhb/K4r5DJ9LH5sFVVkY/kJebNify
         rSbb3UkS/HIMU5Mwfnw4VLyEGXCfqbnDWenwHkWofYx1PwgsxOSKL/WkdqRZ2jk4YrMy
         a52y6sAVLnGn4REvYbWx4jhNjmXFJ+fk+mNXqcCwDwE3SA83VULCDjMxf6+wLj1ShS+8
         GuELSicR4xcRRGQRWQ48eq/MccIulhMemoRLCs3BE5X6XkISGaBkqMqEnpXoV0zf3Sbs
         krKZ5johY7gtrRiHfDwgPQJcFluop2lddm8NQZFKiYU0uTPaaYg0BE72/eb+O5fj7wxy
         AC2A==
X-Received: by 10.140.22.145 with SMTP id 17mr16181759qgn.0.1391734073667;
 Thu, 06 Feb 2014 16:47:53 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Feb 2014 16:47:23 -0800 (PST)
In-Reply-To: <xmqq4n4cyr61.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241758>

On Fri, Feb 7, 2014 at 2:31 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Reported by Jeff [1]. Junio spotted it right but nobody made any mov=
e
>> since then.
>
> Hrm.  Was I supposed to make any move at that point?  The discussion
> ended by me asking a question "what happens if we did X?" and there
> was no discussion.

Don't take it the wrong way. I was just summarizing the last round. It
surprised me though that this went under my radar. Perhaps a bug
tracker is not a bad idea after all (if Jeff went missing, this bug
could fall under the crack)
--=20
Duy
