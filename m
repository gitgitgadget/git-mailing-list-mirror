From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 6 Feb 2009 15:29:04 +0100
Message-ID: <2c6b72b30902060629i2539ddds48ab858e83d4bb4@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <20090206104946.GE7259@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 15:30:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRj2-0005kD-IA
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbZBFO3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbZBFO3I
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:29:08 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:49932 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZBFO3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:29:07 -0500
Received: by fxm13 with SMTP id 13so1205860fxm.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=2KwQz41Y3kA+eFQMLui5pXYxCA77nhLOgp1A0foD47g=;
        b=gzNE1PBL6DSHThF/xyzZg0l6G7wEB+ziqLv8ZTMXqTfMvzMJROHtTGgF4x0S6wEw6h
         cYH0E4d/QJ5buY6dTiKzKkgFqZiwJm+zXm6m/5XWiWbZQ6L/HiRIwHABmO1cxpYifjUd
         wj+hWig9h1skPud6/xlZlRf5DXB1gDx3KqEaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=bSsPjbdWUjaP9T9jt1fUBfuWpelUKUJ+PEbHiSgc0NEdZsqxnt5/fF9n1PekgKAIxK
         h3LvINEV/j9wQ8LJFimb9PZg7li5kjiGLuFVfgPc7IqfqHEMXYnEW4quoOpTolA++vpE
         /6RAuhgNjWkjr7YPfXPDwKh3xSf7LY/thYyQo=
Received: by 10.181.28.15 with SMTP id f15mr605495bkj.75.1233930544741; Fri, 
	06 Feb 2009 06:29:04 -0800 (PST)
In-Reply-To: <20090206104946.GE7259@b2j>
X-Google-Sender-Auth: 9b64944b011f05dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108716>

2009/2/6 bill lam <cbill.lam@gmail.com>:
> There is a choice in "git add -i" call patch/hunks.  Is this the same
> as the update/chunks as described in tig manual?

Yes, you can stage individual path hunks (I should probably use the
git terminology) using 'u' in the stage view. Use '@' to navigate to
the next path hunk.

Two things tig does not (yet) support is splitting and editing a hunk.

-- 
Jonas Fonseca
