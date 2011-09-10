From: Bastien Sevajol <sevajol.bastien@gmail.com>
Subject: .gitignore don't ignore a file
Date: Sat, 10 Sep 2011 12:29:45 +0200
Message-ID: <4E6B3C19.4040908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 12:29:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2Ko7-0003gO-Si
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 12:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759125Ab1IJK27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 06:28:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32993 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759112Ab1IJK26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 06:28:58 -0400
Received: by fxd22 with SMTP id 22so1426020fxd.19
        for <git@vger.kernel.org>; Sat, 10 Sep 2011 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Mi1VZ0+CJtfHjntyuLnB1n1cLVXm4BuPx2cqpvG5ZX0=;
        b=RuRtpG3+bT+fr8OrR+EdkPoXWn+OSCPH+qcitKn/2fpgolKncww/l7jwwX/LwAwzH3
         IdqoeEaJSETwYHtmVkuIDl2jLzDz1Dyk8JvUAISSgXkriELTzAclT/xKJlLIHi9zLKB7
         ZXwqgCwGwTsSP6GeLrJUxvZPTF7pmcIQpfI2M=
Received: by 10.223.48.208 with SMTP id s16mr674116faf.75.1315650537676;
        Sat, 10 Sep 2011 03:28:57 -0700 (PDT)
Received: from [192.168.0.11] (lns-bzn-49f-62-147-167-221.adsl.proxad.net [62.147.167.221])
        by mx.google.com with ESMTPS id c2sm4259714faf.16.2011.09.10.03.28.55
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Sep 2011 03:28:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181151>

Hello !
I don't understand why my gitingnore don't want to ignore a file.
I have this in my gitignore:

> app/cache/
> app/logs/
> app/logs/dev.log
> app/logs/prog.log
> app/logs/test.log
> *.log
> *.*~
> nbproject

i've try with app/logs/.gitignore with this:

> dev.log

But, git don't ignore app/logs/dev.log :/

Do you now why ?
thank's =)

bux.
