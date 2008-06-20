From: Cristian Peraferrer <corellian.c@gmail.com>
Subject: Is git-imap-send able to use SSL?
Date: Fri, 20 Jun 2008 18:08:42 +0200
Message-ID: <D3F1364D-68DC-457D-AC54-AE4B70B1B5AB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 18:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9jBI-0004Fk-Q1
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 18:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYFTQIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 12:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYFTQIs
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 12:08:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32677 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYFTQIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 12:08:47 -0400
Received: by ug-out-1314.google.com with SMTP id h2so19785ugf.16
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=DIh3QyIJa5c05gek+upVRpnPBphTxMpZQ1JkiQcSmlw=;
        b=x7PBeSqouTjKEA4SEJDylInnHcgoFJTVNOsvbNrUuvrSlsg1HG3ZL5Um7kgYyYGyB1
         kX2pEKowEsSV+sniS8w2j7MkHhW1HeqsQvMGZg91d5dgLcQ1ukI905C4gQg4IAo1HZhG
         8cxlOUk2392sLBW4LgH+96I3NFWYVYDjLUm90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=JtKvQ/Qf1c/B7lpDDpJ+4yh1UJP8oRj01k1ZFQ7hNPQSTfRr6NGBc+3hjFLiPtKR0O
         wdKr2eLqmUnR+w+FsYsTXqjy41bsvjXHCHlW5PWApQ9gwNvDPAS8bwQzOXZWeUjxBgcO
         amgBr2QhEAA7Hlpt7nC1HisIiIJ1U7wcFIYfw=
Received: by 10.210.54.15 with SMTP id c15mr3209468eba.128.1213978126342;
        Fri, 20 Jun 2008 09:08:46 -0700 (PDT)
Received: from ?192.168.1.5? ( [80.33.90.183])
        by mx.google.com with ESMTPS id g9sm3226548gvc.0.2008.06.20.09.08.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 09:08:45 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85659>

I am trying to use git-imap-send to send a Draft to my GMail account  
which uses SSL to connect, I have put the correct port (993 in that  
case) in the config file but it seems it doesn't work. I figure that  
git-imap-send is not able to connect using SSL.

-- 
Cristian Peraferrer
Jabber ID: corellian at swissjabber.ch
