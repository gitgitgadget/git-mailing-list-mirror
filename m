From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] test: spell 'ls-files --delete' option correctly in test descriptions
Date: Sun, 30 Jun 2013 16:48:41 +0530
Message-ID: <CALkWK0nVAD6wEvifeV95CLiL94siPq5J9UQ_SWdvxZVVyubM8g@mail.gmail.com>
References: <1372589125-8529-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 30 13:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFfC-0005p6-Gk
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab3F3LTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 07:19:23 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:59136 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3F3LTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jun 2013 07:19:22 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so7506214ieb.30
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eotWJ/56R/gsLlTBOZwZFdAgLq0rQKAmAthhFT9mE3c=;
        b=CjaNyYnq36qwVrnc0+7F7YBZ1mBTx6pyNL4NalMYqNGckr1dwET5s1b6kZuOBtJdfI
         ZEaRuOiB5lIsF1FIW8gNqObdIBnmJ+hBlcwOuL3fd9BhrdpmCQyEdsRiE+1KYKNJ+w+a
         kzo6Y4yz7dMPKwG4uHTtdCAJFIXHnzR8PqvGibvPSGcGUCs7FkAfBytIS1TQLFXykrWO
         0n9Ql1RLit8/lGeDGPsOEZW6BdjBxvf1i1zwUapR03qNmWZplwvGWl+WTs9FtFTERUVb
         c8SIclDQeHwy26c00l+yKz6/HmJyBcGwzrBoyeqVShDt7rh6uk41QiCoG/aFmy7w9m6K
         hCeg==
X-Received: by 10.50.225.66 with SMTP id ri2mr10864055igc.55.1372591162028;
 Sun, 30 Jun 2013 04:19:22 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sun, 30 Jun 2013 04:18:41 -0700 (PDT)
In-Reply-To: <1372589125-8529-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229273>

SZEDER G=C3=A1bor wrote:
> -test_expect_success 'ls-files --delete' '
> +test_expect_success 'ls-files --deleted' '
>         setup_absent &&
>         test -z "$(git ls-files -d)"

While at it, change this to --deleted?
