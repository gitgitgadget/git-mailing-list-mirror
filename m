From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT fails to clean patch series, and to go to a patch
Date: Sat, 3 Nov 2007 10:32:13 +0000
Message-ID: <b0943d9e0711030332s49877dcep46460121fb6ec712@mail.gmail.com>
References: <200711031045.21506.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 11:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoGIx-000153-Fj
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 11:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbXKCKcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 06:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbXKCKcS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 06:32:18 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:15135 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbXKCKcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 06:32:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1022871rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sDeSKAVk0h5LKnIuArRYtKRBqIX5DiI2JGPwp69U6Ng=;
        b=Kc7pHQro6ATsIZIUeT3E0xnZwXROJGm3B4db5yKHrRddKGPkidWRZXlIQRp/enAvEyC89/5e70PltpCtGj74hJAadYBMWlwZHkvtBTJMzgpaV3jjIJBID/+QKSEUzaLQX+L+n3n5LLI+X1iSD22gwC3W/imRFGll5ew8ajDueyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ggvv2JYQm0iYujSUKtUKroEIB1P5UidM6AbVgimWBYckMLqWGb3DivWxCGnA35yC8xh5yyw0OsP4wvu5rtaa6rTgOhz/kfBA1oUtKSEct2sFLDNVCuzNRsfldPHw6k4UlidJKL2Ced8gEXYRb2EUhx7h6o7wtgzxHFaMezmlo08=
Received: by 10.141.113.6 with SMTP id q6mr1372454rvm.1194085933170;
        Sat, 03 Nov 2007 03:32:13 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Sat, 3 Nov 2007 03:32:13 -0700 (PDT)
In-Reply-To: <200711031045.21506.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63228>

On 03/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> I have patch series with empty patch in the middle of the stack.
> After trying to stg-clean (and failing) stack looks like below:

Does 'stg delete gitweb-Update-INSTALL-file' work?

> 1164:[gitweb/web!git]$ stg goto gitweb-Use-config-more
> Checking for changes in the working directory ... done
> Traceback (most recent call last):

Does a simple 'stg push' work? I suspect there is something wrong with
the gitweb-Update-INSTALL-file patch but not sure why or how it could
get to this inconsistent state?

It's worth checking the values of 'stg id
gitweb-Update-INSTALL-file//top' and //bottom and whether they are
commit ids or something else.

-- 
Catalin
