From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: How to tell what paths changed in a merge?
Date: Mon, 28 Mar 2011 22:15:53 -0400
Message-ID: <AANLkTi=wRunp2KG94MQEvMDp+GM9uiZybM4LrUVOrAti@mail.gmail.com>
References: <AANLkTi=DOf0beuts8TO0c5JJtDtjNAcQ_4hcKNkZoXjM@mail.gmail.com>
 <20110328202039.GA27755@sigill.intra.peff.net> <AANLkTinhRTwbU8DXc7sYxmxjKEiHASYmdKqxofmn+wgs@mail.gmail.com>
 <20110328204750.GA2998@sigill.intra.peff.net> <AANLkTi=vB4CsMZ_hT-Mruqs6tiEjUgEzbA2Vwaog6wNK@mail.gmail.com>
 <20110329014814.GA4696@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:16:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4OTj-0000D9-KU
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 04:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265Ab1C2CQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 22:16:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51637 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1C2CQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 22:16:14 -0400
Received: by fxm17 with SMTP id 17so3138808fxm.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 19:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=ZCnRyyP48L7lSGb9Ezh7GsP6tAcLTwfTl/wMv7ynXXg=;
        b=qzlPQrd8sa7yw0a0zfQsrdB3KfyrH4le8xJwY/UZLMxM0ccrZXME5MeqaXh8eCG9fV
         2tdUKkCni96FyiaqP+Cr2+auevz4MbRstrUUj4YB+TbtuoItKue2HfjFw+R81AhvXvHp
         6FOYu19IgyDkW6ccsMv356WLzMrkge9EwmBeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=O6LsQ+JS9+teSy5R0CKAvZPCAky+bGhC1mQSHR//VWIWhC2MqH2oBz+lfphO00JQHz
         AE5NymWpGPRYe+tHijqIEOQ2L+7ZOd8mesja4Wc/vNqmStdTffg6jk3YB0sfKV8/Tn6y
         rlVF5QBcXpr7bqODXWElftzmqWLgbhUCwvX6c=
Received: by 10.223.54.148 with SMTP id q20mr699057fag.84.1301364973092; Mon,
 28 Mar 2011 19:16:13 -0700 (PDT)
Received: by 10.223.123.135 with HTTP; Mon, 28 Mar 2011 19:15:53 -0700 (PDT)
In-Reply-To: <20110329014814.GA4696@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170218>

On Mon, Mar 28, 2011 at 9:48 PM, Jeff King <peff@peff.net> wrote:
> Try "git log -c --name-status" and "git log -m --name-status" to show
> the "combined" name-status and separate per-parent name-status
> respectively. Our default is not to show very much for merges, because
> it's a little more expensive to calculate and in the normal case, it
> ends up not being very interesting. Your case is not normal. :)
>
$ git log -m --name-status

looks like it will tell me what I'm looking for... (tomorrow when I'm
more awake and in better shape to try tackling this).

Thanks for your help.

--wpd
