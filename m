From: bill lam <cbill.lam@gmail.com>
Subject: commit --quiet option
Date: Tue, 24 Nov 2009 13:16:22 +0800
Message-ID: <20091124051622.GB18003@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 06:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCnlY-0003Hb-Is
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 06:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbZKXFQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 00:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbZKXFQX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 00:16:23 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:45026 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZKXFQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 00:16:23 -0500
Received: by pzk26 with SMTP id 26so4387371pzk.4
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 21:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=FeV4F1I/NRm+Ov7M2RRcPDExp65rEfAgwolGzp0fC9E=;
        b=jNE1PEspC3R7XTUiYcoFNHH/a+9zxVOBmJxR24W25ig3fkcBW4HIDfYkcEkNJsDmJq
         ce4Pf2ouyNp9CvHRXN6MRnNr0dmCYBzOuyMVLuw7PPI5mCP1LmIZlh5vZ5Fyp1m1Y1xK
         PvuzrQgUX+4Pe3fB1fdEhGz/zHLwQuQG8ly/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=bE6mjSFcu1W/9dfSljk4a93NfzK/cQllhxMixAKVpnF6GH1BEw3csH2Oo7zS1xLSit
         E1xqI3AtIaTGBVQH0P9AUgFyh/FHByZt+6oWzQmxi5TYF5RWFcQHcBbZFKGsvPHojMQv
         pyA81QmSPntFDh8RGGejoSkGMW37rrohmbxek=
Received: by 10.115.98.11 with SMTP id a11mr11099001wam.130.1259039789208;
        Mon, 23 Nov 2009 21:16:29 -0800 (PST)
Received: from localhost (pcd589021.netvigator.com [218.102.121.21])
        by mx.google.com with ESMTPS id 21sm3017956pxi.0.2009.11.23.21.16.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 21:16:28 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133559>

In git version 1.6.6.rc0.15.g4fa8a0 using the --quiet option it still show some
output.  Is that intended?  Specifically I would like to exclude message about
the untracked files when using --quite option.

$ git commit -q -m commit
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   .git-completion.bash
#       modified:   bin/mirrorgit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       a123
no changes added to commit (use "git add" and/or "git commit -a")

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
