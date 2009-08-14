From: David Reitter <david.reitter@gmail.com>
Subject: Re: git config -> "fatal: bad config file"
Date: Fri, 14 Aug 2009 10:26:07 -0400
Message-ID: <2D345CF1-9534-46F2-B0DF-ADA4EFDB5A51@gmail.com>
References: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com> <4A85724C.5060406@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1074)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 14 16:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbxja-0004PM-En
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 16:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbZHNO0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 10:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbZHNO0N
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 10:26:13 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:40218 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbZHNO0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 10:26:12 -0400
Received: by qyk34 with SMTP id 34so1170012qyk.33
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=uRChob47AbAX2K/ogmEszI/mP/3/GThKv82fwwUICPw=;
        b=WM7rshvffRBsY0ZIT8aZJz/RghW1wVbeN3cJteC26DbJkUQBfj7FCE+hCZeO63QaWZ
         9o1IAnH3yxU6VG7Igy2x/oCXheSGVPCx4ifjirCbXdvKj7cHsoikFB3oUhtcSpgXuuQh
         ZROYb4MQVhChp6O5GxsiTYBdm20kuahDelIQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=F/oBGdTrxOmizWpBW9WiRrcEyeX81j0nTPrOMKHyupIeEknQp+0F90bDiv92BtKYNQ
         lcUcHpOOJCnr6nglXx665PmcLG5IUr1/PQvGDDPvQz1Ac7zqPorWku5jykwusTnbTc64
         dxhj50Pk4E9T/UEMrqmobzawwKfFn++xaAVo4=
Received: by 10.224.5.135 with SMTP id 7mr2326070qav.148.1250259970334;
        Fri, 14 Aug 2009 07:26:10 -0700 (PDT)
Received: from scarlett.psy.cmu.edu (SCARLETT.PSY.CMU.EDU [128.2.249.106])
        by mx.google.com with ESMTPS id 5sm3746558qwg.40.2009.08.14.07.26.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Aug 2009 07:26:09 -0700 (PDT)
In-Reply-To: <4A85724C.5060406@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1074)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125927>

On Aug 14, 2009, at 10:18 AM, Michael J Gruber wrote:

> git needs to read the file because the editor could be configured  
> there!
> The only option would be to make git config -e continue past that  
> error.


Syntax errors in .git/config could lead to warnings. Since the file is  
primarily line-oriented anyways (except for groups), recovery should  
be easy.

Also, you could have git-config -e edit a temporary file, check the  
file for errors after editing and then move it to .git/config.
