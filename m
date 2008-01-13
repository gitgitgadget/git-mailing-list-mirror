From: "Ping Yin" <pkufranky@gmail.com>
Subject: How to handle confilicts when merging submodules in the process of rebase
Date: Sun, 13 Jan 2008 14:54:29 +0800
Message-ID: <46dff0320801122254u85dde52ra68ffc3abbf62bda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 07:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDwkN-0007XP-OV
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 07:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbYAMGyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 01:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbYAMGyb
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 01:54:31 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:21273 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbYAMGya (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 01:54:30 -0500
Received: by py-out-1112.google.com with SMTP id u52so2413515pyb.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 22:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=SD+5dVh76maU9hmUOMPq4+Vx1i+2p9W898PU5iUD0ak=;
        b=t2KDTJzr5mYvh9kV1sMF4+e9j8DuuF7A2Tx3f0Aa1wP3y51uNWR6YLUq7raLfBsy2i3BYcWYAoOeM93FYLuAIqTdwtjkp3AhFe6GIxJgy/I7rVrC4t/0AzbFT7mcAvvSCJtHFDVYEQdko+iVL+XRdfw3lGMzhKRKh0KXEKIlCTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z2WuCpqJg1sUoc6JIDtHwjz4QACfBWWHZQfd1lUmhnvS5OTSdQ+Sjt2bD+dw+OV8z5kJaDKy8UwYCqOnyasX6N5zA1Xt1ckCZo8dzSQ7dDAZt4fv8CzxZPmHFiOFagOzCZSYq09dP+XxSXpUYQgKApA/0WdBOWT+tUSoTYM3cFg=
Received: by 10.35.65.17 with SMTP id s17mr6027371pyk.19.1200207269961;
        Sat, 12 Jan 2008 22:54:29 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 12 Jan 2008 22:54:29 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70372>

In such a case, the blob sha1 for the conflicting submodule in working
tree and 3 stages of index may be different from each other.
So git add will not work if I want to use stage 1 or stage 2 as the
merging result. Then how?

-- 
Ping Yin
