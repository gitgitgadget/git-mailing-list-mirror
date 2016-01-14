From: pedro rijo <pedrorijo91@gmail.com>
Subject: Find main branch
Date: Thu, 14 Jan 2016 18:17:48 +0000
Message-ID: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 19:18:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJmTh-0004Yk-W4
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbcANSSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:18:30 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35142 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299AbcANSS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:18:29 -0500
Received: by mail-lf0-f53.google.com with SMTP id c192so268364926lfe.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 10:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Wwtec+7wj6SvNftHlvXLu5DW88V+EJFXOntpqL50KyM=;
        b=oh03P4rS/PyE5HSSXU6nLONvD2x+RzAZ3uD5xi3GbHdOyhlqMo3fw/WCCN4kc2S2fm
         cInsuIl/ODMLEGrZtMfLi1fIGYFawaSOOtv6P5WosvyIMAXDBYnS4LRzruezjNE20Au5
         IhzxD5QmiX/D3iWo+0HO7NL70r7fbCWA5WJ7UUTEyJuHIVj2UrSqkYL6nzA2v4LCIpBr
         qJ/qihC9kqDa0adyXU10dmwIgOLxPBgqX1MiyXu2dmR5pHnpSNwWmPWL7zoseiPyydYI
         UUZ3wI+6XEHgb91EGG43Dv6CisJEUC6oaTaUpdx+jXqwhx5lX00y+LSM67C/rZlLEkqg
         pDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Wwtec+7wj6SvNftHlvXLu5DW88V+EJFXOntpqL50KyM=;
        b=BStbPCzVFU8fuej0c6LPtpqKGrgc9Lsk9T6pW0Mr41d03dAgS92rtT6aUUjQ9lPekD
         tDdOusG6Dv3Pxt3GETF/IwGC0QNhM/i/agZcP3jH3CYFePgd5YvhrL5SoGX0A89u4P4Z
         lHEonE1TJLaSz/BBpfPHfKO1tpTKyoT1lrTj9oxtwjPc8zOEzFb2VFrjH+8AgCIymxUH
         SZZx4lKWRBAAy5IZ+/ptfgMbO3u/tg0d/vMm1VJqS3R2Px3d3wAIOc0ogsXRuuJFT5x1
         sddRTinQCjHc+0Qmh51vKLI2L+SvtnCMyDDoQH3Ty48JX6A1G5C8F/h1yI5urxA4aFe8
         pLsQ==
X-Gm-Message-State: AG10YOSmz86ZSewG4YTJEMXtZv+lVzfc2b4rUZzXyaEfYGz0WSY16NqKEEo/VJK39qg1W0u9D8pUO6heiZMVlg==
X-Received: by 10.25.170.203 with SMTP id t194mr829334lfe.48.1452795508505;
 Thu, 14 Jan 2016 10:18:28 -0800 (PST)
Received: by 10.112.167.2 with HTTP; Thu, 14 Jan 2016 10:17:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284075>

Hey,

If I clone a repo, the repo will be on a specific branch, the 'main'
(typically 'master') branch.

Is there any direct command to find that main branch, since that
information is present?

If so, is there any way to find it without actually cloning the repo
(similar to git ls-remote)?

-- 
Thanks,

Pedro Rijo
