From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git_getpass regression?
Date: Wed, 18 Jul 2012 16:23:55 +0200
Message-ID: <CABPQNSa1wd8TzQ5-H7HQaVD586POWotMhOWLvC5Y90nBAn4fUQ@mail.gmail.com>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
 <20120629173954.GA3804@sigill.intra.peff.net> <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
 <20120629203001.GA12937@sigill.intra.peff.net> <CABPQNSY3hJse6J7fDo0S5=ySZA4_7=JisfzLBUu135gR2nSF-w@mail.gmail.com>
 <20120630183607.GA19739@sigill.intra.peff.net> <CABPQNSYP6mUZb-1dCifytRxqP7_grzYzON2bjevK2zsGawb-yg@mail.gmail.com>
 <CABPQNSZGcReC4CgaYcmwsXyGSqzQgHKQceZ2M5D=zQmyAs8_Ug@mail.gmail.com>
 <20120703171121.GA3294@sigill.intra.peff.net> <CABPQNSZjZtRxf1=cdKqgp3FwP6Fw2W876si9=OpyHmZ6mjHRsw@mail.gmail.com>
 <7vtxx5wr6v.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 16:24:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrVBD-0000bw-Qz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 16:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab2GROYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 10:24:38 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52291 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab2GROYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 10:24:36 -0400
Received: by vcbfk26 with SMTP id fk26so1142400vcb.19
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DFGhu5ni1IZvNHPEs9IEmRrNB/NIsbQsrHpVXCYp91o=;
        b=GBI8aaOqBt5V0MJJksi6J7E3JtYwGuQEP4/YiWK/SqpDipHtFkzxkxXKk13V093O6v
         hURz3DOP6PEa4xrAdnjyq7CmAtQjZjncuGlE8FSnoSOAecsq07tFGhF400fRkzP3O20q
         V0s28OWQrKPCQCvVF8i3z9BPPy+pdiWAK72WtIf/i751XtsfRZuelx9ixnTqwInDvXLN
         QjsnLxlQ9BtTaVWeLGqAFdMLlBPx/8NjVv4fBHNCfkWlskt2WB5Yl7u+LHQEvzpj/y+x
         jvXipKzW/s7X1x/P/vfMZwXXFIKZa7u/04DsBgdegMcrHV8BH14WFUBTt7LVml2xFFIj
         VeKQ==
Received: by 10.220.219.140 with SMTP id hu12mr870066vcb.72.1342621475434;
 Wed, 18 Jul 2012 07:24:35 -0700 (PDT)
Received: by 10.58.94.13 with HTTP; Wed, 18 Jul 2012 07:23:55 -0700 (PDT)
In-Reply-To: <7vtxx5wr6v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201693>

On Wed, Jul 18, 2012 at 7:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping on seemingly stalled discussion.

Just to recap quickly from my point of view:
1. There's no regression.
2. There's room for improvement of the prompting on Windows.
3. I'm not entirely confident that I've found a safe way of improving
the Windows prompt yet.
4. I've been busy with other stuff, but I'll get back to hacking soon :)
