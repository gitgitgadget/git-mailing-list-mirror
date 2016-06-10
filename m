From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/27] nd/shallow-deepen updates
Date: Fri, 10 Jun 2016 19:42:12 -0400
Message-ID: <CAPig+cRfUjpku1Abf=GxrbFeS4txwr=yZsJ7EKo-aWmxYog6Xw@mail.gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 01:42:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBW4A-0007oV-AK
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 01:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbcFJXmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 19:42:14 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36050 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386AbcFJXmN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 19:42:13 -0400
Received: by mail-io0-f176.google.com with SMTP id n127so78483450iof.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 16:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TkCpPmOrIa+Dlv/88GkCVF9oPDLpdwPGElr2PnKDjXc=;
        b=0Kmhyd6bpBqtfpvphRL5M6P1b8nRN9Ey/tnkRdheyPJJjRbcCWZy5GesdMkd2buBfc
         VAet2lm/XelX22h+R2X9DHV6vezSNLYpzSOSib/tpdM3MY2JR/8aFdjYUd3kpLtVAaZM
         +kLIo27FZLrWO8qvntD6oMM0NsWZZHI2Pw0RRSc7TXSvCSE/ppjB7vbGiv/4gzds0cTK
         UgyjrFG0OjMEsaKpCwrPrk7yoWZtO/O7rdbUKXcTndIxWDZZskI9OikbE84Iiy/pbRHX
         jGJGp5SAGGl7flO4NBdH6HYmVIuca7gefHFlaKKcgwnCYF1xDh7VyjccvSjTJw9f9Vgf
         6ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TkCpPmOrIa+Dlv/88GkCVF9oPDLpdwPGElr2PnKDjXc=;
        b=EhuUVf7aVuTXQxl9GRDKa90ENY9cH6C81aCxZDWpetHTkZUpWxdXKV56ioCNDGqjhP
         5iS9WLwNR5vCc5YBa44ikGB3+s29/Q85CcgYyZl0+VFhVWYWZcVZvcm4KdhbcHTNz8fe
         ZZ4ckhv3Z5WTooUBGMG2QddQsxeX7ghi6A0d6ySiAvmCX6wOOTPCiYispBB7Kf8ofL8p
         OB6vQii6E3Z1SphdTdwAKVKKn++/vwiGWFDD3mAtcW4wt7nF2pwlgRQjIpziEnugU88g
         2yHNCE07FMwNeULpdKPCmqBP/OrzUTSx9pMHtGlGHEv4KCtaIyynS1/L9w3jv5G2V2R4
         B6bQ==
X-Gm-Message-State: ALyK8tJXzEcgqVrw6ZW88Pm4FyjfEXGiaUOPGlQsknQ8rNUzxx0+ls2XlTdKOMUEp2CrfnA+ggOGr9s1pM5v+g==
X-Received: by 10.107.47.41 with SMTP id j41mr7705220ioo.168.1465602132633;
 Fri, 10 Jun 2016 16:42:12 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Fri, 10 Jun 2016 16:42:12 -0700 (PDT)
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
X-Google-Sender-Auth: WE5SDroBzIJ2imsHplqikvyx96Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297086>

On Fri, Jun 10, 2016 at 8:26 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This contains cleanups after Eric's comments (all good points,
> thanks!). Changed patches have Junio's s-o-b line removed, so it's
> easy to see which is changed and which is not. 09/27 is a new one,
> split out of 10/27.

Thanks, the interdiff looks sensible and I think it covers all the
points raised by my review of the previous round.

I agree with Junio that moving the sigchain_pop() into the error
handling code-path, if possible, would be a nice improvement.
