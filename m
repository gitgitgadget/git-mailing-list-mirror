From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Fix git-rebase -i to allow squashing of fast-forwardable commits
Date: Sat, 14 Jul 2007 08:09:43 +0100
Message-ID: <200707140809.44619.andyparkins@gmail.com>
References: <20070712223035.GB30532@steel.home> <7vejjbmtva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 09:10:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9blw-000892-2i
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 09:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbXGNHKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 03:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbXGNHKD
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 03:10:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:25374 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbXGNHKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 03:10:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so693559ugf
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 00:09:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l1rzF+Ke9+mlOu/mhkWkJ//h04V8RAMd+Rpbav2mmIaLvBPN47OGLFmnemmgIrPq3fVmXnCVVxOlF932o82vtHuTvweFIyKKCVLpvqc+B9JR/yw8XKhSALZDPhFoGvaqxuSOAf+aocRqrriHGjI8WtjxXmIiyshnGnL2IZ3AQ3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KNF7u6fildGTU6q/5+KK7OIqSSxfV2M2H7y7tsgr3SNssmAYGe1q9fNF9mmxZQzWEC23oKefUz3vF9xAcIQNO+HssL8rn3420ITm5CiUt1o1tW9ZlADmLl/hidy7efLGKUZ5TeVwP3Io31PplH23awkQiTPwOZ5APjxvyPTgDgQ=
Received: by 10.67.95.3 with SMTP id x3mr2582765ugl.1184396999638;
        Sat, 14 Jul 2007 00:09:59 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id s7sm535671uge.2007.07.14.00.09.58
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Jul 2007 00:09:58 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7vejjbmtva.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52450>

On Saturday 2007, July 14, Junio C Hamano wrote:
> I think this makes sense.  Thanks for fixing it up.

I was experiencing the problem, and this patch fixed it.


Acked-by: Andy Parkins


-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
