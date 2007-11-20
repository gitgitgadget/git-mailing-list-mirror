From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: another way of storing patches
Date: Tue, 20 Nov 2007 09:53:55 -0500
Message-ID: <9e4733910711200653g4d87c433gae2d48f3508940f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 15:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuUUz-00068S-2E
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 15:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400AbXKTOx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 09:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757298AbXKTOx7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 09:53:59 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:61897 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757325AbXKTOx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 09:53:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1751784rvb
        for <git@vger.kernel.org>; Tue, 20 Nov 2007 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=iZr8q52mQzCjjlm5HqsBdlrFCLYAE1LqHvFM3jelJlw=;
        b=o8+TZCbmNWbjmz5UaPCcemxQs4S6oN74bHGt5MB/lofR7qAXdTNl5P6FwayPAOrUdgLhGW++t4BSds7gIZQKxDeZgRtVk3YtTgIFORVLtgl6pRvpBJxIkVu5fMykThrOLsUZg257cKbtq9cfOujrqJEr8pJpbTerMXFeNzKBF/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KQLUU3PGbM+QgIwln7VAholcha1QGe2wNTQ+hZnd+8XDh17kOzIPBmqaryVROMpmFIVWQWSdCsyHVuoElCqgGM58VPE3sBkjMSB9FWoLQy+USgKdm8m0kBnUFkQ64g//zHQLGV6R+41klOCZuwv6WEU4uXYFLS74B9yUjzkO4/o=
Received: by 10.114.59.1 with SMTP id h1mr169450waa.1195570435795;
        Tue, 20 Nov 2007 06:53:55 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 20 Nov 2007 06:53:55 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65547>

What about storing each stg git patch in a branch and then
auto-merging them into the working copy? That would allow per patch
history and undo. Would it make them easier to share? You could use
tag names to tell stg how to merge and make the working branch.

-- 
Jon Smirl
jonsmirl@gmail.com
