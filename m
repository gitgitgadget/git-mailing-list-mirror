From: Ittay Dror <ittay.dror@gmail.com>
Subject: locate commit by file
Date: Tue, 04 Nov 2008 10:11:40 +0200
Message-ID: <491003BC.7040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:13:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxH29-0002Cv-Lc
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYKDILv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbYKDILv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:11:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:53964 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbYKDILv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:11:51 -0500
Received: by ug-out-1314.google.com with SMTP id 39so122858ugf.37
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=VUK/nrhtPVfn7E8Se4FMBISei+u44Ks3elWYZgoqzMc=;
        b=odoiLCRTwy481lAs2v5VRvpKhkphIX5UWoUI9IaPpkfgbDCib51E9g9AZqZFFo4jNQ
         E7vvHGmoQyBueXixX6m//MzWFbT/quDCgxdVu2owwqBANXwJzj50qjQrp2cD5FUxb7HD
         U9hn2edKr64rqmnHIR5yx0vZi1me0LH3F+zak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=XnhqW9Q2jhecQzh4pn0sJ6cbVthSKnX37sO9T0tn4tb2N4zNBMs+m5sMV22KWkOfjZ
         NygOJtd5Jnh5uAZ2dCAczmL5/bwKCU7bTj/azyjPaA4EjwnV9U0Gr4d9NonXt6DZRyUi
         AR+1gvzgv12D3KBuwD6t9mxwOxppkiZ1wS6KY=
Received: by 10.66.224.19 with SMTP id w19mr2679976ugg.72.1225786307324;
        Tue, 04 Nov 2008 00:11:47 -0800 (PST)
Received: from ?10.10.2.7? ([212.143.191.180])
        by mx.google.com with ESMTPS id 27sm1296284ugp.37.2008.11.04.00.11.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Nov 2008 00:11:46 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100052>

Hi,


Given a file, is there an easy way (e.g., not bisectig) to find the 
latest commit where the file content is the same?


Meaning: I have a file /tmp/A and I want to file the latest commit where 
a/b/A is identical (content wise) to /tmp/A.


Thank you,

Ittay


-- 
--
Ittay Dror <ittay.dror@gmail.com>
