From: Ittay Dror <ittay.dror@gmail.com>
Subject: git commit -p? --loop?
Date: Wed, 03 Sep 2008 11:18:01 +0300
Message-ID: <48BE4839.8080305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 10:19:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KanaF-0004MT-E4
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 10:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbYICISS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 04:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYICISS
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 04:18:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:13847 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbYICISR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:18:17 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1818705ugf.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=44I2CdKJM+W/ePeLelY0z4ftRoVU24xCHFEdtHa4ShI=;
        b=sTtmNYyrkE9l0yUafqA8l5KsLTpplSg8+3L8j/7uJGx2oOpk8Eek09ueIrQOI7P5FZ
         ZpKJs/OE2k8KIplwEJ6CA8fxflQZqUnacHUPFv7xYy3urFcjNBcVTx+xBzxLtgIIX9zQ
         gJspf7L9bKyCmqG3qOFXR9nJ68v605WTdOWAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=SX4+gMkm4veBjlzfqVok6bHXXBOScUo73LGrhiw1TXASIczUqV4FP2xvwa52tlepPt
         Dm3zzSnTSFEXp5pal+qURHlUaZdZSpHx+M2i7Pji9DWXBQs2UyxpdCpc+7YRvm2iQq1v
         4pL+oK20VMslOMYnuv8Zj0/6MaFYYZZFGJOp4=
Received: by 10.67.93.16 with SMTP id v16mr4922584ugl.1.1220429895286;
        Wed, 03 Sep 2008 01:18:15 -0700 (PDT)
Received: from ?10.10.2.7? ( [212.143.191.180])
        by mx.google.com with ESMTPS id a1sm23054827ugf.29.2008.09.03.01.18.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 01:18:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94760>

Hi,

I find that many times I make changes to some files that should be part 
of different commits. What I do then is run 'git add -p' and 'git 
commit' several times until I commit all hunks. Does it make sense to 
anyone to add -p option following a '-a' and '--loop' option (that will 
run until user requests to end or nothing to commit)?

Thanks,
Ittay

-- 
--
Ittay Dror <ittay.dror@gmail.com>
