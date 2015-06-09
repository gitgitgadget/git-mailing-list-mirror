From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/1]: git-completion.tcsh fails w/ noclobber
Date: Tue, 9 Jun 2015 11:25:43 +0200
Message-ID: <CAP8UFD0s4ea5CPYUV1FWbi_eeK=V9a+a6MW75o9RwtyQ7RzhNg@mail.gmail.com>
References: <20150608230133.GA14473@yendor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>
To: github.2009@yendor.com
X-From: git-owner@vger.kernel.org Tue Jun 09 11:25:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Fn9-00076m-2g
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 11:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbbFIJZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 05:25:46 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37686 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbbFIJZo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 05:25:44 -0400
Received: by wifx6 with SMTP id x6so9769253wif.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0+qqWYzPkZz7Yu3txgxcSUeW3sF/KGfGIvw0LGcgGwg=;
        b=P5wX6+cpc4Ed+tYgEDcwMoSMoqSHy7h4qxaxOvbeqMCeew2zMjinQGfom6Dyq+HvI0
         DvcZI0SoN0aMAT7OlQ/OLkRMN2Pr5jGJp6j+i0spESwoAX9VJPMBwPxG1GFi3HUuwoLR
         j+88J88fLMYw2/mxNFXj+fExMs8MtskCSitbGuK7pQoOqGhzhH+vaslsd0P8XYGBMKtR
         iqWL0csxV0s3gKDYMlEvWlsPIQ5l/FfdnAet8+0IH22cVnUHU6gP6+WFg4632i2XunlL
         rrOUlC5I7Ohkse2jLzCiWn2SlkKN+57BUtkrz9HbHudSxhglxJ5YU4I7k8ejkYMHZvLk
         vXBw==
X-Received: by 10.194.237.34 with SMTP id uz2mr41017763wjc.155.1433841943171;
 Tue, 09 Jun 2015 02:25:43 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 9 Jun 2015 02:25:43 -0700 (PDT)
In-Reply-To: <20150608230133.GA14473@yendor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271157>

The subject is better but still not quite there. I suggest:

[PATCH] git-completion.tcsh: fix redirect with noclobber

On Tue, Jun 9, 2015 at 1:01 AM, Ariel Faigon <github.2009@yendor.com> wrote:
> tcsh users who happen to have 'set noclobber' elsewhere in their ~/.tcshrc or ~/.cshrc startup files get a 'File exist' error, and the tcsh completion file doesn't get generated/updated.  Adding a `!` in the redirect works correctly for both clobber (default) and 'set noclobber' users.
>
> Helped-by: Junio C Hamano <notifications@github.com>

The email address look wrong. If he really helped you, he probably
emailed you using another address.

> Mentored-by: Christian Couder <christian.couder@gmail.com>

"Mentored-by:" is used by Google Summer of Code students. If someone
helps you and you want to acknowledge that, you can add an
"Helped-by:" trailer (unless your helper tells you that you can add a
"Reviewed-by:" or maybe a "Signed-off-by:").

> Signed-off-by: Ariel Faigon <github.2009@yendor.com>
> ---
