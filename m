From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 16:45:30 +0200
Message-ID: <81b0412b0703290745n63eca3acn3b8dd271194c20fe@mail.gmail.com>
References: <20070329075010.GA3493@hermes>
	 <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
	 <20070329125803.GA16739@hermes>
	 <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
	 <20070329141230.GB16739@hermes>
	 <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 16:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWvsd-00021x-PA
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 16:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbXC2Opc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 10:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753757AbXC2Opc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 10:45:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:22800 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbXC2Opb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 10:45:31 -0400
Received: by wr-out-0506.google.com with SMTP id 76so248572wra
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 07:45:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IQ7LkAoeWBrkNH1zSa/zOW05Ove4bD91jrC76X/IpW7GQxiNi2TG5eyCWESEFZ5ttO2a/rCrUYnUhSf0b78/8CXAYim9dc8xz/TXZ+NFS72/yPjUYGXWmGra0E64QGAzTAIx1r0sI8ljBQZblyRvpljvYdQUCdOROvWjRBf83dE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GKWC1vYz8lunJK20tBd8xSliFBJjl02QDJ+cLnBSSbohuZQoLTzMu7jtbETJQK66Nbl3HSJIekmcVMw8K8GFRvysQy6IvetwP+FZUGAboQluazSvOwEn1m6tK6FDN0SsQpilUY0T1hojWfLC3gZKfjVTSpTavaopGqZXR7tn/CM=
Received: by 10.100.7.18 with SMTP id 18mr442139ang.1175179530744;
        Thu, 29 Mar 2007 07:45:30 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 29 Mar 2007 07:45:30 -0700 (PDT)
In-Reply-To: <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43438>

On 3/29/07, Alex Riesen <raa.lkml@gmail.com> wrote:
>
> Rename conflict... Will see, if I can reproduce it without your repo.
> In the mean time, how about
>

Yes, how about -O0 -ggdb stack trace?
