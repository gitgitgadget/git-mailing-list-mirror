From: Olaf Hering <olaf@aepfle.de>
Subject: push from one remote to another
Date: Fri, 8 Aug 2014 15:20:22 +0200
Message-ID: <20140808132021.GA23032@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 15:20:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFk63-0004bz-Ml
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969AbaHHNU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 09:20:28 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:59075 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaHHNU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1407504024; l=541;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=1EcnWMbGeaxCYYVp+XBbSKk4dfg=;
	b=t3AKTeFQ6WWJO4+h/OHtogf9SBWqnEvcLxJJGHuyC3i4A1ARKpWhmU1T7I7Ij2xuhVM
	RoWmWdWum9SmNSmjkXRZpPbEPMIjtRnYAIkpOt+h+oKo2/LgeYXz/CaJxABv19zwJPmem
	cNnMtZ3xRan7IKh/MMYG7CxTVacTnWf0yTw=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssUIlSFMulEekh1V+4SeDxi+jBPcPGRBxIB/lLRg==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:10d7:b901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.3 AUTH)
	with ESMTPSA id u06240q78DKNOEj
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Fri, 8 Aug 2014 15:20:23 +0200 (CEST)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id E4FB450287; Fri,  8 Aug 2014 15:20:22 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255015>

What is the correct syntax/setup to push from one remote to another?
I did something like this, to feed a github repo:

 # rm -rf $$
 # mkdir $$
 # cd $$
 # git --init
 # git remote add --tags t git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 # git remote add --tags o git@github.com:user/repo.git
 # git fetch --all

This syntax does not work for me:
 # git push t master o master
 # git push --tags t master o master

Is there a way to kind of mirror without doing a checkout, to save
diskspace?

Olaf
