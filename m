From: =?ISO-8859-1?Q?Kevyn=2DAlexandre_Par=E9?= 
	<kevyn.alexandre.pare@gmail.com>
Subject: Write and Submit Your First Kernel Patch
Date: Fri, 23 Oct 2009 14:46:24 -0400
Message-ID: <dc1d0f40910231146y14028f4el9753debdf334103@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 20:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1P9r-0003gq-PA
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 20:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZJWSqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 14:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbZJWSqV
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 14:46:21 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:37515 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZJWSqU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 14:46:20 -0400
Received: by iwn10 with SMTP id 10so4835848iwn.4
        for <multiple recipients>; Fri, 23 Oct 2009 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=KxZyfsrwD1P7A/vyk5EPzhwudJVK/FWjDO5enq5OjpQ=;
        b=J9lEbLHH+VlXPWFtaatgsfHFA1aW+DYXnMJ/00vCHWeO61ePs9/qyU4bJo1wM5fCfl
         CJzVTnxNvM5dgAwfjwEIBosIFUYwL5GCEmIslqp1cNsCtc/jO1smcbeRN64seA0MCB1L
         wlDd+9Do4icVTxR8GeULkAeKwhBwOrEaHDzJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qfp3IVnOUpzCY0QvSUYBkIM+/LOFSWP9jxmkQ+mJ0iSGppp6/QR1F51CQiGXAmH2FF
         y+/ULqAWDDOwE/R3iLBGWeegK2v89lmq4Tm44HFmLM3RpxmtS7u3zGR3ml2kwN1msaqu
         dl6NlKqzlpCJBm5fe73vyehgDcvVNU4K+lClA=
Received: by 10.231.123.41 with SMTP id n41mr4223012ibr.46.1256323585024; Fri, 
	23 Oct 2009 11:46:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131114>

Hi,

Just before I send my patch I got this error with:
./scripts/checkpatch.pl --terse --file
0001-Staging-comedi-driver-fix-coding-style.patch

0001-Staging-comedi-driver-fix-coding-style.patch:27: ERROR: trailing whitespace
0001-Staging-comedi-driver-fix-coding-style.patch:35: ERROR: trailing whitespace
0001-Staging-comedi-driver-fix-coding-style.patch:43: ERROR: trailing whitespace
0001-Staging-comedi-driver-fix-coding-style.patch:53: ERROR: trailing whitespace

I have done a step by step explanation of what I have done:
http://kapare.blogspot.com/2009/09/write-and-submit-your-first-kernel.html

It seem to me that the whitespace are added after I do this command:
git format-patch -s -n master..mybranch

Can someone help me with that because google did help me to found the answer?

Thx

kap
