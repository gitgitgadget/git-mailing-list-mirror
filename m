From: Jeenu V <jeenuv@gmail.com>
Subject: Transplant branch from another repository
Date: Tue, 1 Dec 2009 16:31:02 +0530
Message-ID: <5195c8760912010301r63d5e27axf53c17db799a798f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 12:01:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFQU4-0003b3-GB
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 12:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbZLALBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 06:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbZLALBQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 06:01:16 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:46549 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbZLALBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 06:01:16 -0500
Received: by vws35 with SMTP id 35so1456207vws.4
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 03:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=9GW+uP7byEV3dqABXIVzJLG6rGDP0pP9CXx1ibZonHk=;
        b=vLl9E60qlTQqJH0pgUTJDsh5wfZhgiduz3nGdadkKsqu2TCl3c+WpND5ehZb/Rn/gw
         3pa9EbHata7CusueoGfl8qq/H9mUqIhFXqd8oVvGvkEMVSBUYFtuVFpKZF/RrxVHdzpa
         zQM0U2Y2zRP8ESdhR6wMrXpPOduYx7cf1uAfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=kDlZWKChHBOU6u9Fv4612bPkBLyqxQaufqXNe4heNSvSXT1y41zgUbNJAKI+n++EdU
         eCPVmgZM9mtYc1tSNwe86Hp3KGDhTCJGifzeMLr+vXl9eUeO2H9Dw4aYkiyI32v2C2Tb
         bsAhkljZPgYd/+k1wSIZ+h/wC7vpKOI3bBqow=
Received: by 10.220.126.224 with SMTP id d32mr6743087vcs.57.1259665282117; 
	Tue, 01 Dec 2009 03:01:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134197>

Hi,

Say, I have two repositories A and B (local, independent, but similar
- they are for content tracking and not collaboration purposes). A has
a branch 'a', which I want to have in B. What I mean is that I'd like
to have the sequence of changes in the branch 'a' to be present in B,
thus creating an independent branch 'b' in B.

Is there any way to achieve this? One thing that I could think of is
to use 'format-patch' to generate the list of patch files from A. But
I don't see how to convert those patches to a sequence of commits in
repo B. I could do a 'git apply patches/*' but then all patches
collapse to one single commit. If format-patch is a/the way, could
somebody tell me how to get this done? Or are there any alternatives?

FWIW: I'm running Git under Cygwin, and sendmail isn't configured.

Thanks
Jeenu
