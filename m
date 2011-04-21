From: Qianqian Fang <fangqq@gmail.com>
Subject: slowness in pulling data to mobile devices using git
Date: Thu, 21 Apr 2011 18:56:08 -0400
Message-ID: <4DB0B608.5090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:56:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD2nI-0004xx-IJ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 00:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab1DUW4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 18:56:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53435 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab1DUW4K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 18:56:10 -0400
Received: by vws1 with SMTP id 1so141957vws.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=JYyII4vZhagPMHNXetnC0UyRw2+kDUbrVyQvHvm8PXM=;
        b=CxfHI6LMqz3nwliIG7evRU3NsokQX3Wea8tj35hczoGM1uXre2M37sUHcawsUgKFKp
         ohEz7rkn9FMYwB0F+v3zVJPkusZ0NTNPmJRnLVlE2E7kBF+c5dPI9cHveEnc81HEvB2s
         UUzMwR9QKL7lDxU5pA64ZR8WR5g3vbb07NQu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=LRFbptHATzwirRDtR7oNjLuT8b8ftcFgfb85RetFLxdjM7uBmohIetVPjadDHlo2db
         +R9iid5RDFwmMpZS9CudLWF2I3AWvNzlg26SiiLV9VpgJsEo1ZXqaNFoWpkSKmL91tK1
         GVFppIrPLRE1fnCqPrY4Aj1Qr9W3UATTj6b3w=
Received: by 10.52.74.36 with SMTP id q4mr711681vdv.134.1303426570079;
        Thu, 21 Apr 2011 15:56:10 -0700 (PDT)
Received: from [132.183.136.67] (kwafoo.nmr.mgh.harvard.edu [132.183.136.67])
        by mx.google.com with ESMTPS id u11sm445970vdt.25.2011.04.21.15.56.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 15:56:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171928>

hi list

I am not sure if this is the right place to ask. I am having
some difficulties to speed up synchronization of a large git
repo (~4GB) to a mobile phone via USB cable. It appears that
the "git pull" command has to read through the entire
history to make a single update, even the update is very
minor.

I post my full question at this link:

http://groups.google.com/group/git-users/browse_thread/thread/9f33536257535b28?hl=en

does this make sense? is there a way to speed up
the updating without letting git to do all the file readings?

thanks

Qianqian
