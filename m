From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Problem in fetch (kernel)
Date: Tue, 24 Aug 2010 00:18:51 -0700 (PDT)
Message-ID: <82733.7134.qm@web31806.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 09:25:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onnt5-0002B2-GQ
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 09:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab0HXHZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 03:25:35 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:46720 "HELO
	web31806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751128Ab0HXHZe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 03:25:34 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2010 03:25:33 EDT
Received: (qmail 8836 invoked by uid 60001); 24 Aug 2010 07:18:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1282634331; bh=ilAEhOk+twyK1uVYM6fFm/z6DSGPR+ZNC01025i64wk=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=VXmrcbEehruHmPBRizuPLIScpdNtXogblA9jozdtYfUSG18Q8KmGFvRPjFZuhVbVag5tzIri797I/IGo9kx1mYGbZ08E9OrEabfzcnNAmiB1XxADWTvQ6YlK3tEGww9KODAijVszLqrBenBa09asvyoaIl8D37X07sysbZwpkeY=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=ftI+AV757O+pOddxEv4dphKq76lte58hPE9SQmkwm0uZ7JU+wWGJ4yXTDNgB4chyzcdcIPTSBCk4w1bAzzU6BmXtD3yd3XGwlhK+p/nSv96lhYcQAu/ilkJRuW0HN7KwrHPXusecvqVQ2mGQ61kSwPOupCaDfG6qXNUdLyrtq+E=;
X-YMail-OSG: GnFvIuEVM1lj0gSPKiBVSCeqH2ylkdalwJshU67h6uV64Um
 7EVmEJXfGcG2NV0nru0CsEpWuOyUurgYa7fXxdio9Z2SzDUPDK9HevB8xDat
 1YtCvm6z_Yx4r2LyHfGk_W4WVDO3dqzBHHYFwbT3P2atrsDOn2KHyGux2dQS
 vantxxzzKdL7nQeZS_q9GF6jKG05k6gjUOtIvCo0LuUNO2WHWrBpqUrW4TV7
 SfUe_b2xZSSzx._4GXh5RxY.QID_YiM3WAMSZ8DrkauELfGkG660MnCuqPL0
 1r0wyTBHj6v0vIjueBJsdX8gOC4PyxSyLJ7ZOV.Vy3i280MDa.8Wq1l78IbL
 vE57ZiZLFc3UleVEPi6gahMTf_WM-
Received: from [71.132.202.60] by web31806.mail.mud.yahoo.com via HTTP; Tue, 24 Aug 2010 00:18:51 PDT
X-Mailer: YahooMailClassic/11.3.2 YahooMailWebService/0.8.105.279950
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154303>

Hi guys,

While trying to pull the kernel I get this:

git pull -v --progress linus
error: Unable to find 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a under http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Cannot obtain needed blob 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a
while processing commit cca77b7c81876d819a5806f408b3c29b5b61a815.
error: Fetch failed.

This is with git 1.7.1.

How can I resolve this?

Thanks,
   Luben
