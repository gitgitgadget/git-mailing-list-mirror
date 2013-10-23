From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Tue, 22 Oct 2013 20:21:48 -0700
Message-ID: <CAJo=hJssxNtJSeLgwG5nON=Y-7HzZPULiwzH+0SXeU8tp3FC-A@mail.gmail.com>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com> <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
 <20131018221535.GM865149@vauxhall.crustytoothpaste.net> <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
 <20131022233257.GA9464@google.com> <20131023013400.GB9464@google.com> <20131023030048.GX865149@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Oct 23 05:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYp1T-0001L0-Po
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 05:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab3JWDWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 23:22:11 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:37079 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab3JWDWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 23:22:10 -0400
Received: by mail-we0-f178.google.com with SMTP id q59so180933wes.23
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 20:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jLt1MlmwnmqicqxWGiPk4L02OwGBGPZQJX5vnZRO99c=;
        b=LDHeTM6Yht8xmPp7NcDX5Wy4FyDhFSkcgItje8EjW7mhQ9x8wVQ50/v8q5m3B2kXhh
         PmKk6mPoT3V22JJ6Dc8dTygX1SA+GZuR4KttQ24y9xYfadz65y27pjkyHpJA4zhEmUK5
         ehdlFmq4ifg6ZHxMWIz/l59H+aD3C9kAR152o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=jLt1MlmwnmqicqxWGiPk4L02OwGBGPZQJX5vnZRO99c=;
        b=ljNXMuWkrTT3kdQqA/SyZ1ic2MqLtaRLyp++orqYlAXXn9dgUKkMddXHSvJW6uG73y
         h6oD+CqG9INr9vqF2StNVN8x3+NBYp3TWb5yEhGa7e0Chlv6mvgjFG/Iw1dnpDaDCLfU
         JapRZAKAfiECnx64M374oPOb3wG1KMRIX9S+ygiNpmxeZnJcGAQw/aP48FDVkb4nRDU/
         nBkNcrH9lRdJid6Vl0EX7RGoXrNXYQGeYrUYsZPtouB2i5uTA3iYMZUoE4YCIy4aQtXW
         4CwXPQeqwIPtL1zCAMSoEoGCoFL980r4idFmtGYoutCwBdvFInNh2OGGRwFQGtv86gpG
         FfFA==
X-Gm-Message-State: ALoCoQmyVkAo31zhzWF+S5jgGvctXWWPo+LexFWnqqgcOdAbMonNpv41F6FS0LhUMGjSlX9N/R2X
X-Received: by 10.180.36.242 with SMTP id t18mr110503wij.28.1382498528724;
 Tue, 22 Oct 2013 20:22:08 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Tue, 22 Oct 2013 20:21:48 -0700 (PDT)
In-Reply-To: <20131023030048.GX865149@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236498>

On Tue, Oct 22, 2013 at 8:00 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, Oct 22, 2013 at 06:34:00PM -0700, Jonathan Nieder wrote:
>> Forgive my ignorance: is there a way to do something analagous to that
>> patch but for GSS-Negotiate authentication?  In other words, after
>> using the first request to figure out what authentication mechanism
>> the server prefers, could git prefer it in remaining requests to avoid
>> the need to rewind?
>
> We know what authentication mechanisms the server offers, but we don't
> know what curl will use, other than the fact that it prefers non-Basic
> authentication (this is documented).  So if we see Negotiate only or
> Negotiate and Basic, we know it will try to use Negotiate if possible.

Yes.

>> I don't see any simple way to do that using the libcurl API.  If
>> checking if the server accepts GSS-Negotiate authentication and using
>> that to decide whether to 'Expect: 100-Continue' is easier, that would
>> be fine, too.
>
> If that's what the consensus is, that's much, much easier to do.  The
> only problem is that if we have Negotiate and a non-Basic method, such
> as Digest, we might force Expect: 100-continue on when it does not need
> to be used.

>From my perspective, it is OK to defaulting to use 100-continue if the
server supports Negotiate. If the user is stuck behind a broken proxy
and can't authenticate, they can't authenticate. They can either set
the variable to false, or fix their proxy, or use a different server,
etc.
