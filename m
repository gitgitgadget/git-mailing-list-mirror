From: "Patrick Aljord" <patcito@gmail.com>
Subject: executing git from a non git directory
Date: Sun, 22 Jul 2007 01:55:33 -0500
Message-ID: <6b6419750707212355q48a934e4n3be0d6111694ad01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 08:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICVLv-0005uG-8v
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 08:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbXGVGzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 02:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbXGVGzf
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 02:55:35 -0400
Received: from qb-out-0506.google.com ([72.14.204.232]:16680 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbXGVGze (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 02:55:34 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1920293qbe
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 23:55:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DK2d9hBB1dNSSuq19Hi/3ljHF09RaXqgSoj3X6Eef07RKkQsiwneiTf+qFVwvCUjmiPox1woS1nr5gvAaLSMHOd75VDdtqTYwz5blmv5c0o/Vm4V6rjoNaO1lIX9C6zsubxdvPttXpubVJQS6PqPEmL3GYFuNZ2BhJv2x8xmukA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nd8h+hg5/X9/vMScIfZpb4MDpRHl/94G+hsLqGCk1dJt697gdhu46jZURCWQs82e+R02oHgXlo9Nf7YMJWQ110QbppwUtHOKwTVtTpnI6DcK09wt9y2PWMMz5wfgy5Gtv7oh2lnvSdvWd7+qCja7oezepKFB82JMu8i5088nm9A=
Received: by 10.141.51.15 with SMTP id d15mr600224rvk.1185087333420;
        Sat, 21 Jul 2007 23:55:33 -0700 (PDT)
Received: by 10.141.18.11 with HTTP; Sat, 21 Jul 2007 23:55:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53224>

Hey all,

I have my git directory that is in /path/to/my_git_dir

I would like to check it from another direcory, I tried the following command:

$ git --git-dir=/path/to/my_git_dir status

and

$ GIT_DIR='/path/to/my_git_dir' && git status

but in both cases I get this error:
fatal: Not a git repository: '/path/to/my_git_dir'

yet when I do "$ cd /path/to/my_git_dir && git status" I do get the results.

Any idea what I'm doing wrong or if there's a way to check a git dir
from a non git dir?

thanx in advance

Pat
