From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v2 1/4] git-p4: Allow setting rename/copy detection threshold.
Date: Fri, 19 Aug 2011 14:51:06 +0100
Message-ID: <CAOpHH-WJWxeTSO5Dy6UR9pJh3w9hQSBuE7O1mY2KDAEsS9OAPw@mail.gmail.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
 <1313706054-11740-2-git-send-email-vitor.hda@gmail.com> <7vy5yq5nkb.fsf@alter.siamese.dyndns.org>
 <CAOpHH-VsoOSOH6ym2exCH=W4NmuKRw+f53HrwB47YD3u-iDe2w@mail.gmail.com> <20110819114719.GB15639@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 15:51:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuPUA-0001RP-4P
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 15:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab1HSNvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 09:51:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44069 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab1HSNvh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 09:51:37 -0400
Received: by ywf7 with SMTP id 7so2190789ywf.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=A0RjCrJPguhnK2OAKPiR0FvRw7sIEHNUDrtfR5ysLMs=;
        b=wCerSlZbgDGIIIIbyLCYiHYU+p4o+3v2Q4j07Ps64tsSzWLOW95M0YZ1v/w/C4KAK5
         LGueRMNVxPU+ht0vvElBfSLYrQ72FOXvo96S/L4bPFC2xlNfrreeM5OttYGYlgoqvJEU
         5HnI21xRNgir73oXV5lxrJoA919jD/nbQ3UG8=
Received: by 10.236.136.196 with SMTP id w44mr7649775yhi.56.1313761896384;
 Fri, 19 Aug 2011 06:51:36 -0700 (PDT)
Received: by 10.231.19.8 with HTTP; Fri, 19 Aug 2011 06:51:06 -0700 (PDT)
In-Reply-To: <20110819114719.GB15639@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179701>

On Fri, Aug 19, 2011 at 12:47 PM, Pete Wyckoff <pw@padd.com> wrote:
> I think you have to decide that 1 means 1 in this case.
> Everything else can mean true. =A0That may suggest that using
> --bool or --bool-or-int isn't possible in this case.

But doing that kind of post-processing would require me to call
git-config (at least) twice: first to check if it is a number with a
possible "." in the middle or "%" at the end and a second time with
the --bool option. I have no problem in doing this, but I think it
increases the complexity without bringing major advantages.

I will use --bool for detectCopiesHarder and will send you the new set
of patches tonight, unless we decide to also start using it for
detectCopies and detectRenames.

--=20
Vitor Antunes
