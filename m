From: "eric miao" <eric.y.miao@gmail.com>
Subject: How can I force git-fetch to re-retrieve all the missing commits?
Date: Mon, 14 Apr 2008 13:32:01 +0800
Message-ID: <f17812d70804132232t748fd8bh2cc8c4b1d065285d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 07:32:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlHJK-0004mk-MS
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 07:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYDNFcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 01:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbYDNFcG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 01:32:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:56522 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbYDNFcD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 01:32:03 -0400
Received: by wa-out-1112.google.com with SMTP id m16so2142117waf.23
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ElExu/Bqt6FjhYIxpDho5BxAdy/7RdlJTtiFaaBOR44=;
        b=Ohr/TKUMoasgZHBz15Dh3KKAZocz+JveeaCTkrqxJb2zOL87me94STgIAV+iG0IHI5bCphbVuz74YRsDpb26BmcAxH5J5r1K8YtUkLhppnV3cQ5xuPiElMyxTqznGMrrigkP+5RFD4wN+1SnrecV/DBFC1Qz/SNNDVSKc6iWfE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PPt2zqwdEedXARJL8zq2Rt6pmqZ4HCNsRN4vdN/vFcfGIBX5UcOPFgquzp8IV3r4oYCqnaEvfjLBFeT8zlU3HM7Fxl0/pr15IG/t3p18fg3mn7nQ9bdQvDebaNqC51UxYgE4JdYJG56dqbNT0P75TwbLjnUvbX6eMFxq4WB/Nw0=
Received: by 10.115.79.8 with SMTP id g8mr3163548wal.215.1208151121298;
        Sun, 13 Apr 2008 22:32:01 -0700 (PDT)
Received: by 10.115.75.13 with HTTP; Sun, 13 Apr 2008 22:32:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79457>

git-fetch completed with connection error messages (using http), and
subsequent operations to examine those remote branches gave me
error messages of missing objects.

While re-run git-fetch doesn't looks to work, since git-fetch thought he
has reached the most recent commit.

How can I force a re-retrieve of the missing objects??

-- 
Cheers
- eric
