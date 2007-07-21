From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] builtin-tag.c: Fix two memory leaks and minor notation
 changes.
Date: Sat, 21 Jul 2007 14:18:18 +0200
Message-ID: <46A1F98A.5040609@gmail.com>
References: <46A1F858.7080405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 14:18:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICDul-00047Q-11
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 14:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762420AbXGUMSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jul 2007 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762473AbXGUMSY
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 08:18:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:36878 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762347AbXGUMSX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 08:18:23 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1779851mue
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 05:18:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VdvhnO4Uy7qrcHAr+bK9tk6m8XPLOMNPMYlhHYZpA/fzZLdsQdIAz6SEHu399IHls7Q4ekVIyN5PiDVoMgZiXYgDEsSVaBxWAveBprbGV0JAiC/xWES1zE8eo9s60tthzFKCpFd3uZGpINiQp2zXFmJmn4GrSVS9b13q+JPDrBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fO/b3WzxXTbyXmeFmRwjzDetHX/+3uY5jgdl64QdF4Zib3yf1XF8jeGfO0s1UasD71YZlFt/9ZGwB/wadjehjR+I0GyckSeRbucGQ5ZjPyQwxT4DFmE/Tzu4ojWPhrKJDsYsJqCoijAvyvp1PNxCC9764D/+ltVfl7uupualKe8=
Received: by 10.82.116.15 with SMTP id o15mr1127459buc.1185020301533;
        Sat, 21 Jul 2007 05:18:21 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id h6sm10998017nfh.2007.07.21.05.18.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Jul 2007 05:18:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
In-Reply-To: <46A1F858.7080405@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53159>

Carlos Rica escribi=C3=B3:
>   Those were commented in the responses to my previous patch:
>   http://article.gmane.org/gmane.comp.version-control.git/53138

A little error here when copying the link, the thread is:
http://thread.gmane.org/gmane.comp.version-control.git/53036
