From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: improve 'git --exec-path' completion
Date: Sat, 14 Apr 2012 02:43:00 +0300
Message-ID: <CAMP44s1C8HS2bo-dZOQKcFES8gt3=KK0h7c8uUJCeFX22ihLRg@mail.gmail.com>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
	<1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
	<20120413060845.GA15610@burratino>
	<20120413180436.GA2387@burratino>
	<20120413183048.GB2387@burratino>
	<CAMP44s0R7imiem4uoBggkjjJ4z5+MXVYUroe_23JE8McMCk2sQ@mail.gmail.com>
	<20120413233706.GD13995@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:43:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIq98-00048z-Sp
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 01:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab2DMXnD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 19:43:03 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43066 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125Ab2DMXnC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 19:43:02 -0400
Received: by eekc41 with SMTP id c41so902641eek.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=C6FhUvFOVl5tNnFtudT/T6DsgChcTNTGM4JXiSzxnOw=;
        b=rtp2zonAWDgVFm0wcmJ3oRCsgIARZinzf2QWpaA2o+1Klxva6kX7OmpOHXFReiFrgQ
         reibJa1NRvBwXqyOI9hQB3qJSi7NI/YIoP64o/izQbv4VyZ+mBYKvuMXijJD4X5vVNQ9
         dvKfxBbhBO/OAt9a2IJpOkPofhhU4Rp5UfZBf7fA6SbbSswgruUO76FCnCDowdJKDKPi
         lA7W6F1yPB5X1g3nbRUVE9e0Jqd4XMP4CxMk/ok+EY8YpLRCceOxhY6FKS1/vb5FC5jg
         Ijow8Tx/QSoFR2bKO0uNju52qzptIfx0ZbCBgl7Fos0CTYl01wNyzk5GSLR70yAE+CJF
         uorA==
Received: by 10.213.32.2 with SMTP id a2mr269467ebd.39.1334360580271; Fri, 13
 Apr 2012 16:43:00 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Fri, 13 Apr 2012 16:43:00 -0700 (PDT)
In-Reply-To: <20120413233706.GD13995@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195458>

On Sat, Apr 14, 2012 at 2:37 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> I don't understand, the commit message doesn't match what the patch
>> actually does.
>
> Try it, I guess? =C2=A0At least for me,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git --exec-p<TAB>
>
> completes to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git --exec-path <cursor here>
>
> before the patch, and to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git --exec-path<cursor here>
>
> after the patch. =C2=A0Which is different from your original patch.

Ah, it doesn't remove the current line, it just adds a new one. I'm
not sure how the completion results show up, but I guess it's better
than the alternatives.

--=20
=46elipe Contreras
