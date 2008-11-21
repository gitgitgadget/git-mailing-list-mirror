From: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than 998 symbols
Date: Fri, 21 Nov 2008 15:29:34 +0200
Message-ID: <5ec8ebd50811210529q3b97c977y5d880502aa111e3c@mail.gmail.com>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
	 <20081121115813.GB3747@sigill.intra.peff.net>
	 <4926AE4E.5000604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 14:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3W5z-0001Fr-UT
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 14:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbYKUN3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 08:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbYKUN3h
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 08:29:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:1967 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbYKUN3g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 08:29:36 -0500
Received: by nf-out-0910.google.com with SMTP id d3so460118nfc.21
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=szPB85mNf0PnVhKdFMD6OaTvMfkpqZkZttamUW3M5zI=;
        b=FrFyIacZr93VvPTozbnNgj6a0o4G62E22k1wjhA7LQWhx9K1Q3eEsbL+S9LICQi8ld
         LN/dea2NtO0PygrRIOpcXqVyyPVjGfe8q+ZEPL8x2U9QjCQ+C+qbU5PYczwtM43Ze1fO
         RGT47t3gKoitsuCPXBXUrQ2YKzmPjdYUAfJSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uglTSRnsDLdr2NhQilOdBwRmtCiecJtoyDiN/HZA/EV1v7FS4mtP/0blwMxcd/kXqJ
         2IO8dmLyXJm2KhKRwEILtUIYY6vVd+MFUWhHUtb4B5euycWmK9Lkx0dM+plTwGMPSQJx
         1SxBYmcYW64pcleYhJtZ9BVcaGWf7Z2gchYGE=
Received: by 10.210.123.2 with SMTP id v2mr597460ebc.0.1227274174553;
        Fri, 21 Nov 2008 05:29:34 -0800 (PST)
Received: by 10.210.54.12 with HTTP; Fri, 21 Nov 2008 05:29:34 -0800 (PST)
In-Reply-To: <4926AE4E.5000604@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101526>

On Fri, Nov 21, 2008 at 2:49 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> In fact it is documented in git-send-email.txt:
> --[no-]validate::
That is I found just after I have sent the first email.

P.S. Thanks for all, patch is wrong.

-- 
With Best Regards,
Andy Shevchenko
