From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Can not 'git add file'
Date: Sun, 03 Jan 2016 17:20:02 +0100
Message-ID: <1451838002.3109.2.camel@kaarsemaker.net>
References: <1500251451832791@web17m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: KES <kes-kes@yandex.ua>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 03 17:20:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFlO8-0005HX-52
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jan 2016 17:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbcACQUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2016 11:20:08 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33401 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbcACQUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2016 11:20:05 -0500
Received: by mail-wm0-f42.google.com with SMTP id f206so149376169wmf.0
        for <git@vger.kernel.org>; Sun, 03 Jan 2016 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=Q36Sgc3yCTt2hyQZB+b4auFHpmChNjl/vi1B6wBnQuk=;
        b=yg3L2c+NtY4NSKfSuQFY/WvMNyRWqZ50reTVhg7uyuwen2PBs9oXgPIEzOsLeXpuHs
         B/KbOYiGrZnCtjDTs8CXce1guoFVAYaHL+2EGHO1ODwaAO4oCQgi1fWXbgXA5tFqPmEJ
         FlvWkhfXVPL89dJsKagyDgyQmup/3EoxSJxZV9HXlBuGyhVMm4uidc9v/JDU8K3voDtQ
         IBj6GLr4T2a7luB+8yAUMtyj20kAuZFQ/tI/29zaJjTJJmhVjF8uX5w7p8Yhj+zCmiUJ
         ypqEe5+X00fCCgcp+MSUX3svlycmNkV2Z6IJCpIkM2IfCJLgJOzunamlxnENfiwpj2Ku
         UICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=Q36Sgc3yCTt2hyQZB+b4auFHpmChNjl/vi1B6wBnQuk=;
        b=W3ywC58ithRmJfIdCzVMObK7+C6gh+WdIGObHrpnmWnkuMhRDy3SqLik9IOz3aeJ4x
         L1CQB8l9BQoZudbQGOfjV8SaLMHFvHImvghCB6BtKZ/E6Zk1922/KqhHdB/hkOFOcT8k
         e2eK6zTXFC8Q7Dh5i9ocopUbN0xsk3mZEgO2PFUM0s9QmZNfRiUFLH4h7HJPty0Oi8Y4
         0yYF7RXxrgKgQXPCwkb3G5eAVBbXBxCyqf7EJO++mNbPf1QMPtao+oy8+2DjHZEG/jBQ
         1RiduEnV1EgvGucQ0BSM6fv+2nkfTfueURM2QEIYtm2rzxVZnF4I/uvhsvvwaezgHRAs
         bwHg==
X-Gm-Message-State: ALoCoQnguqESOKkQFDwRp6tE48e73GTWWO4BmtEgStVDgLXjIM2rqoNGZLA+CuTH1wxKNyOxGFWeGt6tCMHv7eduqDQv0C1MUQ==
X-Received: by 10.194.243.103 with SMTP id wx7mr99587407wjc.136.1451838004148;
        Sun, 03 Jan 2016 08:20:04 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id c26sm53542979wmi.21.2016.01.03.08.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 08:20:03 -0800 (PST)
In-Reply-To: <1500251451832791@web17m.yandex.ru>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283276>

On zo, 2016-01-03 at 16:53 +0200, KES wrote:
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
> 4       ../lib/Devel/DebugHooks/
> 
> $ git add -p ../lib/Devel/DebugHooks/Commands.pm
> No changes.
> 
> I want to start track file here, but I do not want to stage while
> file.
> 
> It seems the git can not process this case and do not allow me to
> complete that.

Correct, add -p for a new file is not supported, as it doesn't really
make sense. There's no patch, it's a whole new file.

What you can do instead is first 

git add -N ../lib/Devel/DebugHooks/Commands.pm

to mark the file as tracked without adding content. Then git add -p
will allow you to add the contents partially.-- 
Dennis Kaarsemaker
www.kaarsemaker.net
