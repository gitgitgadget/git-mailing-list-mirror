From: David Symonds <dsymonds@gmail.com>
Subject: Re: Article about "git bisect run" on LWN
Date: Tue, 10 Feb 2009 08:03:23 +1100
Message-ID: <ee77f5c20902091303v1d268761ufdc85e2364097d84@mail.gmail.com>
References: <200902050747.50100.chriscool@tuxfamily.org>
	 <20090205141336.GA28443@elte.hu>
	 <200902060623.16046.chriscool@tuxfamily.org>
	 <200902070541.29955.chriscool@tuxfamily.org>
	 <ee77f5c20902070455h360d8476re76294735673b4ca@mail.gmail.com>
	 <7vskmqw1s4.fsf@gitster.siamese.dyndns.org>
	 <20090209121943.GG17782@elte.hu>
	 <alpine.DEB.1.00.0902091414310.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Andreas Ericsson <ae@op5.se>,
	Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:04:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdJF-0005pW-Kp
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbZBIVDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbZBIVDZ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:03:25 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:57291 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbZBIVDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:03:24 -0500
Received: by wf-out-1314.google.com with SMTP id 28so2599509wfa.4
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 13:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QAuRBI858vKZHZfXm27YNruCrnob9nDnmZ2B2X752Mk=;
        b=dO9XYXWKF0JW9F4YMk7+/oM09cl28Bf9gAvRnqLSoQ++J8DDxDQiFdeSLbA2aFQ5VO
         AuzvcJ681LcHU91XqvvKWAmd9e7aFJ4NqZbcsqL007XAB+EomjGX6LUZuacXb8dwTqQn
         aNC2dAR2AvqtJKYwc4wEFFr+G5fAx0cCMdT2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ltYXdV/7hNkZI0aV3xHqEuXQS2e4hbBUgeCSMJzGi0yQcNTLpY/nLa4JTbnOIbgHo6
         q5g3NYNqEKN0BDpvu24jObZf7ip7rlII3B2Dy+vomWtcEHpNcBBV0T9jrLRDh3A+byZh
         xvEwn0ioZyHu/T79oj/+AgAvzoGnEjwtV04XU=
Received: by 10.142.218.4 with SMTP id q4mr3149584wfg.74.1234213403379; Mon, 
	09 Feb 2009 13:03:23 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902091414310.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109129>

On Tue, Feb 10, 2009 at 12:15 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> I think Junio meant using '< $file' type redirection, to avoid an
> unnecessary fork().  (Good habit, avoiding fork()s...)

Yes, I usually pass filenames to grep; this time I was
copy-and-pasting parts of the original script. But my point still
remains: it seems it would be cleaner to do this kind of
always-good-filtering in the test script rather than make git-bisect
more complex.


Dave.
