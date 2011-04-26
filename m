From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH] Refactor git-completion to allow ZSH usage of PS1 functions
Date: Tue, 26 Apr 2011 12:37:42 -0500
Message-ID: <4DB702E6.5090105@gmail.com>
References: <1303824288-15591-1-git-send-email-mstormo@gmail.com> <7v62q1exnj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:38:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEmDC-0005Om-Dv
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757878Ab1DZRh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:37:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55687 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757862Ab1DZRhz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:37:55 -0400
Received: by gyd10 with SMTP id 10so308763gyd.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=v5b+LjP5zUaNx3nXQ2ovKbV/wKR42W2l8ky3tQF7wag=;
        b=BURBhZtokRD8yH4c9/hMp0Rc+cvxLjVsyGnEmVe3r9TXOSLXowPkRV4+ioxwyFMK3S
         djjWQNwFWJlngVMs3zzpc36oKVz5RMkdEW4rKU1w+dF5gpL34aY46MOqDhA/80EUuCZ7
         NmBF1h75X/OdN7xPKsQ4BO6YKZ5XLOYlNhIEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rKOcyeH6/OCEubjU+Rr+45yLYaSzkjQUxLe6X9LPt0ZdSdNNem70a8QFtrWjCtJ6gQ
         Syj0dmw4pDwAZ+9HnOlRUSonZQ+mRsoWjqERPTGwCdMdk1GU0PoOlOAtm7d7xnczulN1
         atgkWOWanXYOJ2FyZyQk4aGxUrUlTFG0mEo/g=
Received: by 10.236.19.100 with SMTP id m64mr1367184yhm.77.1303839474662;
        Tue, 26 Apr 2011 10:37:54 -0700 (PDT)
Received: from [192.168.1.100] (24-155-176-18.dyn.grandenetworks.net [24.155.176.18])
        by mx.google.com with ESMTPS id t42sm2067839yhm.43.2011.04.26.10.37.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 10:37:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <7v62q1exnj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172116>

Junio C Hamano said the following on 26.04.2011 12:21:
> I'd be very negative on splitting this file into more than one files.

The only other option would be duplication. Is that preferred?

I was hoping to more easily keep the implementations in sync, given 
that the code is trivial enough for both shells to interpret. However, 
having two separate implementations would allow for more advanced 
options in the ZSH PSx handling, I guess.

-- 
.marius
