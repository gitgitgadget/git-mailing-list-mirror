From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Lost uncommitted changes and cogito
Date: Thu, 9 Jun 2005 20:28:25 -0400
Message-ID: <9e4733910506091728761275d7@mail.gmail.com>
References: <9e473391050609122372080863@mail.gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jun 10 02:24:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgXJw-0000LO-En
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 02:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVFJA21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 20:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFJA21
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 20:28:27 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:4375 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262306AbVFJA2Z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 20:28:25 -0400
Received: by wproxy.gmail.com with SMTP id 68so418877wra
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 17:28:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uTDR8nNGWm4GCmy+J6IlZnxFzl2JVDiUQrBwAtmCly1GL9wcdJwS+aH2M6n4jYgGMEq70JN5oZ7CYK2rimJ2PazAkV7Z8CjwdE1FojeOk+PDX6ihxJ/QOm2/pBhXIbAJGVxKWo9f6l5rYyD3E3DGQbxv1S73ZcTxheJdnugUYTc=
Received: by 10.54.124.5 with SMTP id w5mr719188wrc;
        Thu, 09 Jun 2005 17:28:25 -0700 (PDT)
Received: by 10.54.94.8 with HTTP; Thu, 9 Jun 2005 17:28:25 -0700 (PDT)
To: git <git@vger.kernel.org>
In-Reply-To: <9e473391050609122372080863@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After experimenting for a while it looks like any cg update to a
branch that the repository wasn't initially cloned from will lose the
pending uncomitted changes.

-- 
Jon Smirl
jonsmirl@gmail.com
