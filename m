From: bill lam <cbill.lam@gmail.com>
Subject: how to rebase backwards
Date: Tue, 3 Nov 2009 13:45:10 +0800
Message-ID: <20091103054510.GB7117@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 06:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5CDA-0004jO-P6
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 06:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbZKCFpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 00:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZKCFpM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 00:45:12 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:50222 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbZKCFpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 00:45:11 -0500
Received: by pzk26 with SMTP id 26so3746154pzk.4
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 21:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=gi6njSt9FfWuMfYuU3AQnNSAsduSKHEE51n9raVEcDc=;
        b=NEu6lGP17QgcKxySiiI0iRK/ysLXA1Tbbs7GWVeRsa9tbHZ6gRx2sZIWna59fkVH0f
         glSygCbSEbAwQl8RslwS+R80Azvi3c05LPDx3FqKfe1nchwHJ3JNlsExE3SND4n1o36s
         abu5wHuAPZ2h6V37Cy26jckZqu/Wlzw3QJIyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=gFnQ5YxPRyS9NDti9C19Udo/+d85JsHoDB/0PuvGxYuW6ccloDzDEukeVDRbUjDxdw
         ckHfpCVp/ci5Dtvch7VdpwlUCqLZ1DNWBptpfujEdM18D1HeURFQ0YF8Oz2jfcEdEw4f
         +Wsu9+GQdRXQFK/gnXWjIQgJNsP9fgkFJBB78=
Received: by 10.115.84.9 with SMTP id m9mr10226637wal.163.1257227116235;
        Mon, 02 Nov 2009 21:45:16 -0800 (PST)
Received: from localhost (n218103234051.netvigator.com [218.103.234.51])
        by mx.google.com with ESMTPS id 22sm638485pxi.10.2009.11.02.21.45.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 21:45:15 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131944>

I want to rebase a new branch onto an earlier commit 

original:  
E is a newly created branch from D and not yet modified
                    E
                   /
-- A -- B -- C -- D

new: what I wanted
     B'-- C' -- E     for deployment
    /          
-- A -- B -- C -- D    trunk

so that I can continue to change all commits from B to C without
affecting E

I try (not sure if correct) doing it by
  git rebase --onto A B E

but then there is a lot of conflict/both modified files. What will be
the correct way to do it?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
