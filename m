From: Artur Skawina <art.08.09@gmail.com>
Subject: Determining commit reachability
Date: Sun, 05 Sep 2010 22:34:11 +0200
Message-ID: <4C83FEC3.3040101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 05 22:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLv1-0000I0-Bc
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 22:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab0IEUeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 16:34:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38532 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab0IEUeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 16:34:15 -0400
Received: by ewy23 with SMTP id 23so1831980ewy.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=o0qbkqYoGijl8czuqQeurlvORqWqXAoMTjHo5xWTqpw=;
        b=awOrZG3pWyeK2hJDeFnWP74MXiZ9xXX/825qNqdGehhYisb9mCUCWCBQ58b8ol+mui
         4y6q6jmGXv86YsYJnADxUObNaZyquQqfT6Q9ub/r6VF7rQQA6Q75Do5mv4KBLBtMBBR1
         oRkuEcK81RVpN3kuwJrFyK18F2tmOU14TzGUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=Gsy2s8M5N3XdXSzW1bn9DBO7+/FWP9JtCQHq6gl7sYgZpa+JvsIY+qpAUfMhJ4mBli
         sKJLOXN+lwINHoMNTLrWMYB9c88f61k0UHQaXOPAdvUFDNXPOHG9JJjcIGDKPhCIp4hP
         168FpTSFmrhyzAn/AFPhQGx8LLiMti3NQX/2s=
Received: by 10.213.35.72 with SMTP id o8mr824772ebd.80.1283718854354;
        Sun, 05 Sep 2010 13:34:14 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-125-12.multimo.pl [89.174.125.12])
        by mx.google.com with ESMTPS id v8sm6847888eeh.8.2010.09.05.13.34.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 13:34:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155486>

Given commit C, refs (branches) R, S and T what would be the best way
to test whether 'C' is reachable from any of the heads?

Checking if `git rev-list -n1 O ^R ^S ^T` produces any output is what
i came up with; is there a better (ie faster) solution?

artur
