From: Joel Jacobson <joel@trustly.com>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Tue, 23 Apr 2013 18:58:46 +0100
Message-ID: <CAASwCXdhgNPzm51MfWTCTNYQwT0gC-UbV7xTNGcXhs6k9f4wsQ@mail.gmail.com>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com>
	<7vip3em8rs.fsf@alter.siamese.dyndns.org>
	<CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com>
	<51767290.2010208@drmicha.warpmail.net>
	<7va9opi163.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:58:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUhUS-0004EW-SS
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab3DWR6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:58:48 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47645 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714Ab3DWR6r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:58:47 -0400
Received: by mail-vc0-f174.google.com with SMTP id kw10so931678vcb.33
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 10:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=CfQCWv0ktkfuTY4IVD2aowDjQsOmsfc266Wdp0Z/Q3k=;
        b=PKNzpkQ3NKEcx2vMhupa+jUVZjy9FbEGRecM0hHX4ckL29iPG+nJSEQL3rInWCrkgU
         pM+eGgknT1LtKIX7xk+tDqBnlmrt6kLBYQ1w/uHzn9r0IljS/npyX4LYAWKupMGRG3me
         Pqc2inm1RXlvOHdC0XmjdYLcxPOyot7PmUU7g9UkDEfvvS8XFqouXsWW8uBRGoj2CdGq
         WNDvOpVVrWrZKP7c9UGBPwX8abcJNDbTxTZjNgsu/b7rHkf741NaaoAm3YJQLBiTavSJ
         csTKLB9BknA20M/O9GiXDJUsjuVPwHnA60TzFvd5k+/dusTxWfnze2U1avkGpcacUzNQ
         dGrg==
X-Received: by 10.59.0.226 with SMTP id bb2mr899851ved.1.1366739926764; Tue,
 23 Apr 2013 10:58:46 -0700 (PDT)
Received: by 10.59.11.169 with HTTP; Tue, 23 Apr 2013 10:58:46 -0700 (PDT)
In-Reply-To: <7va9opi163.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkwMCG6GcGnwM1Zmmz2YUj1unb53EPehFWUh4IjTcSnXJA/FQh8/0Xp5iWlX8VxEcOjLRVp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222204>

On Tue, Apr 23, 2013 at 6:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I would consider such use of "git -c key=val" a last-resort escape
> hatch to work around broken commands that do not implement a proper
> escape hatch designed in to help users, unless the "key" is for
> something very obscure and not meant for every-day use (read: not
> deserving a proper command line override).

Agreed.

We already have --gpg-sign[=<keyid>], so I suggest --no-gpg-sign to
override commit.gpgsign.

Sounds good?
