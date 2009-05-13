From: Esko Luontola <esko.luontola@gmail.com>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 13:21:23 +0300
Message-ID: <4A0A9F23.8050804@gmail.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com> <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com> <alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de> <200905130724.44634.robin.rosenberg@dewire.com> <4A0A91CE.3080905@gmail.com> <4A0A9AA2.1000004@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed May 13 12:21:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Bb1-0007Zo-3T
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758749AbZEMKVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 06:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758674AbZEMKVd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:21:33 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:55408 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758135AbZEMKVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 06:21:32 -0400
Received: by ewy24 with SMTP id 24so654499ewy.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=IO6GG8n1iYXHfIZ/dxRam/b9ssIxDI2kblk6FbrI6gg=;
        b=ixbyp+jgVDrCktMx41suIWyUJMfD18fmCwhzlaTzfI88yi9Hxg8L2upBCneacQfTPW
         0SGFqq0w9njhzlo/mZHtRg58d6ak6iUKAdXO6A71fVMlm7vTQTodQpq8VznwKt4y5FHX
         55NMKd84SjdK7bWGydYAtYTgZhfcsv5Pvm7is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=r3/HebjOyQk8prRTquvEdt+4FYTcJ95tKMVi8DIZNsC/kwC2Ntt+SVNyrpIfHb24Yi
         McWwx2t34wQbknUTpafWTB3eRFQJ7uG0grhWuiPXk/07xmxHqpqgPb8BkHeRNTk5t+Lp
         D94B2BLJRciNZDEp81nVlF4u2wxqEet+Fqa1o=
Received: by 10.210.41.1 with SMTP id o1mr560407ebo.59.1242210092288;
        Wed, 13 May 2009 03:21:32 -0700 (PDT)
Received: from ?10.0.0.2? ([88.195.117.100])
        by mx.google.com with ESMTPS id 7sm1252909eyg.47.2009.05.13.03.21.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 03:21:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A0A9AA2.1000004@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119026>

Andreas Ericsson wrote on 13.5.2009 13:02:
> If you're *really* serious about it though, here's how to go about
> it:

Thanks for the pointers. I'll have a look at what the repository format 
is and how to create a migration path.

-- 
Esko Luontola
www.orfjackal.net
