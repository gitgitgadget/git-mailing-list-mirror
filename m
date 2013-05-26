From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] fast-import: Remove redundant assignment of 'oe' to itself.
Date: Sun, 26 May 2013 22:17:01 +0200
Message-ID: <51A26DBD.80106@gmail.com>
References: <1369598719-10798-1-git-send-email-stefanbeller@googlemail.com> <51A26BB7.3060702@gmail.com> <51A26D0D.2030702@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 26 22:17:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UghNR-0008CB-0n
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 22:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074Ab3EZURI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 16:17:08 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:38660 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058Ab3EZURH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 16:17:07 -0400
Received: by mail-ea0-f176.google.com with SMTP id k11so3397253eaj.7
        for <git@vger.kernel.org>; Sun, 26 May 2013 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=gYq6xIgeF1Zzasz/+5IGw0BjAuPiLK9Kg0WbcoYG7Us=;
        b=yUYGfVS46uMTrQkLWspWV7wpJbkjHZRl2y1ED7FGBZYTiOGFQbWdx5p30+CODKsmmj
         etbl6iTAq5onFoxhikqXMPyRAcOx9eNPKwf04nkyHs55XVSj2uO5tYu1aJAmtx+ZeIga
         zbhKa1P92loP0Wk3t0j84xxt1g1fXCJYqtx3zL0CShnrgIIFXlTAwMuYZ2QlJy7hV+df
         D389VAzB766Ns2dIRMMpSZXA+Da/xyQ1B6rxKasCyaOU5YlLU4/J/mVhn4isoJKlcUcO
         sOXHI07rUesBQfVNCyVP5AjVbRDf+mYWdLwfhxQX/BJrzIDEqRciJrxy4hZs8LnOpr30
         1jLA==
X-Received: by 10.15.91.66 with SMTP id r42mr7368684eez.48.1369599424989;
        Sun, 26 May 2013 13:17:04 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id y10sm37348462eev.3.2013.05.26.13.17.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 26 May 2013 13:17:04 -0700 (PDT)
In-Reply-To: <51A26D0D.2030702@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225569>

On 05/26/2013 10:14 PM, Stefan Beller wrote:
> It's not done very often.
>
Of course; it's done only in those places where GCC gave spurious
warnings.  And it's done for no other reason that to silence said
warnings.

> [SNIP] rest of message

Regards,
  Stefano
