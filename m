From: "Ping Yin" <pkufranky@gmail.com>
Subject: How to bypass the post-commit hook?
Date: Sun, 30 Dec 2007 23:12:12 +0800
Message-ID: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 16:13:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8zqR-0005v3-Od
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 16:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbXL3PMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 10:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756001AbXL3PMP
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 10:12:15 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:46353 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949AbXL3PMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 10:12:13 -0500
Received: by py-out-1112.google.com with SMTP id u52so8607351pyb.10
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7LvYUC0TjFQttITY3y7N9M81q0DQB1OpuHwn746oBuU=;
        b=FxPU9BUBk2LEcQAwmdFttvgZJgDiqKfdqGGUCLtO9CJG5X+08PCaeXh0DnvjcA2W8kh8xPlv79T2Sn2cUIDo43UyZ+sCmfp4XuuZPkr2wudeKfCjhK/XxDBB9eTk15Ij6Ovj9IJKEw++k/2gVi1bKNbytf6FwIa5pjIRI6ffTh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Bkq6a3pg+Is/+m7XYJkXOhecbhk8Jwqd/HcgCAD40lM/3zST2qi8l7WV6OhlOWbOvZiz7wrB0Dw5RjRZiffrst7bW9vO8lYcrxDylfQjEl+EuqhQPs3lJDHxjDAymA9Py2naRMSqV9TuaB31tF00NZQOV8VEEkuRMbJn7H54htY=
Received: by 10.35.86.12 with SMTP id o12mr9485684pyl.27.1199027532833;
        Sun, 30 Dec 2007 07:12:12 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 30 Dec 2007 07:12:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69365>

--no-verify can bypass pre-commit hook? Then how to bypass post-commit hook?

Usually I want post-commit take effect. However, in the middle of
git-rebase, i want to bypass post-commit when 'git-commit --amend'
since my post-commit hooks will modify the working directory and so
make following rebase troubesome.

-- 
Ping Yin
