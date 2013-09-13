From: Francis Moreau <francis.moro@gmail.com>
Subject: Removing all notes containing a specific string
Date: Fri, 13 Sep 2013 08:51:50 +0200
Message-ID: <CAC9WiBi4=SVF6SE0hpccPLRdv-n8hcRUg+Pa+BbRWN1YudtXjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 13 08:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKNER-0006Dk-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 08:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247Ab3IMGvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 02:51:51 -0400
Received: from mail-vb0-f49.google.com ([209.85.212.49]:39401 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3IMGvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 02:51:51 -0400
Received: by mail-vb0-f49.google.com with SMTP id w16so618505vbb.22
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 23:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1a8qOL4+qRiZ0UGTs51uugzrixaqay9o7r5jG45LyTs=;
        b=gDyBiKritdnjHkpcuOOHxC0cQue+vpVkNNOqnJUZg/VpocbYJJkwHTUMzLLeMSCDiW
         IfaskQbqFmiIE3AiHkD3sks03v0FZhuZN07gawqE3x9/XueKG09iD1JnPCAhxJ86DaIm
         vLAYdRBFdZJ6fp/owJLqpzUSWAdv95b5/Mv0srvD0oQtyzc68CuBhCsCB4aCTR3huUwp
         W+iy7eUxDd1I1vS7oekDWNq73Qc+7P5b6oo2acgAZvYxP8XccK9fljK56ejBsVRvurh9
         u9JyaYVF030RZli7XmkvDBbrBIcMJ/ajjMkhusY6Zq6QHhKsZIOIxaDv1BmtXhdRID7e
         9/Rw==
X-Received: by 10.52.164.102 with SMTP id yp6mr9133070vdb.14.1379055110416;
 Thu, 12 Sep 2013 23:51:50 -0700 (PDT)
Received: by 10.58.96.109 with HTTP; Thu, 12 Sep 2013 23:51:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234734>

Hello,

I'd like to know if that's possible to parse all notes to detect a
special string and if it's the case, remove the note like "git-notes
remove" would do.

Thanks
-- 
Francis
