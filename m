From: Ilya Basin <basinilya@gmail.com>
Subject: Re[3]: rewrite history
Date: Fri, 17 Jun 2011 02:18:41 +0400
Message-ID: <724671388.20110617021841@gmail.com>
References: <362053118.20110616231758@gmail.com> <20110616192644.GB13466@sigill.intra.peff.net> <7vhb7ph8aj.fsf@alter.siamese.dyndns.org> <20110616194911.GA14355@sigill.intra.peff.net> <17721660.20110617000644@gmail.com> <20110616201300.GA14674@sigill.intra.peff.net> <7310048292.20110617015509@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	<git@vger.kernel.org>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 17 00:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXKtt-0002PZ-4K
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 00:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660Ab1FPWSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 18:18:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43456 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab1FPWSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 18:18:51 -0400
Received: by bwz15 with SMTP id 15so334435bwz.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-mailer:reply-to:x-priority
         :message-id:to:cc:subject:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JHZ6OSQGPA5XdsBbWgbsrpTF3C0x+IaWD22saIXtkDY=;
        b=pNFyN5cfZipklgPplOFUxgHN6jNOKcl56LVr9hvAOaO8P2qp/bQGiLc9ki8t/PaROy
         OH2n44VCM6m6SaJ6KQgYRmNvDXb79Fm28s3+Q64eJqoxpMP8AmKWTjoeEO++FS6MFrsp
         5XooXOHOW3Un0DUGQmMi1TlmlZYuK1ug4DTJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:cc:subject
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        b=m2C+uc2kKouxNXCG5bIFonScGK84BFFtWV36AT7dPzbIMXCHe6fHBeGeHBji2MZDUh
         Nm9ChcbqbpkCCdSQxaUX9eGEuM23xyuMD3XUQKCyWSteR5thZzQbhPqj0y3hR0nxW+Nr
         aNEfQCRS03PiwJziGWTtJ9AKuXDTriU4RZEmA=
Received: by 10.204.41.16 with SMTP id m16mr1087353bke.151.1308262730425;
        Thu, 16 Jun 2011 15:18:50 -0700 (PDT)
Received: from MAR2.localnet (pppoe.95-55-137-3.dynamic.avangarddsl.ru [95.55.137.3])
        by mx.google.com with ESMTPS id q20sm1519324bka.5.2011.06.16.15.18.47
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 15:18:49 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <7310048292.20110617015509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175938>

>>> sorry,
>>> git diff X X' is empty

JK>> Oh, then ignore everything I said. :)

JK>> I think you want to graft and filter-branch as Junio mentioned.

JK>> -Peff

IB> I'm puzzled. How to undo an unfortunate attempt of filter-branch?
IB> git log origin/master returns irrelevant info, although I didn't push
IB> it to origin and I also tried git branch -D master, -rD master and git
IB> fetch -f
Nevermind, forgot to rm .git/info/grafts


-- 
