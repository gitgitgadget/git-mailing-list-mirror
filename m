From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage: invalid argument --norc)
Date: Wed, 24 Apr 2013 08:47:18 +0400
Message-ID: <9410348686.20130424084718@gmail.com>
References: <323381594.20130414121834@gmail.com> <673219382.20130414124800@gmail.com> <20130414113351.GA1299@thyrsus.com> <1762779000.20130415215818@gmail.com> <20130418094326.GB11038@thyrsus.com> <214169596.20130420142251@gmail.com> <20130423175000.GA25994@thyrsus.com> <538486753.20130423223007@gmail.com> <20130423210657.GA32382@thyrsus.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 06:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUrdi-0004dN-KH
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 06:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345Ab3DXEsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 00:48:55 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:45480 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3DXEsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 00:48:54 -0400
Received: by mail-lb0-f176.google.com with SMTP id y8so1315137lbh.21
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=peMfm8Oa98rLkQsqhYDD9jQilfKdM+epeMoIh+w5qJ8=;
        b=uSCfTybTcOImVLZC6ZO+NZJc516MlBDQj97TbdDn9wPDJHJBXdAwKJV10hGUQAB22r
         rooVofT4gC+SlWOfps6w69TGHRW6rRVWbsguzVFaapsEFjX3i4hR+24NGRupsxIy+Cxv
         G0KiLzNoTVhRXOiQo+cBJLOYLAckcvD2SN///6sP4ZLAqiZzEYmSzTnChdpVU/QWAZgG
         H5fdZiwLvrIOWdCxrYOKYDZN7CUXkIXCmgVFNo2JP2rQ3vGFNZ3PD/OK6fU7S+HEFOXM
         cNWlCtLfbv3ztrRuXbn3Doq7q6r/BvJijaDw+gt4WDebBNrrHXo1lI/UlueYT6cK4Kzy
         k8mQ==
X-Received: by 10.112.154.233 with SMTP id vr9mr16993192lbb.23.1366778932719;
        Tue, 23 Apr 2013 21:48:52 -0700 (PDT)
Received: from [192.168.0.78] (92-100-236-105.dynamic.avangarddsl.ru. [92.100.236.105])
        by mx.google.com with ESMTPSA id t17sm545792lbd.11.2013.04.23.21.48.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 21:48:51 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20130423210657.GA32382@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222222>

ESR> Ilya Basin <basinilya@gmail.com>:
>> For new branches the 'from' command can refer the common ancestor in
>> an existing branch. For example:
>> 
>>          /----------E thebranch
>>         /
>>     A---B---C---D master
>> 
>> Commit E is newer than D; we already imported D; thebranch is new.
>> Instead of:
>>     from refs/heads/thebranch^0
>> refer the parent as:
>>     from refs/heads/master^2

ESR> Understood.  Do you actually need this much generality in practice, 
ESR> or is it a theoretical case?

Such cases occur quite often.

-- 
