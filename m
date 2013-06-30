From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] completion: add completer for rev-parse
Date: Sun, 30 Jun 2013 16:47:08 +0530
Message-ID: <CALkWK0mDj5h2qyBnwaObEOQ_KZkZg4U1oYNq=wvSqsPcCZfAwg@mail.gmail.com>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
 <1372429088-385-4-git-send-email-artagnon@gmail.com> <20130630111436.GB2294@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 30 13:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFdg-0004v2-RV
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab3F3LRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 07:17:49 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:60580 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3F3LRs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jun 2013 07:17:48 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so7329193iec.27
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=A4BCBTO7YIWeET0ZUPg1HUL8At/4/vP5ceP6cKNlNeQ=;
        b=cfkV3RL2OAvN2zxKTT/UOC0R+fsYFKml8PvwrHQL9nYZsONHyqv5ZgN8qtVxg3pkT+
         YilvQgPoCPgrpOYVbId/ZQixnVL+dwqXQCYyMChsabscEZMNQDDYScHtrnNU6LFO+WNa
         TyEG7aoAGMfaJGsO55bp6nhAZdb9Yy4slbNnDVVJXHnsd79PqvOdokRq+dzvWfnvys5/
         YouCQ8vUevdEL8v96REHQls6Bjr2l63BWfMdIcb4DdJQiNaA1fNFq1QjXjisA5g2D8yD
         cEVBkq9uKrzaq33z7WuckdMnY/9EnlFIeSDXHY3HOwxNrJJKZFEIMBrbq699gqem/U4b
         vY2A==
X-Received: by 10.50.1.37 with SMTP id 5mr11258478igj.29.1372591068232; Sun,
 30 Jun 2013 04:17:48 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sun, 30 Jun 2013 04:17:08 -0700 (PDT)
In-Reply-To: <20130630111436.GB2294@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229272>

SZEDER G=C3=A1bor wrote:
> Either way, why these five options?  'git rev-parse' has a lot more
> options than that.

We have to start somewhere, so I put in the options that I personally u=
se.
