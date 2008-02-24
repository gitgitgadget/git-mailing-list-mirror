From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: on subtree checkout
Date: Sun, 24 Feb 2008 16:34:58 +0700
Message-ID: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 10:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTDGl-0002br-KY
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 10:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbYBXJfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 04:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbYBXJfD
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 04:35:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:56808 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYBXJfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 04:35:00 -0500
Received: by fg-out-1718.google.com with SMTP id e21so856713fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 01:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=vTlG1q6R7MMGEyW+2qEHJZ9Yrpp41EbRJFOlf+mrsx4=;
        b=HagBUpqLDfqltEHDBE8wVs9ZmrqQf6kil8lzjxz6hoz58JRkbGZH/HwThtI7RQiGmXhkmZ4dA6dytMCK+iwbvuPSYFs0QJgiPmeombCqv28lE7pIrABxVPMIliKSR30z2P1oCOFpyC5LOW7APCleKzYKDxAFknBE5laIGffwV+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BuqZwPMMxoab4WXKJkC8Dhldl4oEfffwSQZVbFpeVL62UoHIKS9BX0zjgTyEWEFG9RsHTsQOdZI1cUPS1/RmWGKf3lipxYJZiVYCzLr5v0u/b3DDVuTdi5FTiFrWQagqTcM86dAdqIZoQlBuC2TPqwSxmazkaIeuFBC67F8jOrU=
Received: by 10.86.72.15 with SMTP id u15mr1439835fga.11.1203845698157;
        Sun, 24 Feb 2008 01:34:58 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Sun, 24 Feb 2008 01:34:58 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74915>

I'm going to implement subtree checkout. The plan is to save "index
prefix" in GIT_DIR/prefix and update git commands to use index prefix
when accessing the index. If I'm heading a wrong way, stop me now.

Thanks
-- 
Duy
