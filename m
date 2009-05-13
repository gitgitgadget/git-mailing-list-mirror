From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: rebase edit handling
Date: Wed, 13 May 2009 16:51:33 +1000
Message-ID: <fcaeb9bf0905122351y3a1235e8s5cc9b83c225ca9c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 13 08:52:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M48Jw-0005lV-4w
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 08:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439AbZEMGvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 02:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757669AbZEMGvy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 02:51:54 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:29858 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757600AbZEMGvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 02:51:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so555112and.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=/ydQ1wsqqkScYP/Z9zvaGOeuMD9EzIV/LMVv0eupoes=;
        b=n4Z8hbI5NDjUqmkB4uDLzYfoYQ2RoCmNz+K1YcPnQp0s84XKfbFwoU4JcTFHzrA6K2
         sqqRbNfa25Gt65sC7dcoU+8OW7IFe8JvzjU9EvqlTsOHGwYwn7hY7rRF0WYVLJTzaU7t
         VzkjAJReTcjxjzLik4VmNg3tBvRd+wuAa8JbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=a1KwUPIdT7+52VxZDMfXeSmnFBYZ2TwB5X19D5wn8P6xT4+W2Hm+FsHTjCJbzhaVHz
         znj8CekMYDNGfjHThq3DX/4lyjqybAkimhsD3GCImuU8Bb/Gi/82aYJaV4xl9f0LjKqb
         Pk8HBVEaGkVNWb/UPV0S4SHf6qMO4sNi1GlDI=
Received: by 10.100.141.10 with SMTP id o10mr364253and.152.1242197513298; Tue, 
	12 May 2009 23:51:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118990>

Hi,

Could we unit the way to squash/edit commits in rebase? If I squash a
commit it, I need to to update the index and continue rebase. If I
edit a commit, I need to amend that commit. The problem is when I have
a few edits/squashes in the same rebase, I easily get confused and do
"commit --amend" on squash too.
-- 
Duy
