From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] send-email: use the three-arg form of open in recipients_cmd
Date: Tue, 2 Apr 2013 13:16:19 +0530
Message-ID: <CALkWK0=AmKC+U8tbjsc-6zd3R2fWq=YSfiQn8y7ukzdDAZqzcA@mail.gmail.com>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org> <1364780442-6015-1-git-send-email-gitster@pobox.com>
 <1364780442-6015-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:47:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvwI-0003VK-BH
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760531Ab3DBHrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:47:00 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:48679 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760503Ab3DBHrA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:47:00 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so123710ieb.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TOmJrQDmb3sjj6zhVIeEStNXmWsy6BSJ6IWgM9LHrro=;
        b=skV6zrJmglI9Gs66T8BJyP/On2bp62drs1dE9tUrKoaX8teCbdLSzdbJSewZ95FkDz
         jIkygQx9mjmhhtts6wR9ozS8EfuLzI2VGDBlF3E5iYP0G0qOj+tjKNZbcVXPmUlEoQuf
         n5C2FmpTpNgwld2xVCKTx7whYUVFBEbeTCHeJQaeq5eQEdERDEtGtrSCTExYl9t9LqOJ
         NGN+2ZDBgIXEbI70nFWkEQpcBMiKkipZ6riLpA8OwmepZigC+62wmP0LUEguHbbQOvAh
         Abwkw4hSKB+K/exU52wQ00XsUons1F+67DFph1pXsLheoi+uHFIC7JFIUziw5D3ZXlzz
         aCQw==
X-Received: by 10.50.108.235 with SMTP id hn11mr4611552igb.107.1364888819892;
 Tue, 02 Apr 2013 00:46:59 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 00:46:19 -0700 (PDT)
In-Reply-To: <1364780442-6015-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219751>

Junio C Hamano wrote:
> we can silence Perlcritique, even though we do not gain much safety
> by doing so.

Nit: it's perlcritic; critique is used to refer to the output of a critic.
