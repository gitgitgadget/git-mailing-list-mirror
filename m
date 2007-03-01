From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] defaults for where to merge from (take 3)
Date: Thu, 1 Mar 2007 11:47:44 +0100
Message-ID: <81b0412b0703010247l14fe2027u76903ac1b9d32645@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org> <45E68897.8000607@lu.unisi.ch>
	 <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	 <45E68EDE.2090405@lu.unisi.ch>
	 <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	 <45E69297.8070001@lu.unisi.ch>
	 <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	 <45E69EEE.8070905@lu.unisi.ch>
	 <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
	 <7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:47:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMipI-0004NS-5M
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbXCAKrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbXCAKrr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:47:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:5078 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964919AbXCAKrq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:47:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so333412uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 02:47:45 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IrZ6wYmSLPL3Q3pEwuNAIDYhScuEeFDF5Y+jQfylfHqIB0e2eOgdMKnKCCWvOwEVr9ga1dyNumolTiA4CL5Bv9oYkUPcdHWOciq7TvvCjyv6yTPbBnCwiGto/TXYdeicYBZ/EGG782NMJs3MmAAJZgHq9ZF6hJwfqT1E+8BzdRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oTTOvb9nVgoNSBV7ztfRATxdIrA5+VSei7/Obcetgoei1t2sfU4LN4V5eIth8aD2tifjz/z/aL2t3Lz53VYqR305cpgDu35QYyjqM+EiBCspwrYZU6T0+fk3/S+snq+JQJzBU6bc2fxxUGVmCrT5S1R5WCxa2oq9VVN95N2C78M=
Received: by 10.78.178.5 with SMTP id a5mr142958huf.1172746064898;
        Thu, 01 Mar 2007 02:47:44 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 02:47:44 -0800 (PST)
In-Reply-To: <7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41080>

On 3/1/07, Junio C Hamano <junkio@cox.net> wrote:
> Also it would be nice if you guys can fight it out about the
> default value for 'tracked'.  I do not think _I_ can defend the
> position to create these tracking configurations by default to
> old timers (especially the ones that do not follow the git
> mailing list), as I am not convinced (not yet, anyway).

BTW, how about printing a message that the newly created
branch is a tracker of that remote branch?

  $ git branch abc origin/master
  Branch "abc" tracks "remotes/origin/master"
  $ _
