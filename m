From: David Renshaw <david@sandstorm.io>
Subject: Re: bearer token authorization with HTTPS transport
Date: Tue, 6 Jan 2015 08:37:29 -0800
Message-ID: <CACejzEACo17nsA8mqMCt9jHz3mhJsO-dWT07mE9OoPh_rhh_=A@mail.gmail.com>
References: <CACejzECGUnH6B2Leq+H6u0Joo1SQmMCZ5UoHja_fK99+6a_iEA@mail.gmail.com>
	<20141230235610.GC10649@vauxhall.crustytoothpaste.net>
	<20141231014209.GA8789@peff.net>
	<20150106024123.GF1025060@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jeff King <peff@peff.net>, David Renshaw <david@sandstorm.io>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 17:38:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8X8S-0001DG-8D
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 17:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbbAFQhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 11:37:31 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:40425 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbbAFQha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 11:37:30 -0500
Received: by mail-vc0-f170.google.com with SMTP id hy4so9299828vcb.15
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 08:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=qTtylPi8/a50vFZ+bzvUMwzQcJT6DquGF/HBKKWcN5s=;
        b=Rw1woz02OQwoeuqH+wXkAPOVO13VMgJQET7dGjMm7/nJCpmRbm0etE+PgO0xe5FOJk
         N7A8konbMLywpDsX3twd7fv6wLi7IsIsFCCGwgQqnbNDWjrVMUELUGignSy+cs9Az/5R
         esNpG9YOg8K5OIdvDtN2+EeLYbf9Kaep6T2B9ci09mCAaGNSgK+//jrTTh4qmMs0roUn
         q49SPvuuf4lxzXZ3S4co4oKKq73X0lP/LE7MWPzhrHIwojVJlVBfH+k8ge/hYOiN42rH
         YTYpRSI52rf+j/gUQ4Eo9iHOMBorqsZ9VdY2iQcoDkt2e4qxrja+yof6jm0/dFMXc4O9
         iQJg==
X-Gm-Message-State: ALoCoQkCWAV6UX1atDyyEoRFkoojBYCnjZ0uxndvjPheeo3i6DxT+K9Ux+n/Jvnl4fqpXsq/gyPv
X-Received: by 10.52.65.108 with SMTP id w12mr51296805vds.8.1420562249785;
 Tue, 06 Jan 2015 08:37:29 -0800 (PST)
Received: by 10.52.180.232 with HTTP; Tue, 6 Jan 2015 08:37:29 -0800 (PST)
In-Reply-To: <20150106024123.GF1025060@vauxhall.crustytoothpaste.net>
X-Google-Sender-Auth: 66uI9XLqEjifjNeZEcjKEo3ZS5M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262076>

On Mon, Jan 5, 2015 at 6:41 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> For the benefit of someone trying to implement this, libcurl has the
> CURLOPT_XOAUTH2_BEARER option.  It does requires libcurl 7.33, though.

As far as I can tell, libcurl supports this option for IMAP, POP, and
SMTP, but not yet for HTTP.

- David
