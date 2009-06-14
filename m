From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: fuggedabadit
Date: Sun, 14 Jun 2009 10:25:31 +0200
Message-ID: <fabb9a1e0906140125v17e056c0o4bab3d7e8aead6ab@mail.gmail.com>
References: <S1750942AbZFNEso/20090614044844Z+270@vger.kernel.org> 
	<4A3481CD.7050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Phlip <phlip2005@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:26:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFl3A-0006yZ-Gg
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 10:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbZFNIZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 04:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZFNIZy
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 04:25:54 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:61458 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbZFNIZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 04:25:51 -0400
Received: by ewy6 with SMTP id 6so4153830ewy.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jn2sytuEF5GV5EbWe2999zaegF3HzL75t/7WRCTcwC4=;
        b=xPgDA6qIFIUNbh6Ze+tl7oC11rg1PHdL6aRoaxO7QeJQ+IZEDGEEKklbxjgQvBcEl/
         xmy+YMzXmKWNtlELXblniyjnfL104M2YcRdws2ViUEjumxKUKq/OSa/dPs6fm1BgR2Qp
         0ck6UfKgveSdsFYW85WvrlKNToTRCwXCCwGBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nxBp3YUJSCUkoBOsbA0SKi2GT4QOdbsw8BVMPa4isydIMxOsSwDg6yLEGZlol0csi+
         1GHkTNtw4Ny9Wrb5e2zQj3jCLsj+0/WSVQqu23oWaneO5B4DRuG6XZOfBrUxLrhrqFLN
         fr3F7ctXAWnkUa0iD3HO+VNQR5+K3bBo//xLg=
Received: by 10.216.53.199 with SMTP id g49mr1935644wec.49.1244967951106; Sun, 
	14 Jun 2009 01:25:51 -0700 (PDT)
In-Reply-To: <4A3481CD.7050602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121543>

Heya,

On Sun, Jun 14, 2009 at 06:51, Phlip<phlip2005@gmail.com> wrote:
> How do I tell git to forget about a file, but leave on my hard drive?

Do you want to simply 'git rm --cached && git commit -m "remove file"'
 to create a commit that removes it, or do you want to remove the file
from your repo's history too? If the latter is the case, you should
look into 'git filter-branch'.

-- 
Cheers,

Sverre Rabbelier
