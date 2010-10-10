From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Sun, 10 Oct 2010 11:03:36 +0000
Message-ID: <AANLkTik9qCY9mBS3BXXEvFK6uWMNqYyQ4QWxrOY2PbJ-@mail.gmail.com>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
	<AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
	<AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com>
	<AANLkTi=QJ8bbyNHwFibY+W9dMyiYa5s_ne0zG8Ltt0um@mail.gmail.com>
	<AANLkTimz4vHXN-YngO6rUjaTc+-sdNm20GAG4ta9Z2TC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Akira Kitada <akitada@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 13:03:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4tgs-0005jO-Nt
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 13:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab0JJLDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 07:03:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64897 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab0JJLDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 07:03:36 -0400
Received: by iwn6 with SMTP id 6so2151840iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=MKGeGvqKV9ebdJeTQU37xauGoUq/7H72Kl5WNJEiADY=;
        b=REeByEf/7Q5mJdKgwCYQ2I//gA/kk8iYImyKTm69F25RNARSpysiEt+72X0bw12Q0W
         Xi+8Dw509VQG7WyeHtzA6wb/hGc8pHBEsyq+45btvqTrUhPRQ0lGkJpNSV0uHKW1pk6U
         /RUMFTsACjKiHPSbM1m+rv3lLH3N1Cgo6lPOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BSz527YIiAOR8sGAcG2KPpT8WH0PiaXxDU1KGsSCNC3pdB5CwEL+hPh5HfuWudwVV9
         ZPT1DPQ8zIpGGMABQQoGc26+GPm0Weona3tmGbfgcbhh+OsKIM0g+DwAwDbK5nRVb9G+
         SGfxJs8tt5ZEmGwXGC7vhhcCUgMESmT1p6tFg=
Received: by 10.231.145.1 with SMTP id b1mr3776337ibv.69.1286708616223; Sun,
 10 Oct 2010 04:03:36 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 10 Oct 2010 04:03:36 -0700 (PDT)
In-Reply-To: <AANLkTimz4vHXN-YngO6rUjaTc+-sdNm20GAG4ta9Z2TC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158655>

On Sun, Oct 10, 2010 at 06:03, Akira Kitada <akitada@gmail.com> wrote:
> I upgraded ExtUtils::MakeMaker to 6.56 and ran make again but it
> didn't fix the issue.

Try building with NO_PERL_MAKEMAKER=1
