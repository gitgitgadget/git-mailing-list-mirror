From: Garrett Cooper <yaneurabeya@gmail.com>
Subject: Re: [PATCH 4/5] branch: mention start_name in set-upstream error messages
Date: Tue, 2 Apr 2013 12:39:48 -0700
Message-ID: <CAGHfRMA8oAX-vigeYXxEVzWsrcPaWw0jCoOHWUMA-gbbAESNRA@mail.gmail.com>
References: <20130402190134.GA17784@sigill.intra.peff.net>
	<20130402190451.GD32316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:40:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN747-0006BT-Og
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631Ab3DBTjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:39:49 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:47540 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372Ab3DBTjt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:39:49 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so612495iae.39
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8rdpzlbMx8uj5Fk+5b4vwVHs3eiUErbHKra0OqtHO/8=;
        b=0RzPpDoucSA5C7IvodzRTM4Rh6nxEXKmZx8ZxNb61u4mjyW/1Jiral0ceqXiSrHNfE
         dl5jYZQcTLmMg0XI4D7gK/LsFSeY3cBTjNbDt4h7RSk0sLJpGYWjVcw7xwmQBGSW+VGM
         WegMTaICCDNwoQtWQ2eCvcm9pU4rEBr96u1Y64XYZ4cyEGjpVEOU9Qw8swPLw1ds2NMc
         4DveTtLXR6Yo5Sb6uWHRWOC19430bmsy+HTQgwzPpHKVc4bAo8UYMqZLOCoAgnZwz17b
         0OL8vjyW8iirRydwiwx5iuVmDILIN9UYOfqZjn7QRP5gHkZcHYg9EIxbwHg1P1MTz5sY
         MARg==
X-Received: by 10.50.36.169 with SMTP id r9mr5680681igj.96.1364931588755; Tue,
 02 Apr 2013 12:39:48 -0700 (PDT)
Received: by 10.64.30.99 with HTTP; Tue, 2 Apr 2013 12:39:48 -0700 (PDT)
In-Reply-To: <20130402190451.GD32316@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219864>

On Tue, Apr 2, 2013 at 12:04 PM, Jeff King <peff@peff.net> wrote:
> If we refuse a branch operation because the tracking
> start_name the user gave us is bogus, we just print
> something like:
>
>  fatal: Cannot setup tracking information; start point is not a branch
>
> If we mention the actual name we tried to use, that may help
> the user figure out why it didn't work (e.g., if they gave
> us the arguments in the wrong order).
>
> Signed-off-by: Jeff King <peff@peff.net>

LGTM!

Reviewed-by: Garrett Cooper <yaneurabeya@gmail.com>
