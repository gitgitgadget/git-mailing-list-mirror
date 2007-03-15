From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git protocol over port-forwarding
Date: Thu, 15 Mar 2007 17:29:38 +1300
Message-ID: <46a038f90703142129q55254a98na3341da0b6a0319b@mail.gmail.com>
References: <17912.16608.852664.321837@lisa.zopyra.com>
	 <Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk>
	 <17912.29057.435478.123662@lisa.zopyra.com>
	 <46a038f90703141514q5273e493r87f0ac7f52c1c216@mail.gmail.com>
	 <et9vkm$2j4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 05:29:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRhb4-0006j6-3B
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 05:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbXCOE3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 00:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbXCOE3m
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 00:29:42 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:43754 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965084AbXCOE3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 00:29:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so35233wxd
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 21:29:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r8uZLbPKz0BsfDab/+kF4oGqnGF7AS6ESMfZ6UP3HClPKHja4EhocXePq4umbZ+RGpH2ae4r4I0m66fvhx5ouRPDrlDZ3wTNLj88HNOTsIE/mhb1s3Jc13qHi2yNwqPGf52ixEWylFouJfQguBtUAxnhfXTFxcvo01Pm7YvhYR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E+y0AA0yfnTGbY9HiTHK9IYGzcG+zUmzu7+D4btJgGqK+QHoObH4GpFDugHG3Ji3Ky1ewFsWGPrZ/GjNJpejUG9RymouZ7QUnECdRpATAnLebyc1JeysAdR1t0X5sRIf5LmcXCOdMWyoBYd4mpVBcVKP8e6ek6M9+Qvws1h08Sk=
Received: by 10.90.65.11 with SMTP id n11mr83708aga.1173932978227;
        Wed, 14 Mar 2007 21:29:38 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Wed, 14 Mar 2007 21:29:38 -0700 (PDT)
In-Reply-To: <et9vkm$2j4$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42270>

On 3/15/07, Jakub Narebski <jnareb@gmail.com> wrote:
> I think it could be done but with _two_ port forwarding, one from git
> port to ssh port or 5700 port, on your computer (probably reverse tunnel),
> second from 5700 port to git port... unless you configure git server
> to use different port...

All the protections against man-in-the-middle attacks (host key
verification, etc) prevent straight port forwarding. That's why if you
want git over ssh you have to use the proxycommand option to ssh.

IMHO, YMMV, etc. ;-)



m
