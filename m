From: Nick Dimov <dimovnike@gmail.com>
Subject: pre-commit hook question
Date: Sat, 14 Jun 2014 20:34:14 +0300
Message-ID: <539C8796.3070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 19:34:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvrqQ-0004EW-Pg
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 19:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbaFNReT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2014 13:34:19 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38568 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbaFNReS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2014 13:34:18 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so2258617wib.1
        for <git@vger.kernel.org>; Sat, 14 Jun 2014 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=SsntuHa/YliLqGEsvBgow+lX1xE76/LdxVg/iW9mLMM=;
        b=E1iTrOxSFJ2HWkp1nsFi+rJLGDr1jIuQM4SrwDF53dfi1VHdtNZss+iM+PgdWu/QuY
         Pbhn57+EAAlZS9NclBtlUmV4vSkzaxIo+pIv+axGe/SI9j1bAzGo5/FztFtHGOg70ghh
         WnUnfFze3juWfVyxE16MtoiZU3wyQLRwekgBVyaTmOIoqF8hoAGE5LMLoxX1zNmgMzXH
         ClxtN5NsUupylH31q+zVPeOL7sgjenPxQcIujpkIQXfd5PZ3SelDStssYmyKWQKMcyS3
         ZIOq8CViv5389rF0CuusIGPd8z2cqFbWzqA2d2q0ZrV9zY1S8ytTZO7OwDoP2XZ0rw6e
         o3kw==
X-Received: by 10.194.23.135 with SMTP id m7mr14167033wjf.2.1402767257086;
        Sat, 14 Jun 2014 10:34:17 -0700 (PDT)
Received: from [192.168.0.234] (5-14-210-247.residential.rdsnet.ro. [5.14.210.247])
        by mx.google.com with ESMTPSA id i4sm20555707eeg.28.2014.06.14.10.34.15
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Jun 2014 10:34:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251659>

Hello everyone.
Im struggling for a couple of hours to make git store metadata of the
files using metastore and I use hooks/pre-commit for this. The problem
is that the script is invoked correctly, and modifies the file
"metadata" but the file itself is not added into commit. I tried calling
"git add metadata" and "git add -u metadata" but there is no effect. The
file ends up uncommited and marked as modified or staged BUT not
commited, ever.

Is there any way to make this work?
Basically, I want it to update and commit the file "metadata" on each
commit.
(then i want to make the same on checkout, but first i need to make
storing work correctly)

Thanks!

P.S. If you are wondering why I need this, the answer is I store OS
files for an embedded device which needs permisions/suid flags etc.
