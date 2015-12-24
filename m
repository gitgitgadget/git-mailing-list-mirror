From: Thiago Farina <tfransosi@gmail.com>
Subject: git objects
Date: Thu, 24 Dec 2015 20:17:37 -0200
Message-ID: <CACnwZYfMKG18ZTR3bCLY5FRsBYmSsC9Co2e=iLRYxsM=w=Dqog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 24 23:18:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCED0-0006Cx-Vs
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 23:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbbLXWRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 17:17:38 -0500
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34773 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbbLXWRh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 17:17:37 -0500
Received: by mail-ig0-f196.google.com with SMTP id ik10so313175igb.1
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 14:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kVLsHNgp7orNf7EMbHladOxbO67iaK/NF6+zcSZQMC4=;
        b=0J+DkeaU7kZihXWSRrLdmLP90DSop02mmpMx3dM8tT3Gw6CsHAgq4hxGkCAA00Y0CV
         chC6IgTX/7kjxYTIc07X9Uje0rfO3A1C23kUO9FtZKgQNBXVG4sks2vKsrog17E7PxFp
         76FUVjuHMV/G48UtvoaJmVSD/lu2i+Xb6DM5mQCVCR7OjGTwqsoXrhnr/HMv9jhmeuim
         AJlFig9gw9JxLBcznFeBWV8CiwKvCUAk2K79MfzOsEBR+kQDP8svR6ws0DnLwuNNUILN
         8qO3vh+YNfrpKD3/OCKEAEEBQoR1LS8X7NYinU3S1xrv4ki0x+XpwEILXaHp3belZtHf
         84Zw==
X-Received: by 10.50.57.38 with SMTP id f6mr34589197igq.97.1450995457190; Thu,
 24 Dec 2015 14:17:37 -0800 (PST)
Received: by 10.79.115.134 with HTTP; Thu, 24 Dec 2015 14:17:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282985>

Hi,

When ever I make a commit (assume I'm changing a single file) and do a
'git push origin master', git says 'Counting objects: 6, done.'

Does git makes 6 objects everytime? What are those objects?

-- 
Thiago Farina
