From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 09 May 2014 11:33:53 -0500
Message-ID: <536d037150f91_5e14c1d31019@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <536c7f9089b77_182dd0d31084@nysa.notmuch>
 <20140509081507.GA26494@dcvr.yhbt.net>
 <536c939781d8b_2bf0e952f08@nysa.notmuch>
 <20140509085937.GA29347@dcvr.yhbt.net>
 <536c9de8f07ae_39ea14ab310f9@nysa.notmuch>
 <20140509145453.GA18197@sigill.intra.peff.net>
 <536cf11632a85_ce316372ec85@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 18:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WinkO-0002Il-My
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 18:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbaEIQeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 12:34:01 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:64559 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbaEIQd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 12:33:59 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so3650574ykb.35
        for <git@vger.kernel.org>; Fri, 09 May 2014 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=r/fS8BoKlnk5lORkDNQ2VUmbqLfTmKZf6cAMoHASm2Q=;
        b=ruTBHvfsudCdjCtQgvPQKQWmV6ITgNZkqVG8YJLX8Q3nrjfDT7jbrIlatDRMs/IRWu
         CTSIy8PaUS18ad971Y/++fEN3aqXFB+E4kplhbM1fvM7jg+glkbIhHV47mdz56Vpug3M
         iEp/kpLvDXGAq8Bsr6I2b1CGPKsBjrRxrgY9myEyXqiUEBiof3MD1wrVvHtZHv5QDhQ8
         bJJtbsH9hhu9sNn+1ePOh4GJmr6w2iQkMddHEkNSmCjUhBgs+sEjFBI3fjhAR8XDk3H5
         1WTP6lusCn/60YMDykZ+IMMXiYR9Rdxul7bndaG+BINCwOInzzEFC7APdZua0W6cFrgP
         5y+g==
X-Received: by 10.236.114.2 with SMTP id b2mr16309901yhh.92.1399653238777;
        Fri, 09 May 2014 09:33:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j76sm6828574yhi.33.2014.05.09.09.33.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 09:33:57 -0700 (PDT)
In-Reply-To: <536cf11632a85_ce316372ec85@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248584>

Felipe Contreras wrote:
> All right, I guess that' something, but I get:
> 
>   Use of each() on hash after insertion without resetting hash iterator
>   results in undefined behavior, Perl interpreter: 0x1fec010 at
>   /usr/lib/git-core/git-archimport line 129.
> 
> And a ton of:
> 
>   WARNING: no rule found for checking signatures from atai@atai.org--public
> 
>     Consider creating ~/.arch-params/signing/atai@atai.org--public.check
>     or ~/.arch-params/signing/=default.check
> 
> I'll leave it running and see how it goes.

It finished, but tons of errors everywhere. Unless this repository has
only 120 commits, I don't think the import worked properly.

-- 
Felipe Contreras
