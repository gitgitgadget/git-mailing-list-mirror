From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] t4033-diff-patience: factor out tests
Date: Wed, 6 Jul 2011 23:01:38 +0800
Message-ID: <CALUzUxoOS69xR07eoYYjum5XBqAVuFgh9LkzKCV2X5J5_m3gZA@mail.gmail.com>
References: <1309932945-5048-1-git-send-email-rctay89@gmail.com>
	<1309932945-5048-2-git-send-email-rctay89@gmail.com>
	<1309932945-5048-3-git-send-email-rctay89@gmail.com>
	<1309932945-5048-4-git-send-email-rctay89@gmail.com>
	<CALkWK0=qO4NOfK0x044Hd+dM5pY8-EMrBrk_Tkia=fpYDzkyig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 17:01:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeTbl-00054C-3n
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 17:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab1GFPBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 11:01:40 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60885 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab1GFPBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 11:01:40 -0400
Received: by ewy4 with SMTP id 4so2391298ewy.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oMm8z+d1gl53Jbh3Sniv0V3W4n4y/1s/lGm1ZNW8mXM=;
        b=wccukWQxMCxKhzpau5yV24CCAvBqH6eUi0u5PerVGgpt4dKPPW53P0Cj4leKYCSRHG
         r8Uq9L4QAsIbnn/GOCvUb6KCPmxt6o6OzoBTRZ+/2Qdt4MK3BXaVuWnCw2/SKOZQRdbb
         eaiAC8J9GGrjheYXXBS4uEGxTShABKhVJPySE=
Received: by 10.14.16.14 with SMTP id g14mr2610782eeg.133.1309964498683; Wed,
 06 Jul 2011 08:01:38 -0700 (PDT)
Received: by 10.14.37.138 with HTTP; Wed, 6 Jul 2011 08:01:38 -0700 (PDT)
In-Reply-To: <CALkWK0=qO4NOfK0x044Hd+dM5pY8-EMrBrk_Tkia=fpYDzkyig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176708>

On Wed, Jul 6, 2011 at 3:29 PM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> Submitting RFC patches without commit messages is alright I think, bu=
t
> a missing signoff won't even permit anyone else to pick up this up an=
d
> work on it. =A0Please sign-off on everything.

Oops.

>> =A0t/lib-diff-patience.sh =A0 | =A0162 +++++++++++++++++++++++++++++=
+++++++++++++++++
>> =A0t/t4033-diff-patience.sh | =A0162 +------------------------------=
---------------
>> =A02 files changed, 165 insertions(+), 159 deletions(-)
>> =A0create mode 100644 t/lib-diff-patience.sh
>
> Maybe separate this out into two patches: one that renames the file,
> and another that makes the minor changes so that it's easy to review?

Good idea.

--=20
Cheers,
Ray Chuan
