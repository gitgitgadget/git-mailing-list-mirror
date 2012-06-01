From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT PULL] ext4 updates for 3.5
Date: Fri, 1 Jun 2012 12:02:31 -0700
Message-ID: <CA+55aFwJnKXAMjLaS3MXLcpqJKKdhufFRTKzdM1_aH5ebqx+BQ@mail.gmail.com>
References: <E1SaTSI-0005UV-4B@tytso-glaptop.cam.corp.google.com>
 <CA+55aFwk8oYx8EKWdT=5cMTLK7RDz8GQdGmHk2KXwcCq+Bb8PA@mail.gmail.com>
 <CA+55aFwwfMTN=WGQGmFO7DYeBUOGA7V4_6XueQS4JAzeykwn3Q@mail.gmail.com>
 <20120601174336.GA15778@thunk.org> <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com>
 <7v8vg63lri.fsf@alter.siamese.dyndns.org> <7v4nqu3lhy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ted Ts'o" <tytso@mit.edu>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:03:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaX7h-0001vD-QM
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 21:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965736Ab2FATCx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 15:02:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58652 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965696Ab2FATCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 15:02:53 -0400
Received: by wgbdr13 with SMTP id dr13so2211349wgb.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sxrcoVq0QwSlt88L9s+zwh5M4l9HV8xtXCHPkJ4ttog=;
        b=DBzr3QxOELdz8R5uhOHWaaGFBrqMCRAYFf9Oqk+w+P6L8SeoDJaTZhhJwLq1urgg92
         mfKc3bFoWVO05jTaG6cZyMV7J3tMB8n2IMiPmnAlK5ku4ZEm396k59TP2J6DBOE+odx3
         Pmt7IbJCw5aqGb5HR47NHJkVaFUtAgEHpkXQC+IIxmyh5JP4n2a8EZxQp3To4HNclhP0
         1qqYz77fPf85/nzn+dz5geAxtbY5IKwRONrTBVNsvjJjR+AdBW8hSbuJOrYMsxyLWJX1
         FSS8MtaMjFF1ALKHvy8a6KeFcuVa39xiRycGcwZUfJuqtwytB5VdWeTlttGAmtYvlqYu
         A7PQ==
Received: by 10.216.225.196 with SMTP id z46mr2855680wep.17.1338577371465;
 Fri, 01 Jun 2012 12:02:51 -0700 (PDT)
Received: by 10.216.225.99 with HTTP; Fri, 1 Jun 2012 12:02:31 -0700 (PDT)
In-Reply-To: <7v4nqu3lhy.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: V0Ovi9CeE6FhkDQQuIMi0RC0_Xs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199013>

On Fri, Jun 1, 2012 at 12:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> It may also be a good idea to add something like:
>
> =A0 =A0 =A0 =A0if test -n "$tag_name" && test "tags/$tag_name" !=3D "=
$ref"
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "warning: have you really pushed =
the tag yet???"
> =A0 =A0 =A0 =A0fi
>
> somewhere near we show "cat-file tag $tag_name" information in the
> output.

Ack.

          Linus
