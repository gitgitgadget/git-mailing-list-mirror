From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v3 3/7] i18n: Rewrite gettext messages start with dash
Date: Tue, 24 Jul 2012 11:44:23 +0200
Message-ID: <500E6E77.5090909@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com> <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com> <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com> <441f0613d796c35b6865a1258f074d1ea91e605c.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:44:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StbfO-0004XC-HH
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 11:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab2GXJo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 05:44:29 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51863 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753165Ab2GXJo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2012 05:44:28 -0400
Received: by lahd3 with SMTP id d3so721191lah.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=wEm/43OQZUIzpYhrruhVMHCmbR1eq9wJvIEj/kSiXsE=;
        b=hUQJePyzyLPhwIuz2ZmjQw9QLmBp+CSUENFyTplG6w9sd4Z3GA8qOCtWQJUb1vr3xY
         OyAxnxszwtP7tq+AU6BW1xL/DDD/Yhq/HXiRkOXcWo5ei2+E3zSZjIsx/9qruflGXkQA
         xUaTiaihGX9FT5f8Gl43klsyJrxHXUfMXUhTDVY0WGloptEWhpzGClTUZjjJ+4NCR0B4
         yXVWJ3/Nz/v5nMT+G0t0trwTQDb/slUp2noMax6nVsJykAMSfqvWM25WwhP1yl4kqbjB
         ErS5V7Iy23Gk2IcD615k6NZJXDcGlNZu6vSw3y3oUp8rzscjtEVsay9Z31SPgmiIW95w
         cTAA==
Received: by 10.152.136.18 with SMTP id pw18mr20702071lab.17.1343123067141;
        Tue, 24 Jul 2012 02:44:27 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id j1sm3694660lby.8.2012.07.24.02.44.24
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 02:44:26 -0700 (PDT)
In-Reply-To: <441f0613d796c35b6865a1258f074d1ea91e605c.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202024>

On 07/24/2012 08:59 AM, Jiang Xin wrote:
> Gettext message in a shell script should not start with '-', one
>
I think using a semicolon instead of a comma after "one" here would
be clearer.

> workaround is adding '--' between gettext and the message, like:
> 
>     gettext -- "--exec option ..."
> 
> But due to a bug in the xgettext extraction, xgettext can not
> extract the actual message for this case. Rewriting the message
> is a simpler and better solution.
> 

Regards,
  Stefano
