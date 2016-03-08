From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 15/15] branch: implement '--format' option
Date: Mon, 7 Mar 2016 17:58:13 -0800
Message-ID: <CA+P7+xouB+C+pKMGhJavB+e0jadFUGEDcgcmWWot1AYTxKMY1Q@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com> <1457265902-7949-16-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 02:58:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad6uz-0002vo-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 02:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbcCHB6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 20:58:35 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33097 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbcCHB6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 20:58:33 -0500
Received: by mail-io0-f196.google.com with SMTP id g203so814513iof.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 17:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hRPYKnw/oUgyeVV2ZJfZ5Q6hvv1dlHc5GhvAOCiEdZg=;
        b=Y07Vif8cJUgPRHbTx0nBN+2DZvKa2dARvkGH4YhNJVZmutwhYXKHbjMoy2MY40R7aj
         kGF4Jz/WYQJmoyLZAfnj10Lfdxa/zm02ABWHqWw5/+5Xe4J2kpk4kLAjiNpLA/egLu8z
         ZXvYukuo+RXmQTk0awx4jGPH/8d/APBZB3qxebM83+hRYOjzUToDLkxQg+IVRwOfYwFt
         JD7H0pVBQvKtb+dNqXlQVCnZwDL8fGJnTfFYqBqFlRFlaYZAT64iAaH1ip6B4Be9G3WD
         6hdNeC3zZ8vEODnzV16tfkvwM71P8VBdQjGPPJmttj2TPpw9dg+8GJKfpq4YxNrpd/Dn
         IfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hRPYKnw/oUgyeVV2ZJfZ5Q6hvv1dlHc5GhvAOCiEdZg=;
        b=P48RcklT/HrtEtt06oXurCP6FIqk5m8sbkA96SY3nH7wFmVYc0aUwSKVItimA8HbLO
         Ue3ZQ7BELAV+5yAFxSeyFvx9qOXNo1wvacOGwbhvwZW8tilpYhJUFbuGWqMS0uMQTMct
         v/CpaLPnNTEeCyRZ46wy94EH2V0OX+8H4BUATiCovf02Jpu8Gg9drOEmxh/Co+l341Wh
         2i4cad7pYwfa06VAA6FTMfULE/mVHfMjUaeQb34tbTvBOBMRLcf5I+BoN4amxhUATby9
         /HwmLYy96+4c4hivoIImixjRjqG1pEoQefoRbIYFDLjQPkB7Iq3AR8Lm2wVABj3xY76f
         t8Ow==
X-Gm-Message-State: AD7BkJLsf/ZBqrq7OnRlkOOrXhaZTFFgeVtM2siT1BypPFWUJfJ/xZQMU0bIbSSwO5BrI7CO+wUyZfBQM24Y1Q==
X-Received: by 10.107.156.208 with SMTP id f199mr28909549ioe.0.1457402312865;
 Mon, 07 Mar 2016 17:58:32 -0800 (PST)
Received: by 10.107.10.202 with HTTP; Mon, 7 Mar 2016 17:58:13 -0800 (PST)
In-Reply-To: <1457265902-7949-16-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288413>

On Sun, Mar 6, 2016 at 4:05 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement the '--format' option provided by 'ref-filter'.
> This lets the user list tags as per desired format similar
> to the implementation in 'git for-each-ref'.
>

s/tags/branches/ maybe?

Thanks,
Jake
