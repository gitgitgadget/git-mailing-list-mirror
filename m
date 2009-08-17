From: Joe D'Abbraccio <dajoe13@gmail.com>
Subject: How-to checkin git hook
Date: Mon, 17 Aug 2009 16:15:25 -0400
Message-ID: <4A89BA5D.1000608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 22:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8cD-0005L9-4J
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbZHQUP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 16:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbZHQUP2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:15:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:4661 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZHQUP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 16:15:28 -0400
Received: by wf-out-1314.google.com with SMTP id 26so859985wfd.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=5ahCKhBxL3dvKw6cjvCi09tYhQiU69sApMW/bsZyk8k=;
        b=VxgzSS0MhklCXF8OTG15cRNh1mcEEAG/iIOYpZHvpaszkGFzdcg6FPzviZWZlZdlCX
         Z9xFO95d3M1rvHvGXtmGLozLXeIdVcoc7NEtfWm3gy6RIYXb2VLX+mISt1wgDV3/XH1n
         h4paUkakEv5EhwSGPAKnQ12PTV5MODACGTIPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=fBRNnWDwhYeHZFF6djlT86DFNZaijXaddx/YFINOgsr6IMG/WjSREMKy3unCsYoAzp
         5KIAzTRnvdyEhbZuK/yQXfIozo9l666y/rVo11zWRHRB06Ja4EnPHUZh7e6R0+UDFNve
         n8D8dLERbeT+6qVZOSEqYEaV3mv4ApkiAQrgw=
Received: by 10.143.131.3 with SMTP id i3mr750067wfn.19.1250540129672;
        Mon, 17 Aug 2009 13:15:29 -0700 (PDT)
Received: from ?192.168.1.153? (CPE0004e29484b9-CM00111ae69cb4.cpe.net.cable.rogers.com [174.112.146.49])
        by mx.google.com with ESMTPS id 30sm14248617wff.9.2009.08.17.13.15.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 13:15:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126270>

I have not been able to find out how to commit and push a hook to my git 
server archive for everyone's benefit. The githooks man page does not 
describe this and I have not turned up any fruitful google searches on 
the topic.

I am trying to add a post-checkout hook. I also noticed that the 
post-checkout sample does not exist when I init a new archive. Is this a 
bug?  I am running git version 1.6.0.2.


Regards,
Joe
