From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Tue, 1 May 2007 09:26:33 +0100
Message-ID: <200705010926.35265.andyparkins@gmail.com>
References: <463678B7.70409@gmail.com> <7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 10:26:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HinhB-0000uz-6S
	for gcvg-git@gmane.org; Tue, 01 May 2007 10:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031131AbXEAI0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 04:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031032AbXEAI0p
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 04:26:45 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:13497 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031131AbXEAI0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 04:26:43 -0400
Received: by ik-out-1112.google.com with SMTP id b35so290824ika
        for <git@vger.kernel.org>; Tue, 01 May 2007 01:26:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=imu5wpm5pyPWX+DNsOVKrUmPVQfTSxPn6SN6YsUMSPyv2wV2/X467LH/kEX+msGIRrfMZlcaVEllqrcWJeXtIPoDySkvK5gdReyCVyCgXEaEnVAeao2nRXAL2wtGP2IrtOCKUmW987ryllHcjJL7X4u6293KcweH6nPQH/7dkPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Buc6buvVgst1Z1p5Fgf6c+5bW63e7MdRUpUPiDyvVndcIfDeeB489pRF9d9HzVjdG8hGOPtUovW3F/zfiU8b077E+MuntB0F8qr22S9YDdoTIzy3BMQ7z4XtTr40vULvpmY+Z1NRmplSA4TECpYNEL7U+OeheM9yez6DlfRKWr8=
Received: by 10.82.187.16 with SMTP id k16mr13667202buf.1178008001225;
        Tue, 01 May 2007 01:26:41 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm2885143ika.2007.05.01.01.26.39;
        Tue, 01 May 2007 01:26:39 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45927>

On Tuesday 2007 May 01, Junio C Hamano wrote:

> Which leaves 'master' right now at v1.5.2-rc1 while 'next' at
> v1.5.2-rc1-687-gcb3892c; we might want to do something about
> this apparent discrepancy.

It's perfect - I'd say that it's exactly right.

git-describe is for making unique - human readable names for points in 
history, not for describing the tree.  It makes no difference that A and B 
have the same tree, they are different points.

I've always thought of git-describe as being a way of mapping a commit hash to 
a nicer looking name.  If A and B are different commits then they should have 
different names.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
