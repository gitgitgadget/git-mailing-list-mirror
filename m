From: Caleb Cushing <xenoterracide@gmail.com>
Subject: git-new-workdir not working right?
Date: Tue, 14 Apr 2009 00:09:43 -0400
Message-ID: <81bfc67a0904132109k45f09f79s21ce3132ade02001@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 06:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtZzs-0006IL-ET
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 06:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbZDNEJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 00:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbZDNEJp
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 00:09:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:49166 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZDNEJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 00:09:44 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2498558ywb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=2FCr+WxDtt7pL/RxK3Exf5obpsJjxsN6TZUeMVjYYPs=;
        b=qEBgWPkB3o4TFWvVY3iVa8xssiGpJOiJeHSqoV5wLH2Zq3KtBug0CeLVEs8kEdGljH
         Olii/FrGmGg1q0S1ryOr/ecVMfBTFjtxV6iCNNgDWZy3Aw5HNBzvpeSssQ6Ex6ymWQuY
         2RcawgYESTXppH7X5DxrCOCETw7Grn6XEIgKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Nenref0Ga8OfsNS5fBRbJPstIFi2X51OuLsGA83tqhVJrTXmWymwEmRAlS23vj/dVj
         V8fg2qut18OoODxhyrrI4zo3I02CglNcTbhrAmCuSprXCtFyfrSXNeqEwZ2polt+eRrP
         p1scTAk7nyQWRN6Yon9NeDtrNZ6o+QbM1NRtQ=
Received: by 10.100.10.15 with SMTP id 15mr9309670anj.6.1239682183073; Mon, 13 
	Apr 2009 21:09:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116509>

before I could do git-new-workdir path/to/repo/.git neworkdirname now
that doesn't seem to work... I actually had to cd to path/to/repo/.git
and do git-new-workdir . ../.../neworkdirname to get it to work. it
was complaining that the .git/ wasn't a git repo.

using git 1.6.2.3

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
