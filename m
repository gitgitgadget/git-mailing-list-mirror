From: Roland Kaufmann <rlndkfmn+git@gmail.com>
Subject: Re: [PATCH v4] Display change history as a diff between two dirs
Date: Mon, 27 Feb 2012 12:31:39 +0100
Message-ID: <CANEMaQTfHMeoomeQ=7vqyj9SAwcmxJczqYE19+c49R6FyNGh0w@mail.gmail.com>
References: <4F495703.10401@gmail.com> <7vlinpcewj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 12:32:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1yoO-0001SK-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 12:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab2B0LcC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 06:32:02 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42267 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753769Ab2B0LcA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 06:32:00 -0500
Received: by lahj13 with SMTP id j13so737540lah.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 03:31:59 -0800 (PST)
Received-SPF: pass (google.com: domain of roland.kaufmann@gmail.com designates 10.112.43.66 as permitted sender) client-ip=10.112.43.66;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of roland.kaufmann@gmail.com designates 10.112.43.66 as permitted sender) smtp.mail=roland.kaufmann@gmail.com; dkim=pass header.i=roland.kaufmann@gmail.com
Received: from mr.google.com ([10.112.43.66])
        by 10.112.43.66 with SMTP id u2mr4299634lbl.58.1330342319490 (num_hops = 1);
        Mon, 27 Feb 2012 03:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2k+rsQcqaQVkc1vvVbNlgU3J0avRbSq17PL84Xmpw1k=;
        b=DxUl8yE40IVPkc5oXF9HtYLt3UcmURNdbE3Ps8B9HObBtDpDGfDjmdpl2DK2lPRDnS
         S05mjXHku1l3p6OSNz1WUqEAPMsXPQRB5WU8jPFZ+KXRHhIeX2pbFYO77zrDdGMtrFdY
         hroYP0oAYUX5v2OnofI04CYTrTe6yCyX+2Pqc=
Received: by 10.112.43.66 with SMTP id u2mr3623846lbl.58.1330342319418; Mon,
 27 Feb 2012 03:31:59 -0800 (PST)
Received: by 10.112.19.133 with HTTP; Mon, 27 Feb 2012 03:31:39 -0800 (PST)
In-Reply-To: <7vlinpcewj.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: a6gfHzeoIosFg9d71m7414l44DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191621>

On Mon, Feb 27, 2012 at 01:13, Junio C Hamano <gitster@pobox.com> wrote=
:
> How does this compare with Tim Henigan's "diffall"? =A0I think the pr=
oblem
> these two topics try to address is the same, and their approach may b=
e
> similar enough that having one consolidated effort might be worth it.

Yes, I certainly agree. From a quick glance it seems to do exactly the
same thing (and both take inspirations from scripts already floating
around on the net); I guess that is a sign that it is an idea whose tim=
e
has come! :-)

The major difference is that Tim's version generate the list of files
and then extract them, whereas my current version piggybacks on
the external diff interface (as you suggested in one of the previous
reviews). Which of these approaches -- if any -- has the most merit
I think depends on the plans for that interface.

But until that's decided upon, it would have been nice if a version
could hang out in contrib/ to gather some experience.

--=20
   Roland.
