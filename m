From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 1/7] add simple tests of consistency across rebase types
Date: Mon, 3 Jun 2013 10:16:52 -0700
Message-ID: <CANiSa6hH3APigj_vozsbBQriNhqnPT=2Qcb0T76qs9hPhbhacg@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-2-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYNO-0007DE-Ky
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500Ab3FCRQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:16:55 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:54177 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758763Ab3FCRQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:16:53 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so2938306wgh.5
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vYlRn48K9944PZpboBuW9DcHFfhEihK9v6c1wfmPrt0=;
        b=xstH1ZLSXHkvHqd7om4KgiTAKLmCd49mWDNgiWY2N/RQXNAHZruF/4lxLJNJDfPimH
         TzakDfTZTifKgf/QBL9ccIsO3jGdqZ42epXpmlcUO+REfW0xrejDxs0eim1dHXwNbu3H
         DWQnnMhSOkqdlTajZS/BcJqXDSHpdLG0ft4AlhVBzdcTJCoSuAh38RLQW2wqQEFwgvx+
         /E0Bkg9yMv7+DbAUBTlRgPAE2zaCesp3SrmPkZxppa9B4cFfCTLqS+kxQmMu0GTE8hQx
         /Qf/XkjzJHbFNWs4qqdK27Og4DI9ZTiKxQHYz7vSqeA/JJNfcOmATha7FS81Rzcgydtt
         Id0g==
X-Received: by 10.180.205.177 with SMTP id lh17mr13976562wic.45.1370279812433;
 Mon, 03 Jun 2013 10:16:52 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Mon, 3 Jun 2013 10:16:52 -0700 (PDT)
In-Reply-To: <1369809572-24431-2-git-send-email-martinvonz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226238>

On Tue, May 28, 2013 at 11:39 PM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>  create mode 100755 t/t3420-rebase-topology-linear.sh

Just FYI, there's another test case with the same number
(t3420-rebase-autostash) in pu. I don't know how you normally handle
such cases.
