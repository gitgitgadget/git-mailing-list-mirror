From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Time to flush developer accumulated patches?
Date: Sun, 20 Jan 2008 11:10:27 +0100
Message-ID: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 11:11:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGX8s-00034Q-1n
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 11:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbYATKK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 05:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYATKK2
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 05:10:28 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:22405 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbYATKK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 05:10:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1415420rvb.1
        for <git@vger.kernel.org>; Sun, 20 Jan 2008 02:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=uBAPTt4WiNBHsPOY3BR1yFWx0JdlJ+B8+V6YSYr+Q0Y=;
        b=nEaJhgUOh/l+ILkr3tK8/nsGP/ZuoC2fzhHKbx92WAiY8pAjBlHgGnQ7VfyiWx8wzhbVAEIyGIKBwLFG7JxOUFVafmcVAFJ62WPKfrU5SproI74az/PjQXZL814pJqE37GPpJPMQg7TGLfwnoSVOP3vCGm5ejXM7vdbj61rs8DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m6NPZ4Xa8new9Fvrvkl7yVba5bTpnmw6xmug/sV5/gcXQUy2IeDqaofRLi03eZlTY3v/P9cJ3Eez7Q7VJ/RehlvZlh895M3tSlLXcjB7QG6KegAZJf7ngNr2Vzrq1vA9+Dl2nRlS96buYIp8tN+EmmHna2IQN06igdBQHA0+LRY=
Received: by 10.140.136.6 with SMTP id j6mr3669388rvd.50.1200823827091;
        Sun, 20 Jan 2008 02:10:27 -0800 (PST)
Received: by 10.141.68.21 with HTTP; Sun, 20 Jan 2008 02:10:27 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71168>

Reading mailing list threads it is becoming common these days to hear
about contributors with patches ready to be sent as soon as 1.5.4 is
out.

Would be a good idea to open a new branch new_stuff as a target for
this pending stuff?

I understand that you want people focused on fixing bugs, but I also
understand that people don't ;-)

Opening a new_stuff branch could have the following benefits:

- Give more time to fix bugs before 1.5.4 is out without stopping
people from having fun and reduce the pressure to release.

- Reduce the merging impact when master reopens because patches are
already merged in new_stuff and developers have already taken care of
conflicts

- Do not slow down the wheel: I can develop some patches and keep them
myself, but until are not discussed in the list and eventually got in
master has little meaning to continue develop additional stuff.

- Perhaps it's lack of reviewing time on your side that worries you
(as is normal because we are on bug fixes mode in master) but upgrade
from new_stuff to master would be not automatic nor guaranteed but at
least people have an idea at what's going on and can keep contributing
in code and ideas.


Comments?


Marco
