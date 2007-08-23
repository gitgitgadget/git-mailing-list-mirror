From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 11:27:10 +0100
Message-ID: <b0943d9e0708230327p12a39ac0xbe4e3b32bd3b5f53@mail.gmail.com>
References: <20070823092254.GA5976@kroah.com>
	 <b0943d9e0708230319m3242f4a7yb4db1505f0d2e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Greg KH" <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 12:27:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO9uK-0007tb-7y
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 12:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760029AbXHWK1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 06:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759240AbXHWK1N
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 06:27:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:46454 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115AbXHWK1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 06:27:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so337915nfb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 03:27:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h/82gvqa93LARL3OMR4LPyuDRwU01VjtVQQALOENampJpUarLhLLp5lhtxUNXml/NOUty+4SPwC9UZI4ZZgn2SXYEJ4zQwU48PcfQgEZCUtQKrXHMDCfNrqXJ7yVOc2BK3omyBSdhfgyjE7rnH7eGPwUhZlk2Ltc8mqcIOsckUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YngOgtbV2w4YFelaqWYltfUhZWcBs9xmC6TxNTgQ7cihqyht0Z4kyPGe/NU5QzSjvw/c+GbUeEX3sVYOuF7fnP9NqcpzFZeFxJn+7PiV7CBZ5IpO1B1jZ2o+sIaBjJ4OaxWG1Bp59HJN+gHYJ253m0jua/rvpbamCp9aSpU3j2I=
Received: by 10.78.160.2 with SMTP id i2mr1101566hue.1187864830729;
        Thu, 23 Aug 2007 03:27:10 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Thu, 23 Aug 2007 03:27:10 -0700 (PDT)
In-Reply-To: <b0943d9e0708230319m3242f4a7yb4db1505f0d2e3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56490>

On 23/08/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> One thing you'll notice is the speed difference as stgit has to
> generate a git commit during a push operation.

I did some performance comparison with Quilt almost two years ago but
I think both StGIT and GIT were greatly improved since then:

http://www.gelato.unsw.edu.au/archives/git/0510/10059.html

-- 
Catalin
