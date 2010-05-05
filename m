From: mat <matthieu.stigler@gmail.com>
Subject: What should be the CRLF policy when win + Linux?
Date: Wed, 05 May 2010 15:31:07 +0530
Message-ID: <4BE141E3.2060904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 12:01:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9bPu-0004RF-B6
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 12:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934120Ab0EEKBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 06:01:17 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45103 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398Ab0EEKBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 06:01:16 -0400
Received: by pxi5 with SMTP id 5so1395733pxi.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=L2+EkQXs1ITz2NUXqzZ7lO41GS+HerylCA/cnPAt26o=;
        b=SzpJp69E4Ecxf4rTsHT0RC+ZwpFuLZrhhZA31VI88YW/+C5ZRTnmjzPUWHRJpRyCam
         BRjj6HWNg8h4ioX4Jrib2mkTvUlEvZnOijFI+8L4Ik+CrhvfAyG9CpbhgwMG9glb6m6f
         6TeBMQixl6tTVpuf4bAYLx7jPYePYTMHC71kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=nNK0r/E6YBKv4sjFfLQukVjOeY/24Zjf8Wi4jwTMLam6VhSelzmtx0Dl1NLB9GB9Av
         VLcwSVoE1yy0s2nHnl6xymRKTR+e6Uydd6jBkcXaQrDVg+EN8p+HHgOELM0j+dZbaeak
         WShuQOIumOI8+0HIJtNGjSGyX/SgvC4cCCBpY=
Received: by 10.114.162.25 with SMTP id k25mr2419003wae.163.1273053675111;
        Wed, 05 May 2010 03:01:15 -0700 (PDT)
Received: from [192.100.100.40] ([115.119.21.68])
        by mx.google.com with ESMTPS id d20sm33722403waa.15.2010.05.05.03.01.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 03:01:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146386>

Hi

I have two git projects:
-one (A) with linux people only
-one (B) with someone using windows

As we had "end of line" problems with the person using windows (B), I used:

git config --global core.autocrlf true

Following advices from:
http://help.github.com/dealing-with-lineendings/

So everything now if fine with project B, but now some problems using 
project (A): I wanted to copy the whole project file to another dir, and 
now it is complaining about the change, signaling warning:

CRLF will be replaced by LF in .../A.

So I don't know exactly what I should do...Should I change all the CRLF 
from project A, but people will have also problems, or can I switch the 
config, once I'm using project A and B? It is not so clear in my mind 
and I would appreciate any advice!!

Thanks a lot

Matthieu Stigler
