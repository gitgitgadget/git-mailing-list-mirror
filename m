From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix potentially dangerous uses of mkpath and git_path
Date: Mon, 27 Oct 2008 09:30:20 +0100
Message-ID: <81b0412b0810270130w6cbfc17dy444f962666cc6c9a@mail.gmail.com>
References: <20081026215913.GA18594@blimp.localdomain>
	 <20081026220852.GC18594@blimp.localdomain>
	 <490568F5.9060206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 09:31:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuNVk-0005hw-09
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 09:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbYJ0IaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 04:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYJ0IaX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 04:30:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:57967 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYJ0IaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 04:30:22 -0400
Received: by wr-out-0506.google.com with SMTP id 69so502984wri.5
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 01:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SHeSmPFLRewFEKd0/IN1mIX/liF7MiQC7nS6re3eT8U=;
        b=slRpUA+FFlE+hUP5btZ3mJxVTALrd+R1h27etqtmEGdMWYWZNZW0pXlaXv5Fq+zy9x
         k+KY6TvoKCtPGaw/lL9MiaKBCVyKgN+0rD/aqXFbsVKu002T73us7Ya6GUFi8vr592Ao
         WAozlM7joZPzckd68USZckDm1NPpldsR5Lu0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qVNjlSRPRcUzv8hPqiSztMSAhhajOP8tyqOuJ1fL6mcLGTCzC1mp2GM13amPlHbeHj
         kiQG9Q1qgYvBIM49z3EP5pwGyBPhzVqcClfWzBISLQH6coPCiYK8ggZNf/Ti6BSADynN
         5lwTYZ7eR/JF63m0QyXPRwTrFZ2Rp3nvHuQCQ=
Received: by 10.100.213.5 with SMTP id l5mr5593163ang.114.1225096221034;
        Mon, 27 Oct 2008 01:30:21 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Mon, 27 Oct 2008 01:30:20 -0700 (PDT)
In-Reply-To: <490568F5.9060206@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99216>

2008/10/27 Johannes Sixt <j.sixt@viscovery.net>:
> Alex Riesen schrieb:
>> Replace them  with mksnpath/git_snpath and a local buffer
>> for the resulting string.
>
> You should describe your definition of "potentially dangerous" to save the
> reader some time.
>

Yeah. Thought it was obvious. Will do.
