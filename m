From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: [PATCH 2/2] git-remote-mediawiki: allow page names with a ':'
Date: Fri, 20 Jul 2012 17:11:44 -0400
Message-ID: <CAPBPrnvoqh4-6vnhhd67tdBZRSqY-ixkzPxTfJDcchmQYxZghQ@mail.gmail.com>
References: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
	<1342533960-22123-1-git-send-email-Matthieu.Moy@imag.fr>
	<1342533960-22123-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 20 23:11:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsKUI-0000Rs-Th
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 23:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab2GTVLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 17:11:46 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:61277 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab2GTVLp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 17:11:45 -0400
Received: by wibhq12 with SMTP id hq12so896093wib.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PFKwZyY+4/94hMazC6Lqdd+LoNLWByXnroRp4XkcXc4=;
        b=ZQr+Ibejwja7StrJMiUWqDr9s7PMcizAly7/BrfizoKm/8f1U2XaaNlwrvTXnRv5fR
         txs1w7jfdFyAD21jyXMnZHGVtLCIIS5byCYT52NGHf7rMQiTqkpInwYAjpp+9SilbEFV
         6/2HHEOSfMdV4KqgFxGAGsJmyvrLpM0A1PBIH7XsNtjEd+UBYzXLQn+fv6lx2q5gydRX
         t4r8GFiWXiOMOKGnvybgMefPuNiq0wwcSzAwvg/8HS5zb8+AqHZT9aV0KOeeNmhq9q0W
         xV/+5LciS5XUrgFQF6WmJtdgBVdjQxHEy7CWsaAmSL3r6+c4+6QQNNKL1s2skjJdA4jF
         NgSA==
Received: by 10.216.217.229 with SMTP id i79mr3886178wep.125.1342818704120;
 Fri, 20 Jul 2012 14:11:44 -0700 (PDT)
Received: by 10.216.224.32 with HTTP; Fri, 20 Jul 2012 14:11:44 -0700 (PDT)
In-Reply-To: <1342533960-22123-3-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201791>

On Tue, Jul 17, 2012 at 10:06 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Traditionnally, pages named Foo:Bar are page 'Bar' in namespace 'Foo'.
> However, it is also possible to call a page Foo:Bar if 'Foo' is not a
> namespace. In this case, the actual name of the page is 'Foo:Bar', in the
> main namespace. Since we can't tell with only the filename, query the
> wiki for a namespace 'Foo' in these cases, but deal with the case where
> no such namespace is found.

Might not be worth fixing, and it's just a typo in the commit message, but:
s/Traditionnally/Traditionally/
?

-- 
-Dan
