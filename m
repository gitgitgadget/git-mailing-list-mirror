From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 4/5] rebase: use update_ref
Date: Tue, 28 Jul 2015 14:53:46 -0400
Organization: Twitter
Message-ID: <1438109626.18134.13.camel@twopensource.com>
References: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
	 <1438027720-23074-5-git-send-email-dturner@twopensource.com>
	 <xmqq4mkof8nq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:53:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKA0f-000064-5q
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbbG1Sxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:53:49 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32792 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbbG1Sxs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:53:48 -0400
Received: by qkdg63 with SMTP id g63so1138908qkd.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=jlHbyumDQ0kMf3d3JAwEurS2PztT0i0P8oc78sFCSCE=;
        b=ESHHuy8xMa1lvRQBgs8LPXQUMmXFZ4xzLJSs45UhNkuMeJpFkkgGbQbCm9SzBNfxVQ
         pNWAHuJKK9TpVcfFqc31DTIyd196haECocJs3gwOXldBYoMjP1RhdzoFVW7q7r/Si53q
         CF/4gpjWpB9nFbmPfI+Yai8WyM2vJ4dAxbN3eRpvPGRzj1d9DB3hTM81/est4IFzZC1N
         lrDhF1AsM9DRISrggKyaiRSGdWo8/PtApjpq5DNSriezctygPRhNKUg3mH9MVgShJyrg
         hSk2zw1ieNuzA1mDoSoome6oq4p9ZyiHYQ0aMECdJFr7zTSUo2Rv9UXequwfPxsqUZSE
         aQ4w==
X-Gm-Message-State: ALoCoQnOWuFhV4zgFcdH8UTqvTkH5K6CydZG19c8n+j0yIAoZDuSC3wBPIpqOLd1N96VIGDWgycl
X-Received: by 10.55.15.86 with SMTP id z83mr51594946qkg.70.1438109627841;
        Tue, 28 Jul 2015 11:53:47 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id d8sm11748111qka.21.2015.07.28.11.53.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 11:53:46 -0700 (PDT)
In-Reply-To: <xmqq4mkof8nq.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274813>

On Tue, 2015-07-28 at 11:18 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Instead of manually writing a pseudoref (in one case) and shelling out
> > to git update-ref (in another), use the update_ref function.  This
> > is much simpler.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  bisect.c | 37 ++++++++-----------------------------
> >  1 file changed, 8 insertions(+), 29 deletions(-)
> 
> Mistitled?  I can do s/rebase/bisect/ at my end if that is all
> needed.

Apparently, yes.  Thanks.
