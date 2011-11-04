From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Folder level Acces in git
Date: Thu, 03 Nov 2011 22:21:41 -0600
Message-ID: <4EB36855.8000802@workspacewhiz.com>
References: <1320300655224-6958047.post@n2.nabble.com> <CAPZPVFY15AqCpWcRbv0tjXBz4G2kQTm+nMGpsYzCKe0niHV_dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: redhat1981 <redhat1981@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 05:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMBH1-0001oC-Ky
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 05:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab1KDEUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 00:20:38 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39314 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1KDEUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 00:20:38 -0400
Received: (qmail 5148 invoked by uid 399); 3 Nov 2011 22:20:37 -0600
Received: from unknown (HELO ?192.168.1.109?) (jjensen@workspacewhiz.com@67.171.115.152)
  by hsmail.qwknetllc.com with ESMTPAM; 3 Nov 2011 22:20:37 -0600
X-Originating-IP: 67.171.115.152
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CAPZPVFY15AqCpWcRbv0tjXBz4G2kQTm+nMGpsYzCKe0niHV_dA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184758>

----- Original Message -----
From: Eugene Sajine
Date: 11/3/2011 1:28 PM
> Are you sure that the way your have organized the repository is
> actually correct? If you need to manage the access on folder level why
> don't you simply split up the project into several
> repositories/projects which each team is going to work with
> independently?
>
> This seems to me to be much simpler and cleaner solution then any
> other alternative.
>
Submodules are _not_ simple at all.  Our organization of nearly 100 
developers using Git pretty much let out a collective cheer when we 
finally removed the submodules.  Submodules are an absolute pain to 
develop within; there are a number of Git mailing list exchanges about 
that, but I'd be happy to go into great detail if anybody cares.  Even 
submodules that are read-only are a pain as it takes two steps (git pull 
+ git submodule update) to actually get them up to date.

Ick.

In short, if it is an absolute requirement to manage access to a 
repository on a folder level, get Subversion or Perforce.  DVCS is not 
for you...

Josh
