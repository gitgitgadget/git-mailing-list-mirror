From: Luke Lu <git@vicaya.com>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 11:36:46 -0700
Message-ID: <51ED164C-2269-48B7-B8C9-0E819BFD63EC@vicaya.com>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:37:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZsJ8-0003Db-5q
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbYCMSg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbYCMSg6
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:36:58 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:50515 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbYCMSg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:36:58 -0400
Received: by gv-out-0910.google.com with SMTP id s4so789123gve.37
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=uwjsDsEMvR+Zj7CINf9MNS+ZUq2SGddhhEnEDNUXYnQ=;
        b=HxwcPtQ54axQzzJ45GcwkdWH2ZVUBJuA+D/7HKAWHwNt+KVBsHBRGvmECxcrLL191DDEUTl50QA6FpXifb12Kft8yT/Cr9hSm5awjc0CY3VEVhXFQQiNP+noEhsDgquhUMXvF6EkbnAfC8jtE+jW1B57haDxC2zRHT85wVb8qWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=ue7bcfvhmbnsDHsqjNwIY24XZkoZXGwBR/AVdOgzAgtafUrn0CKei7CFNCpoARqegdHvN+svOKSAq/knGIYWveVB9WXU5l80znFgr//kO/U0noN5hejioxxf/ykM7LKW3Zf7q2rN/TBucC3xaYYfNyjUR4gA+gsQYgqOCvWzn+k=
Received: by 10.150.201.13 with SMTP id y13mr5634385ybf.31.1205433413102;
        Thu, 13 Mar 2008 11:36:53 -0700 (PDT)
Received: from ?192.168.7.10? ( [69.181.4.225])
        by mx.google.com with ESMTPS id 17sm2950365hsq.12.2008.03.13.11.36.51
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Mar 2008 11:36:52 -0700 (PDT)
In-Reply-To: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77125>


On Mar 13, 2008, at 1:48 AM, Alexander Gladysh wrote:
> Hi, list!
>
> I want to create a private GIT repo (without working copy) on a
> machine in external data-center. While I do not actually believe that
> it is possible that someone who has physical access to a machine would
> be interested in peeking into my repo, I'd like to play safe and to
> have this issue covered.
>
> Please advise what is the best way to do it. Are there any existing  
> solutions?

An obvious and easy solution: use an encrypted partition on the  
remote server and ssh as transport. Last time I checked, git on  
encrypted volumes is plenty fast.

__Luke
