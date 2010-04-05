From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Mysterious junk in file.... "not commited yet"
Date: Mon, 5 Apr 2010 19:13:46 +0100
Message-ID: <i2v26ae428a1004051113q68a0cf13o65fbf1349f941648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 05 20:13:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyqo5-0007fw-RH
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0DESNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 14:13:49 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:46260 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab0DESNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:13:48 -0400
Received: by fxm27 with SMTP id 27so1222091fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:received:message-id:subject:from:to
         :content-type;
        bh=CJBHJF17JXJvEWZgLKTZZhOCnjps/MRv120roPTPTb0=;
        b=v5w1HruvzXIZxqaDW8VW0J9vGawvb1RX1zGDxryzs49o2uG0rfvn3NV8vS32ZEKOy/
         7qNCJ/4fxhmSs6pdfvkAss40fvP2n1dKqOA/eMSSUsYgq1GyD20yQAbA3PlAXThk7idH
         IL5fyS7BocJuTqQhFkndDNvphNTd9bVTpHo5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=ejhB7XumQZmSxP35brFRBopJmT3D/KM56T/7xc+ECNkK6muJBZLFKx3HjfyoLhbadJ
         4RfQindWceCBGJddDKw3kA5NLqUKCFnO2EJQZtpK0IQQ1Pb7iMWkjTnwHw/79wORSDfO
         B7iWGc9cOJQYszTiikocEH2iueBmWX1pum13E=
Received: by 10.239.160.143 with HTTP; Mon, 5 Apr 2010 11:13:46 -0700 (PDT)
X-Google-Sender-Auth: c63e3ceec3111b34
Received: by 10.239.167.203 with SMTP id h11mr546836hbe.53.1270491226773; Mon, 
	05 Apr 2010 11:13:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143998>

Hi,

I just found a file in my project that has "junk" at the beginning
(looks like some binary stuff at the start of a php file). Git status
and diff show nothing unusual (nothing to commit). Git log shows
nothing I wouldn't expect and show 'shows' show noting. Git blame on
the other shows the offending line as 'not commited yet'. I tried
doing 'git checkout <filename>' but it didn't fix it.

What am I missing? Has git broken somewhere?

Thanks,

Howard
