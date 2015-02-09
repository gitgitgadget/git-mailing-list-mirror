From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Gmail Message rejection
Date: Mon, 9 Feb 2015 13:37:53 -0800
Message-ID: <CALbm-EaxbmajmcbqVMN-Jp-xcrqW=P2DGeyqKPg-YM+zncd5bQ@mail.gmail.com>
References: <20150209201408.Horde.2Ts12JtaemmvhMa5RcSg8w1@server.aercontechnologies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: erik@aercon.net
X-From: git-owner@vger.kernel.org Mon Feb 09 22:38:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKw1o-0004bG-20
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761393AbbBIVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:37:56 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38871 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761134AbbBIVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:37:55 -0500
Received: by mail-wi0-f172.google.com with SMTP id z2so9822539wiv.5
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y197x1usdx4zKzu7ybvcK/VokDoIN+8RMykTQHL9I74=;
        b=xQSNnE20zGiqjE1tHemDivAkXCnON2t5Z1b2SLmTu/C5EBGTY8LJpLPbqGJf8hq6R6
         5HZEicyuv+ihyj2IF+uqNolfr/ZsAD9vruGV3go0icAf6XTY6pHJYRS2DlxF3J+Lnrea
         PWLpO1yBaY4BQsR0Pnkebm0r2EyUKo9jnTPc5PxRIJbysppoMUaL9M++7JJhoetkoY2l
         RFH9nvGAllvhx/GxnhxFvYBWokVa5HbVoGMQPZ+OOTFG8nM4xZZNIh0mmFDnO7YfDOxn
         VUuTjfPDgJs5kfgtDgk1LZup4OPV4K+TKHZrN+dIOwNca0hi1j7HA2Vg70m0ATVffujd
         +Xfg==
X-Received: by 10.180.21.161 with SMTP id w1mr39904209wie.44.1423517873817;
 Mon, 09 Feb 2015 13:37:53 -0800 (PST)
Received: by 10.180.94.132 with HTTP; Mon, 9 Feb 2015 13:37:53 -0800 (PST)
In-Reply-To: <20150209201408.Horde.2Ts12JtaemmvhMa5RcSg8w1@server.aercontechnologies.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263606>

Hi Erik,

this is not a bug but a feature. ;) Actually rejecting HTML is one of
the easiest ways to avoid 95 % of spam mails. If you want email to
send via gmail, you can do so by enabling "text only" mode for sending
mails.

That is good for general discussion. But if you intend to send a
patch, beware! gmail as well as most of other mail clients wrap text
on their on ("optimized for human readability"), but a patch needs to
go through unchanged that it applies on the receiving side cleanly.
Therefore I'd recommend setting up git send-email, which does exactly
what git needs and wants for sending patches.



2015-02-09 12:14 GMT-08:00  <erik@aercon.net>:
> Can I submit this as a bug report, that sending something from the gmail
> client results in this response?
>
> Delivery to the following recipient failed permanently:
>
>      git@vger.kernel.org
>
> Technical details of permanent failure:
> Google tried to deliver your message, but it was rejected by the server for
> the recipient domain vger.kernel.org by vger.kernel.org. [209.132.180.67].
>
> The error that the other server returned was:
> 550 5.7.1 Content-Policy reject msg: The message contains HTML subpart,
> therefore we consider it SPAM or Outlook Virus.  TEXT/PLAIN is accepted.!
> BF:<H 0.338318>; S932497AbbBIUIh
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
