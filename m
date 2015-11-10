From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: gitk fails to start after upgrading to 2.6.3 (cannot load
 translation)
Date: Tue, 10 Nov 2015 11:09:49 +0100
Message-ID: <1447150189.5074.22.camel@kaarsemaker.net>
References: <alpine.DEB.2.00.1511101040180.27599@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 11:10:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw5sI-0000Cg-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 11:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbbKJKJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 05:09:53 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37746 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbKJKJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 05:09:52 -0500
Received: by wmww144 with SMTP id w144so68487662wmw.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=3FlPvj1X7SqI5p5o3nsBe6NFr5HpNgZVJANttsNWiJE=;
        b=uLnlQcIBiscQLCUO8/sGrb6sxcQKaaFRjWS1JP741ZgA92TxC+MrWrlZ2zZibmPQQ2
         fyvAbZfJRur9md9LPdJvOp8Vfv7WC5maVELnvIfAC10bAemgn8aKJrbas9kqFQKgfdmM
         CoR163TAaEF5oOJ7pOBiEnaa71gfwbt37737SOWrpRh503mXL9INthyoFzlvcXj+rpTf
         ceZL4hFLygW8dw3JiDJK3FpYhdfyGfc8UAOYOW4zUHZLdnn+tNq9wnSjhUgbvIJw3uaO
         EOLyIMurkXrvVkNSZ6uipbqmv4SsdEmG9CV0xF5xzxmnJVcsG7BQtbouuvlRRSRk5App
         v1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=3FlPvj1X7SqI5p5o3nsBe6NFr5HpNgZVJANttsNWiJE=;
        b=klxg4M+1Br080wCh3UH9CAKlWLnY8Exa2FqAuINqHbhDy1dC78WJTxSmFx1ukXBZp5
         3xazualuRCsNZWXp0t6r6Q8R6QwcsdD/Fl0jQtnj5gPPYUSM7GITsu4sfMpLNaxZkSTu
         OU+RnGNawoVUxsjs4Yj7GhFFScF1V07URVV9HDz4oy4aR1pLwuJi+DHfPnqWCEb3lmxF
         2G6W/WmcfAxObI0VbJqgAYwpMf3DlQuSb+vyZQWBTxn2C28Xw7w4yuSF/MesUqzW+0ih
         t2Bt+SdMhMSAaeVTMYNhiLGwOKSmXBJg/L5lJ//fP99lkQXhf4qNqU3DR1Hs7KRJIL4B
         3jig==
X-Gm-Message-State: ALoCoQnOayUAt64cqTRNiidSmroccNTRvwnxwVxRKK63glQcrNFuCRN8QY2L3MizwZnY51K8gKqC
X-Received: by 10.28.218.72 with SMTP id r69mr3798331wmg.98.1447150191595;
        Tue, 10 Nov 2015 02:09:51 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id hk1sm2655137wjb.6.2015.11.10.02.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2015 02:09:50 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511101040180.27599@ds9.cixit.se>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281106>

On di, 2015-11-10 at 10:48 +0100, Peter Krefting wrote:
> Hi!
> 
> After upgrading Git to 2.6.3 (from 2.5.0), gitk refuses to start when
> trying to load the Swedish translation if I pass it a commit range:

Hi Peter,

This bug has been reported a few times already and a fix will be in git
2.7.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
