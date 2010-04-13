From: Kevin Menard <nirvdrum@gmail.com>
Subject: Getting the latest branches/tags with git svn?
Date: Mon, 12 Apr 2010 22:25:11 -0400
Message-ID: <i2h7e3605161004121925v28b8c544r7247f68a5115d486@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Voo-0007Zz-9B
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab0DMCZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 22:25:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51183 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab0DMCZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:25:32 -0400
Received: by gyg13 with SMTP id 13so3216648gyg.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=zDPUAOe4gQqQNrAsAeQ8DPXnrFvL7nQuV223Y55vH00=;
        b=QMKOnd6rtZDBpggaHGTNEdtDzDD1Y9PN1wcsXWiwd6U5kdw5gvbG3yYzeUfZkm1eZ1
         B0ILBdUMJUJEypa1nACyyOV4Kz8kUOg7LfoI97i6weVwAdhuti0jY0qf8+BP+UcnSKwq
         yh+NJ0WTthkb78JUOlyaOw6+31dV6mNlOhuGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=rRd8xua+Oy2hpN2eqwxOICg0eQaRAhmbyZ82TGPvg+TFajAJg7dUsL6qj3spHN1+8Y
         oce4fdy0+ZEjuDJQFuHqUx3H30k6xr8KBJXyltxq2VrfWWlhqo8tUr8PTvzE2NSejPCd
         5HPjQnxcCFOFvmNR7lXuA4Ljy9YjjTLhb2aTA=
Received: by 10.150.49.20 with HTTP; Mon, 12 Apr 2010 19:25:11 -0700 (PDT)
Received: by 10.150.128.10 with SMTP id a10mr4825379ybd.273.1271125531191; 
	Mon, 12 Apr 2010 19:25:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144783>

Hi,

How do I go about getting the latest list of branches and tags with
git svn?  My list seems to basically stay at the same state as when I
initially created the repo.  Subsequent git svn rebase and git svn
fetch operations seem to just be fetching changes to trunk.

Thanks,
Kevin
