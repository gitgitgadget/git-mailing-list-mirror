From: Joshua Juran <jjuran@gmail.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Thu, 10 Feb 2011 00:13:13 -0800
Message-ID: <5C96089F-7CEF-44EB-98ED-C5FB9F641180@gmail.com>
References: <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr> <7vwrlcv1ea.fsf@alter.siamese.dyndns.org> <20110207055314.GA5511@sigill.intra.peff.net> <7vhbcguytf.fsf@alter.siamese.dyndns.org> <20110207195035.GA13461@sigill.intra.peff.net> <20110208100518.GA9505@neumann> <20110209210312.GB2083@sigill.intra.peff.net> <7vipwsomq8.fsf@alter.siamese.dyndns.org> <20110209234621.GA12575@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 10 09:13:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnReW-0001uQ-Mh
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 09:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab1BJINT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 03:13:19 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48377 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab1BJINS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 03:13:18 -0500
Received: by iwn9 with SMTP id 9so1029095iwn.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 00:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=uRMgN6fOvDzgKwvmdGiIxIRe/AJ9Qm6g67HXKEGJkBU=;
        b=Sd51IiJ/GKs3Ce1Luk+OzewyRYxGB2HsWaVG2cCPsQyPDJBe+zcy8nlNs5HTM30Rui
         Aeu8xW3hqDDLpjbsIGYVsHQdKdMXoPQ07b2R8Xf/VexyrHa3yBPoBuNy4H1wdyZyIaL8
         ymHfTKA4mlZJo6f1MxMgPUn1qECR1Ox1y40LA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=wtA9evyswp0BndCAlqgxd5q4ugwrCs5uJaFk7B9XooVcftSBe0JkmbzEfmcjjgukxN
         pqL/nJBEt3CYrpWPkqwrqv+rek3mzlClXt8VlHk59jmJWyIUvcmBXfcdHOvivgYp3QWk
         Lgm/x/zguTXkxS42+ZIXOWpBg7uI4WwdaB7P8=
Received: by 10.42.174.70 with SMTP id u6mr3743326icz.214.1297325597290;
        Thu, 10 Feb 2011 00:13:17 -0800 (PST)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id k42sm874059ick.8.2011.02.10.00.13.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Feb 2011 00:13:15 -0800 (PST)
In-Reply-To: <20110209234621.GA12575@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166476>

On Feb 9, 2011, at 3:46 PM, Jeff King wrote:

> The current behavior is:
>
>  add:    error (and suggest "git add .")
>  add -u: relative
>  add -A: relative
>  add -i: full-tree
>  add -p: full-tree

add -e: full-tree

Josh
