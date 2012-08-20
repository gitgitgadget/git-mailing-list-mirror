From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Sun, 19)
Date: Mon, 20 Aug 2012 09:03:32 +0200
Message-ID: <CABPQNSZ+JskSvEUFbxy78eqB5cg1npq7n_thaVhhoXxd-DK+MQ@mail.gmail.com>
References: <7v393im4jy.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Stefan Zager <szager@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 09:04:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3M27-00069q-IW
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 09:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab2HTHEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 03:04:15 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34814 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab2HTHEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 03:04:13 -0400
Received: by vcbfk26 with SMTP id fk26so4638069vcb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=s8zIBVPjQ3P6TxsLRjRpqvt4qDNBwHrEzUE7DQQ9l5o=;
        b=tSw0faN6e45N7mrhpgUjpyGlwMrI0OQqFjijE900+80noI0MFkJcdplHNpibAqnVp8
         k8sRVmQWNSniHUFENa7whu2QLxVWwP84ZBIsvmtFAgPs5EXb3qxrmo1+xC1WAGxYeaAI
         AGibBSjRd9egYg9VgXMvzUm+qcoTRLc3iAC/3bMCt1HWc62d9OMsk/wqOVmOHnhaBevc
         Z3mZplwx6uucci1YFzLYxRUK1c+v3C0T8onvKgP6P+02RcgPiNB2oxPGokgRhBltJmqe
         Yma1PwApDdDMAUDoZBaUxDAKeGFm6l9ldHX5iI0SUOVPixZrifdBqU0DFIoSKhOS+7Nc
         e6PQ==
Received: by 10.52.35.99 with SMTP id g3mr7891415vdj.21.1345446252791; Mon, 20
 Aug 2012 00:04:12 -0700 (PDT)
Received: by 10.58.237.166 with HTTP; Mon, 20 Aug 2012 00:03:32 -0700 (PDT)
In-Reply-To: <7v393im4jy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203764>

On Mon, Aug 20, 2012 at 9:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * ef/win32-cred-helper (2012-08-16) 1 commit
>  - contrib: add win32 credential-helper
>
> Credential helper for Win32 (is this GUI???).

No, and credential helpers shouldn't be either.
