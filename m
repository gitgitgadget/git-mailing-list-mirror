From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2 0/3] commit: fix abbrev-sha regression
Date: Thu, 27 May 2010 17:58:04 +0100
Message-ID: <1274979484.4448.1.camel@walleee>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
	 <1274974492-4692-1-git-send-email-rctay89@gmail.com>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 18:58:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHgPk-0000mz-UN
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 18:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759190Ab0E0Q6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 12:58:11 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:52127 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758092Ab0E0Q6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 12:58:09 -0400
Received: by wwb34 with SMTP id 34so148585wwb.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=dNAItZ5bLnmfVAStEupMBoRPPO4+XDrctNhxO01iF+A=;
        b=rWsgV4ZnBkxbC8LCkBfct4T5hX1pDur2h7kqWWlr39jzwWdZERfmNTnXr+DqE7g59l
         f6WadoJe8bxfsx3EGKv95tgAibnyiqTKgRX2pRm5zou4sU3/WviHIqyVbZRYoW7h2eoF
         d1ELsJ4EHgxyKImvfTBuZIWQXkmmusR4sJiAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=BKnIBrkB+kBSPvsCabYdAQSUcd15tslDzmiy16EVueknvSAU01rIHTxl66Q0TBNkC1
         pawNYzF22Tk53SPD/GpjWnhJN09By4cTXhzRf92wkyHeG795X+6+fL1V/9i8ifTun1st
         ncWQYXZj52oVBOgLZroLjkQQubidnmpXcQcZ8=
Received: by 10.227.143.78 with SMTP id t14mr10048509wbu.224.1274979486887;
        Thu, 27 May 2010 09:58:06 -0700 (PDT)
Received: from [192.168.0.3] (5acc3abb.bb.sky.com [90.204.58.187])
        by mx.google.com with ESMTPS id y31sm9687165wby.4.2010.05.27.09.58.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 09:58:06 -0700 (PDT)
In-Reply-To: <1274974492-4692-1-git-send-email-rctay89@gmail.com>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147887>

On Thu, 2010-05-27 at 23:34 +0800, Tay Ray Chuan wrote:
> After c197702 (pretty: Respect --abbrev option), the summary output for
> git-commit began to throw up non-abbreviated SHA-1s.

Please CC: me on any future versions of this series, if there are any
-- 
-- Will
