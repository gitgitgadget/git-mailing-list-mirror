From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] interpret_branch_name: factor out upstream handling
Date: Wed, 8 Jan 2014 18:07:58 +0530
Message-ID: <CALkWK0=YQVSnip27-MbB0ASZ_9AMF-ZxuPzP73wWEhxwdZYqJg@mail.gmail.com>
References: <20140108093338.GA15659@sigill.intra.peff.net> <20140108093450.GB15720@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 08 13:38:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0sPE-00046a-I3
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 13:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbaAHMik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 07:38:40 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:58633 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434AbaAHMij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 07:38:39 -0500
Received: by mail-ig0-f182.google.com with SMTP id c10so4459097igq.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZbJEoS4ctsFMxtOikZ4peIBRJQ0AhmCHzYmjU9huwnU=;
        b=EkFmBbMhGUFGK+1lN+ouGYEORjIjIPf+YOFgBf3i6tqvU47HAAI+/JWx9w5gbSsJUn
         FA2p8yYW+gxc5DwBAHFdwsQmuVZG6AtbwraPp6jLvZUvEiOskOuQKrj5N04N/5VYmWbW
         K88F1WjfpZDretlVcusE22jBesiTQ4zcGewS5NT+t42iK78pYmdbiWNe956PGER6/Dmx
         beBaGWt2Vsi/8OJdQTt+r32xknHNxjP0HHPkbHu/rCttKlwZmzkGcWtOAYa01aTXov2/
         5LSxgkd6SoipL50t1RFWvtViC6PfGnENinBiZSME8QukJG/NFzqN/SdZgWUmgbQjB7os
         vDSQ==
X-Received: by 10.50.36.67 with SMTP id o3mr31357573igj.47.1389184718994; Wed,
 08 Jan 2014 04:38:38 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Wed, 8 Jan 2014 04:37:58 -0800 (PST)
In-Reply-To: <20140108093450.GB15720@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240212>

Jeff King wrote:
>  sha1_name.c | 83 ++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 52 insertions(+), 31 deletions(-)

Thanks. I applied this to my series as-it-is.
