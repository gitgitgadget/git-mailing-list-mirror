From: Jorge Bastos <mysql.jorge@decimal.pt>
Subject: Re: Help on CGIT
Date: Tue, 29 Dec 2009 14:44:39 +0000
Message-ID: <ab6fafb1c8d1117674cf4b7ffd1df811@192.168.1.222>
References: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222> <20091229123127.GA6154@bit.office.eurotux.com> <9cf5f850c0c5ea8054e9bebc810ea6d3@192.168.1.222> <20091229140842.GB6154@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 15:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPdIz-00080a-Jx
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 15:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbZL2OoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 09:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbZL2OoI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 09:44:08 -0500
Received: from mailrly03.isp.novis.pt ([195.23.133.213]:37917 "EHLO
	mailrly03.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbZL2OoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 09:44:06 -0500
Received: (qmail 29887 invoked from network); 29 Dec 2009 14:44:02 -0000
Received: from unknown (HELO mailfrt06.isp.novis.pt) ([195.23.133.198])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly03.isp.novis.pt with compressed SMTP; 29 Dec 2009 14:44:02 -0000
Received: (qmail 24564 invoked from network); 29 Dec 2009 14:44:01 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt06.isp.novis.pt with SMTP; 29 Dec 2009 14:44:01 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id 897631878E0;
	Tue, 29 Dec 2009 14:44:39 +0000 (WET)
In-Reply-To: <20091229140842.GB6154@bit.office.eurotux.com>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135800>

On Tue, 29 Dec 2009 14:08:42 +0000, Luciano Rocha <luciano@eurotux.com>
>> Yap, with 777.
>> But the parent dirs don't, they have 755 the debian default, and both
>> /var
>> & /var/log owner by root.
> 
> That's what they're supposed to be.
> 
>> I also tryed to make /var & /var/log/ be owner by apache's user
>> (www-data)
>> but nothing, and also tried make them 777 aswell, the same.
>> This lock dir can't be configureable?
> 
> Probably, don't know much about cgit. One thing, are you using selinux?
> What does sestatus show?

no SELinux compiled or active on kernel.
don't even have setools installed on the system.
I'm out of ideas :(
The info on the web about CGIT is rare... don't find an answer for this.
