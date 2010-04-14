From: Steven Michalske <smichalske@gmail.com>
Subject: Re: SVN bridge for multiple SVN modules
Date: Tue, 13 Apr 2010 23:08:05 -0700
Message-ID: <236FD58B-CE33-4C06-A3AC-FD7DA7593EEB@gmail.com>
References: <m2ue3041f5c1004130034h51eb196dke0ebb8b3634e7302@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Richard Dallaway <dallaway@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 08:08:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1vm0-0002N3-JH
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 08:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab0DNGIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 02:08:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43110 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab0DNGIK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 02:08:10 -0400
Received: by gyg13 with SMTP id 13so3948438gyg.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 23:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=rhRPvccnYMHPpB2Gjqp0Ul7436XQXpgbyHvEEELIG0c=;
        b=bpUFHF0SPBL2xwLZ3LH1IsA/7T0x/kLEeVMeyevvEdqpHx7NxBhmLiPUKqWhBbYmGX
         dptSnudFWftrT9CD5jCM8BiLx9QTAD3sMTGEyYyQ7ltUwBLYTeR/OTKxNsjVHe7GQqwS
         sC9ydKlW3hMPoXAOBRLdCCxysDObR11VP1UkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=TaZXXsIix98TYxRf4IuwzC/SoNy91vpV5AnPbSlBg0KsF1wrKATkJF8N77gjiXvDp4
         hJMkuw11nblpHYrerCDOgX0GUGwaXc32Uljdgq53iPMpflBx0ueqVECh4/Rk5KHO+jWz
         AjEOc91gPaQxYbDRFYhWETUnWJiOUnNy9T1cg=
Received: by 10.90.141.20 with SMTP id o20mr3144984agd.97.1271225288861;
        Tue, 13 Apr 2010 23:08:08 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id 7sm1613556yxg.63.2010.04.13.23.08.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 23:08:07 -0700 (PDT)
In-Reply-To: <m2ue3041f5c1004130034h51eb196dke0ebb8b3634e7302@mail.gmail.com>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144851>

On Apr 13, 2010, at 12:34 AM, Richard Dallaway wrote:
> Hello
>
> We've run into something we'd like to do with "git svn clone" that
> looks like it should work, but doesn't appear to.
>
> The task: we have an SVN repository with 38 modules in it (each with
> their own branches, tags, and trunk) and we'd like to pull just two of
> the modules into a single git repository -- but maintain the ability
> to perform git svn rebase/fetch/dcommit as the SVN repository is
> remaining active for some developers.
>
Would setting up two git repositories cloning the SVN from the  
module_a and module_b directories and then making them as a git  
submodules is a git super project repository?
