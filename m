From: "eric miao" <eric.y.miao@gmail.com>
Subject: Is it possible for git to remember the options preference for "git log"?
Date: Mon, 12 Nov 2007 08:33:43 +0800
Message-ID: <f17812d70711111633u6c00d182u532fef1c16c3c94a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 01:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrNFX-0007i7-8u
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 01:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947AbXKLAdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 19:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755945AbXKLAdo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:33:44 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:53398 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbXKLAdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:33:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1349929wah
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 16:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Rh48tiVlQnaDGH2t2w9iW2s1SvrglqgY2ZEKVHItqAA=;
        b=co5JL74RWwrl0UU5682IgzC09EE84GfQFj/uaibkuijryhIqjfmJPEBQRD404owg+76AZavIYLijoaDrdEI31ztHNnS0qRjOzjbS1GMAFDSzelI4gP8sgrgX97iYzrKtAi7TnLh9vo1u2/RdbW6X4s+WdeBBJhnj2jiDrjI57Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KfF3hhCkQ1DuhaU1iYIjcokax4wtotIE6VKby9EJcJdYuK/SUEeiIeyksBscbjgOr69b5Go42xkjuy3IbRHlktIrUb8HXCxIz1UTD+xPT3s7ij24PElBAGJwdqetrFdS/A2KHrwdUqEWDlvZE8xyhONhR+5t+f83Ro1Dco0UZlw=
Received: by 10.114.110.1 with SMTP id i1mr61947wac.1194827623427;
        Sun, 11 Nov 2007 16:33:43 -0800 (PST)
Received: by 10.114.147.6 with HTTP; Sun, 11 Nov 2007 16:33:43 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64541>

All,

Most of the time I'm using git-log for inspecting a brief history
and insert/remove/modify commits between, which I have to
type "git log --abbrev-commit --pretty=oneline" every time. Is
it possible for git to remember this command line options
preference?

And no, I don't really want to use shell's alias or something
else, I was just used to type "git xxx" :-)

-- 
Cheers
- eric
