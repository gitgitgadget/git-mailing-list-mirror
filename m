From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Replicating the default "git log" format with a format string.
Date: Fri, 13 Nov 2015 13:41:23 -0800
Message-ID: <CA+P7+xro=nNfzO6Q6-kGe6C=vJp-z_svd229kRZdf5QjQ+Di8g@mail.gmail.com>
References: <loom.20151112T011419-749@post.gmane.org> <20151113053800.GE29708@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kannan Goundan <kannan@cakoose.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 22:41:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxM6P-00046b-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 22:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbbKMVlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 16:41:45 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36218 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbKMVln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 16:41:43 -0500
Received: by igcph11 with SMTP id ph11so24764171igc.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 13:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Off0pF8rqAWvl3O9w/JEquzW/ljFYO7oMRtnPW2I+P8=;
        b=yaADXj+PXCfY2w8t80nGyB4x6aR0ARNVsCdk78oS6K2tgkcx1BqE4n0XcP9A7vEbpw
         qFEdrnKOtZGY4KbQ0M4MH+HrNCTS3TLXep2QgiBre0F+dlP6WV3BxAxxKzZE4nbZyuS4
         rjbNrKAaVFb6V4wGMNKkyAXi0VEaFnFp8aSyUUWX+AQc5RRNu9ypjmXJ+oob4L61TY9c
         RUzHa6lM4vpBwrrARdxssZu9IYq9isadyar9ceA6FCk/IogfkWClCfE3kPK16u5C1lJ+
         0YJeJ7wsd3XB3dNpZ7eEjY+/OuRr6F405CK10Orwl0LIO0B4kZPwAEhc6Ywa7LCFuyu8
         Z/XQ==
X-Received: by 10.50.87.71 with SMTP id v7mr308611igz.92.1447450903250; Fri,
 13 Nov 2015 13:41:43 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Fri, 13 Nov 2015 13:41:23 -0800 (PST)
In-Reply-To: <20151113053800.GE29708@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281264>

On Thu, Nov 12, 2015 at 9:38 PM, Jeff King <peff@peff.net> wrote:
>> Is it possible to exactly replicate the default "git log" format with a
>> format string?
>
> Sadly, no, I don't think it is possible with the current format
> specifiers. It would be nice if it was, though.
>
> -Peff
> --

Isn't this something that might be obtainable using the new ref-filter
work being done?

Regards,
Jake
