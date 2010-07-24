From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] worktree setup: return to original cwd if prefix is 
	set NULL
Date: Sat, 24 Jul 2010 01:16:00 +0000
Message-ID: <AANLkTilTmddAdEtLWvZy1wmB-kRPUL3E54lyKKWwfDqG@mail.gmail.com>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
	<AANLkTimkwfetLWynKCGVxMT0ZzHOZQp_iknrohoV8A79@mail.gmail.com>
	<AANLkTin6xGRz7wFyWtYg4ysPPytEW-uQn8ij1YbjJ_m9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 03:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTLU-0001js-A3
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab0GXBQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 21:16:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43522 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0GXBQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 21:16:00 -0400
Received: by iwn7 with SMTP id 7so748181iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=2mHYWb9m2AlFTS3aBzAVfXs72awupwb5RQKwA2B9YRA=;
        b=KYaoHv15V8LkQ2GfEo01xrdi+SJfLHO6JMDoQKGqnYF7Yb85y/uEdrLPiEfnl7si+U
         WHNtxc0seK5dKztpGprqKhFvGkiE9OVNQEvTuF0m3HPcGcPUTYwvZ/JqYVshOmiFjtBv
         MatsPLRFf6J/GnwDTmKL5o2ViPunEvZ1Dldpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YB18Q69Okz24IDudOYTGn1YXfQIzFnN67YYifH/pCYcXozYfts/eRrijkHTuHQUyMY
         4jDd+wuND5ePVuynn80ZWdYqpEyyD21BG7Z9N1w3hbRqPgdzvZjrXy+qfZpJEmfH4Xkb
         XQRjtvQIvuxER2lBwL1Ln5VCKxecJ3dB79xrw=
Received: by 10.231.32.70 with SMTP id b6mr4457038ibd.99.1279934160147; Fri, 
	23 Jul 2010 18:16:00 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 23 Jul 2010 18:16:00 -0700 (PDT)
In-Reply-To: <AANLkTin6xGRz7wFyWtYg4ysPPytEW-uQn8ij1YbjJ_m9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151593>

On Sat, Jul 24, 2010 at 00:50, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> I don't want to pollute the repo early. If the test fails, rm would not be run.

Sure, I'm just asking if there's a reason to run rm in this
case. Because usually we defer the whole rm to be done inside
test-lib.sh once the entire test completes.
