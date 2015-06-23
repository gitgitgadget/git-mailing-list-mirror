From: Christian Couder <christian.couder@gmail.com>
Subject: Re: config commands not working _Noobe question
Date: Tue, 23 Jun 2015 05:05:19 +0200
Message-ID: <CAP8UFD30DciVRWXm74LDV4wRuVcDXZ59t_-vFy6pNVZVXbiAjQ@mail.gmail.com>
References: <D1AE04E1.1172A%gledger@glcdelivers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Greg Ledger <gledger@glcdelivers.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 05:05:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7EWc-0004UE-8U
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 05:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbFWDFW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 23:05:22 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33905 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbFWDFU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 23:05:20 -0400
Received: by wicnd19 with SMTP id nd19so93025522wic.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 20:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9G6Tbx/pL/zwOjzZqYF+XooJ6IEftm/F0yh7qOlzOnA=;
        b=h1KnTiQbgoRRjZCKERM8g2O6dQJH7iDxAlmEKqrtcVWCt72aT0GJ6Iaa01ZvHxbK3E
         0UlbPPeN4KG8nOcMCzK0kTs33FmkIFbBXluMcY+hYKkOainL6V0nK00xyUGkjkmMZhgU
         CrkWTKfKQdqweTWVnJYjnFhX/3kR2AsrB90W2SJcRscnqdmoiKaGX75gx5W9N3CKuLbS
         /cDPTu7pOEcoQWHCcLex+S1DrmxFH41udoqcJHNrlibfwUlnkAM0bbd6+pD10Jtt1hZ2
         yyT2FmRqqJwk35JX3JvRnuTwwXXCKwlqeCc69pH03LBFFR522u06VT8OFbHZ2whwGeE4
         wbCA==
X-Received: by 10.180.95.10 with SMTP id dg10mr37956292wib.41.1435028719373;
 Mon, 22 Jun 2015 20:05:19 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Mon, 22 Jun 2015 20:05:19 -0700 (PDT)
In-Reply-To: <D1AE04E1.1172A%gledger@glcdelivers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272439>

On Tue, Jun 23, 2015 at 1:31 AM, Greg Ledger <gledger@glcdelivers.com> =
wrote:
> after adding git config =E2=80=B9global user.name Greg Ledger and git=
 config
> =E2=80=B9global user.email gledger@glcdelivers.com, when I run:
> source ~/.gitconfig

The ~/.gitconfig file is not a shell script. You should not source it.
It is a text file that is read by Git commands when those commands are =
run.
