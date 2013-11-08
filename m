From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 8 Nov 2013 20:14:47 +0800
Message-ID: <CALkWK0=w1G2O_W1LnfstqzaMjOQ0GWqJXeeRN4ymfsvohQBfyA@mail.gmail.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
 <1383212774-5232-2-git-send-email-artagnon@gmail.com> <xmqq38nh411p.fsf@gitster.dls.corp.google.com>
 <CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
 <xmqqli182mde.fsf@gitster.dls.corp.google.com> <CALkWK0k-8noAJbgzPx3NEx-ucUdZoS4VmqNCKjm3R_5eqFnR7w@mail.gmail.com>
 <xmqqzjpkyqtf.fsf@gitster.dls.corp.google.com> <CALkWK0k0wxoK-MZk-KXiUiUgxVBKQGROFJBZbRs2LjNLA9iopA@mail.gmail.com>
 <xmqqvc045bvq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 13:15:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VekyQ-0005v6-D3
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 13:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418Ab3KHMPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 07:15:31 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:62496 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab3KHMPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 07:15:30 -0500
Received: by mail-ie0-f179.google.com with SMTP id aq17so3047646iec.38
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 04:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LQElyN8a03Aqj2gU0QBcCXx354WQoUMs2VdXB/Db13s=;
        b=xv0xPE2uYkjJgj+9gQXYE6tZPWAzER1ywACcBY1yqI5pibCrUnT4S4gBNwzWjMfGfe
         522encSoUzkRJsgJBkYmWW4naElsq2i4Sx/pHxy6uyCkOz1kcXNixS9Bczpka9wNpMSU
         vfCsscE7zz3VkttO/nkvFTkmwxo5m7vNNUD0byiRGFwrpnroUn7qzYyF7m3Tx3jY0GPf
         ZcSVx62eIzqM1TQg9jzNBDoBYyhQATMVpwvMoNzwdSjOf6sbxTU54CTyDptK/0YCEIma
         55fNfxkypDERa9i7VsIFR6fGdu52OhDDqmpROTlHc/3KidLKpNwdUJQEMEDfFRx59emR
         auqA==
X-Received: by 10.50.23.16 with SMTP id i16mr2057306igf.50.1383912927556; Fri,
 08 Nov 2013 04:15:27 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Fri, 8 Nov 2013 04:14:47 -0800 (PST)
In-Reply-To: <xmqqvc045bvq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237453>

Junio C Hamano wrote:
> If %(authordate) is "I want to see the author date here", and
> %(authordate:short) is "I want to see the author date here in the
> short form", you would expect "I want colored output in green" to be
> spelled as %(color:green), or something, perhaps?

Last time, we almost managed a unification: tokens like %authordate in
f-e-r correspond to tokens like %ae in pretty-formats; %C(...) is
different in that it doesn't actually output anything, but changes the
color of tokens following it. While I'm not opposed to %(color:...), I
would prefer a color syntax that is different from other-token syntax,
like in pretty-formats.
