From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/7] Re: Problems with Git's "perl" userdiff driver
Date: Sun, 22 May 2011 10:04:53 +0200
Message-ID: <BANLkTik0KS=JRjgKXxjuUhRx4TVv8d8cQg@mail.gmail.com>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
	<20110521185314.GA10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 10:06:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO3gI-0008LQ-Sq
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 10:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab1EVIE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 04:04:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37831 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab1EVIEz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2011 04:04:55 -0400
Received: by fxm17 with SMTP id 17so3377811fxm.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iTlpzcxznZwwX7OvzMttkqzL6bXWVZ4edlgoqlx/IEg=;
        b=v4S89HSDPaK6zvXzvbM68DxDuizUEXJmzSxMECe1RVEo82pxDHB1KooZFHuAbpL92x
         0aTR6MMU+cOqZb5RRYGZVkro4iqvdLpAwsvWlJ50iXb7Yunwtdda7d+F/tBirPzjoJhY
         3eYpCyTEGHvVtjvwLE4u3HjSoA1JNyvLfJ7aY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pJ1/TTWb2Gi2EvZpG7nMdMHMDw19AXX+UpPHhsI165OeSzsStKHKaqpeF8aYidXFvD
         e70ZZNemwFO35/Hf9senh6mOyWSbShwKWYvfRErsJKwHyO4qS102h0Ak/3WdW2xAFbge
         XqcIxc/L6vn1DHYXqx6eZVps5J2llIpGlk8pw=
Received: by 10.223.59.81 with SMTP id k17mr1207575fah.94.1306051493866; Sun,
 22 May 2011 01:04:53 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 22 May 2011 01:04:53 -0700 (PDT)
In-Reply-To: <20110521185314.GA10530@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174185>

On Sat, May 21, 2011 at 20:53, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> Jonathan Nieder (7):
> =C2=A0t4018 (diff funcname patterns): make .gitattributes state easie=
r to
> =C2=A0 =C2=A0track
> =C2=A0t4018 (diff funcname patterns): make configuration easier to tr=
ack
> =C2=A0t4018 (diff funcname patterns): minor tweaks
> =C2=A0userdiff/perl: anchor "sub" and "package" patterns on the left
> =C2=A0userdiff/perl: match full line of POD headers
> =C2=A0userdiff/perl: catch subs with brace on second line
> =C2=A0tests: make test_expect_code quieter on success

This series gets my acked-by, it's a good improvement.

I agree that we should have some sort of scoring mechanism so that the
root cause of these issues can be solved. But that's something for
another series.
