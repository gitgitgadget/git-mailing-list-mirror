From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Should "git help" respect the 'pager' setting?
Date: Thu, 30 May 2013 22:38:59 +0530
Message-ID: <CALkWK0ns3iVATnPwZ4OFJUxefyE6j-ayV3-iwh3Wr9FBZJyt1g@mail.gmail.com>
References: <CAKtB=OCyoN8ECYiAzXc3UiCrLfWn7Pq7_5CSQUjJ2dhbzQ2RsQ@mail.gmail.com>
 <vpqtxlko1vn.fsf@anie.imag.fr> <CALkWK0=RUy6=4k9uGpy2efdL8DhOnNO52rHZWSmHP3C=2a4SUw@mail.gmail.com>
 <vpqhahko0ub.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Campbell <michael.campbell@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 30 19:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui6MC-000096-Rv
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 19:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934534Ab3E3RJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 13:09:41 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65143 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758408Ab3E3RJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 13:09:40 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so1231109ief.12
        for <git@vger.kernel.org>; Thu, 30 May 2013 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jid0Ams1kG7gans1BqY3oSSZGzi1+7TpltycgucN2nE=;
        b=e/SgGyAP/4iCdrkEc7xmSBzl8EdMMAP4Q22u7xHIsjcwghLcBseP2H0V1g4AM8yJKL
         X6RttEogLP/5xsWqjuZIcIoDWg1PMzerM3YXZmi+sHP0jSJ5vto8iZvDsE3SMHei9n39
         y58pdmEQKHd0f5Igb9RbEis5FlE+KPNvXBwww69J8BXhSQ2CazDXBC2Q0RHeuiPomIP7
         WMA36k9QoJbo0VOF5tf/egtpgzbVLfk3T5+6McosHwSa3CTcxXnF6vLf7kt//DsaGWZM
         8yf3siod3wyv9Vigxc6vMnogLbkHxx/KGi9G/J8UDfOGh6lk8Mkv66AV02OU73cMhlcA
         EGKw==
X-Received: by 10.50.171.161 with SMTP id av1mr4090484igc.104.1369933779771;
 Thu, 30 May 2013 10:09:39 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Thu, 30 May 2013 10:08:59 -0700 (PDT)
In-Reply-To: <vpqhahko0ub.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226025>

Matthieu Moy wrote:
> I find it a bit weird that Git sets the configuration for external
> commands, but it may make sense. No strong opinion here.

I don't mean a setenv() kind of thing: how would we unset it after
that?  Perhaps something like execvpe(), passing in the environment as
an argument?
