From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] fix cg-fetch so that it doesn't use -d (to work with
 POSIX cp)
Date: Mon, 21 Nov 2005 09:46:30 +0100
Message-ID: <43818966.7020800@op5.se>
References: <863blq4p4x.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 09:47:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee7Jq-00040d-VN
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 09:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVKUIqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 03:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVKUIqc
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 03:46:32 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:22400 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932229AbVKUIqb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 03:46:31 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B65386BCFF; Mon, 21 Nov 2005 09:46:30 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <863blq4p4x.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12431>

Randal L. Schwartz wrote:
> I simply removed -d, since I don't know how necessary it is to make
> it work better, but it seems to work fine on OSX now.
> 

This enforces symrefs instead of symlinks when cloning locally. There 
have been some discussions on the topic before, and the decision was to 
maintain symlink support on filesystems that can do it. OTOH, Pasky 
(cogito author) was all for only supporting symrefs, so perhaps he'll 
accept this anyways.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
