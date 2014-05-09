From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Fri, 09 May 2014 09:16:26 -0500
Message-ID: <536ce33a860a2_3cfd9d12f08b@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
 <20140509015107.GA9787@sigill.intra.peff.net>
 <536c35a3507a8_741a161d310cf@nysa.notmuch>
 <CALbm-EbcoZmWtuxMLSZWjPcgKVTXZPcQ_ppj2UGKzF9oh+hQvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 16:16:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WilbI-0001cY-7A
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 16:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbaEIOQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 10:16:32 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:53475 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaEIOQb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 10:16:31 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so3746756yha.13
        for <git@vger.kernel.org>; Fri, 09 May 2014 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Uuw/WqdqSq2KXlrieGv5gMJm+5/H1JeGY0xRa0+JgwA=;
        b=YKPsqWqGeHGGSx+TiZdlr4YJ9xsO0f1UOhOQ0vLV/dDuw/DRMjVVUnS69F2A34taPZ
         7jF/0DeB1Rdhn3ycTi0JcXk+XKDT5vosA6wLHvl9+oTA/5UK8wtFdkXM68CzB8zJTCxt
         fPU0RorNLTNXevb5Gk75opINzZsyckFKFQHPaRn3k3C4C158aEYIwRGbljrgVo606hAQ
         7i6A0CdRvyAwLOCWeMg9Hb2pxhYUdcHAMPjHJyKQWoH3Mw9cAofSIegyRjfgOylfMWhH
         /OSlyvKv/f9H7F2yqvGwfn0plGou7/mHTDQRpDBwziYo7TIJAfc1Fdx6VzCRiuSQMWhG
         AlLQ==
X-Received: by 10.236.86.5 with SMTP id v5mr15140682yhe.153.1399644990951;
        Fri, 09 May 2014 07:16:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id k7sm6319508yhj.31.2014.05.09.07.16.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 07:16:29 -0700 (PDT)
In-Reply-To: <CALbm-EbcoZmWtuxMLSZWjPcgKVTXZPcQ_ppj2UGKzF9oh+hQvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248559>

Stefan Beller wrote:
> >
> > It is serious.
> >
> > The purpose of the 'contrib/' area is not clear. The statemens coming
> > from Junio don't match what is on 'contrib/README'. So we have a huge
> > variance of quality all over 'contrib/'. Some tools in contrib have
> > higher quality than what is part of the core (e.g. they have tests,
> > while git-archimport doesn't).
> 
> How about rewriting the README then?

To say what?

> Also as I said in another mail, we could split up the contrib/ area
> into multiple areas with narrow defined use-cases, i.e. staging/,
> Documentation/historicTools (the current contrib/examples section),
> 3rdPartyTools/, Bridges/ (for cooperating with other VCS).

That won't fix the issue that these tools are not maintained. A separate
repository 'git-cruft' might do.

-- 
Felipe Contreras
