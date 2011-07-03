From: Bruce Korb <bruce.korb@gmail.com>
Subject: How do I get the name of the parent branch?
Date: Sun, 03 Jul 2011 09:49:19 -0700
Message-ID: <4E109D8F.3030402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: GIT Development <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 03 18:51:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdPtR-0005fY-8I
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 18:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab1GCQtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 12:49:22 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58078 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab1GCQtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 12:49:22 -0400
Received: by pvg12 with SMTP id 12so3786090pvg.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=C2wTuhjx/DqTe1pfbWsuP+rV7jtEMpuuc0Ccxq+bi9M=;
        b=uSUQkqFVuId5FGbh8U6cVDb4/ntcRYmsTEW8f0F5I1X1vaNvgb98Eg/CRJtpmuWCRY
         moHNpW1InPTgqmvuRblK64XEH2aQgsd4jEYuaMBZeVUAEDqSppQqtnfxFifuF8pKqgx4
         yf4EmGHBWgJsTshi/f0mfhV5ouTgP2L3bNLJU=
Received: by 10.142.248.7 with SMTP id v7mr2622149wfh.358.1309711761387;
        Sun, 03 Jul 2011 09:49:21 -0700 (PDT)
Received: from [10.0.0.2] (adsl-75-2-134-239.dsl.pltn13.sbcglobal.net [75.2.134.239])
        by mx.google.com with ESMTPS id u6sm3379594pbh.16.2011.07.03.09.49.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 09:49:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176575>

Google results point to how to get to commits that have gone into
parent branches, but fundamentally I just want to have a script
that constructs a diff of what has changed since the latest branch
without having to do manual research to figure out the name.

As best as I can tell, you use:

    git format-patch -o pdir --ignore-if-in-upstream $branch

the hard part seems to be (but ought not be) figuring out
the value for "$branch".
