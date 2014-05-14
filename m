From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Wed, 14 May 2014 18:48:34 -0500
Message-ID: <537400d26f709_d0fa1b30088@nysa.notmuch>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
 <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
 <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
 <536d4e7ba8ea_585ea5308a9@nysa.notmuch>
 <CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
 <xmqqsiodo7o6.fsf@gitster.dls.corp.google.com>
 <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
 <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
 <5373c56c5c531_56d6e3b30449@nysa.notmuch>
 <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
 <5373fc12bc5e4_7411589304eb@nysa.notmuch>
 <CACPiFC+mrCufS1hakS8w5-PHuoqC+ktMmX+mRGNLAZpaQqjA_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 01:59:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkj5E-0001V6-LR
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 01:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbaENX7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 19:59:33 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:51318 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaENX7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 19:59:32 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so354923obc.18
        for <git@vger.kernel.org>; Wed, 14 May 2014 16:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=pwaNOus9OeGRGh0/4y0aj8U7wqRBOOZgLLBdVudMHZo=;
        b=EW2m30skcSrsA2SP79QZyhqit9/HjXyHbaXpCe1UyJ6QugFIFImFiWQp7IVG7GXxwf
         l/JmL6fq0E1Ntht+AIwVrxiO0TX/eSftvJThaTURl+Yz1UogkJq2GNHXyl9W6ABMNjKC
         htQd31ks7vzOtwNT/ENxDB7MVSo23ksdMhE8c1htUlLZMra1mAnzQu+p8tNuwbMeXAbF
         kXzgFvyNsz3jrfGWaPhKl0hCeUbkBcl9Jh9hF1lKHaqOEu3twu4Aeon2LjEgXzkQB54Z
         FM9eJTNT4NoD1bFIO/YJhRH80vBqFEm9NTPbglXeb1rC7nDwWII592Y+Lw7IjlOkMSUr
         ZZzg==
X-Received: by 10.182.163.45 with SMTP id yf13mr6694312obb.66.1400111971758;
        Wed, 14 May 2014 16:59:31 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qp6sm5954447obb.14.2014.05.14.16.59.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 16:59:31 -0700 (PDT)
In-Reply-To: <CACPiFC+mrCufS1hakS8w5-PHuoqC+ktMmX+mRGNLAZpaQqjA_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249051>

Martin Langhoff wrote:
> On Wed, May 14, 2014 at 7:28 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Do we no longer have to be afraid of that? WHY? All the responses from
> > the contrib cleanup patches seem to suggest that pretty much *everyone*
> 
> The responses also been clear in that you are toxic.

You are replying to a mail about a *TECHNICAL* reason. Junio made a good
job of concentrating on the technical side.

If you are not willing or unable to concentrate on the technical side,
reply to something else, you are just tainting the discussion.

If you are willing to concede that Junio made a wrong technical
decision, I'd be willing to discuss about the social issues that
happened *after* that with you. But I doubt you are interested in doing
either one of those, so I don't don't see what's the point of you even
replying.

-- 
Felipe Contreras
