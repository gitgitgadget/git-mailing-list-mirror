From: Daniel Cheng <j16sdiz+freenet@gmail.com>
Subject: Re: [JGIT PATCH 3/5] Test case for pack index CRC32 when written
 by PackWriter
Date: Thu, 26 Mar 2009 23:35:20 +0800
Message-ID: <49CBA0B8.7070908@gmail.com>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org> <1238030515-31768-2-git-send-email-spearce@spearce.org> <1238030515-31768-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 16:37:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmrdp-0001BR-Dt
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZCZPfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 11:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbZCZPfm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:35:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:19136 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbZCZPfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 11:35:41 -0400
Received: by wa-out-1112.google.com with SMTP id j5so385523wah.21
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=tz7nA/eb4zrjeyJ/Yihw4busqVTXKza9G0s0/G1V8EA=;
        b=hMCZkZQFqADMHKoVYkU7MP/knYGfiLrAEnetP51wS4fjN1vqf9eGBknqFXBAgHQ0Qx
         6Mt8is/yd94ixO2FN0X16y5I00Q1Sf/odVy7nQByvKqZIXZo7TGq2M5XeYMzyr13hXdW
         6AsuF6INxee+CIjDgaDpxliCwbi8u+cczyIDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lNStKM8lnZaNCZcRsITC7bGjrAE5E4LreZ2yi8E4AMhELrCxEqU/UI2Pmt8700Uohw
         +7OEHmVhVqysnlWdUfSw1JpR5q+IPYzSD8x4wuCsdXTQcuOD0kcX5zC/NegbJ2Nh7rTm
         fKKU36x+DGU2JeDNrs6GxXehmuQU14byjjGAs=
Received: by 10.114.74.18 with SMTP id w18mr654234waa.205.1238081739553;
        Thu, 26 Mar 2009 08:35:39 -0700 (PDT)
Received: from ?192.168.0.100? ([116.49.49.110])
        by mx.google.com with ESMTPS id j31sm295703waf.61.2009.03.26.08.35.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Mar 2009 08:35:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1238030515-31768-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114791>

Shawn O. Pearce wrote:
> Suggested-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   33 ++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 

Thanks.
