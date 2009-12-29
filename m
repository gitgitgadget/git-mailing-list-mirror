From: Jorge Bastos <mysql.jorge@decimal.pt>
Subject: Re: Help on CGIT
Date: Tue, 29 Dec 2009 12:38:15 +0000
Message-ID: <9cf5f850c0c5ea8054e9bebc810ea6d3@192.168.1.222>
References: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222> <20091229123127.GA6154@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 13:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPbKX-0005PT-5m
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 13:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbZL2Mhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 07:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbZL2Mhc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 07:37:32 -0500
Received: from mailrly06.isp.novis.pt ([195.23.133.216]:57323 "EHLO
	mailrly06.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZL2Mhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 07:37:31 -0500
Received: (qmail 25166 invoked from network); 29 Dec 2009 12:37:29 -0000
Received: from unknown (HELO mailfrt07.isp.novis.pt) ([195.23.133.199])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly06.isp.novis.pt with compressed SMTP; 29 Dec 2009 12:37:29 -0000
Received: (qmail 18761 invoked from network); 29 Dec 2009 12:37:29 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt07.isp.novis.pt with SMTP; 29 Dec 2009 12:37:29 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id A26EE1E3599;
	Tue, 29 Dec 2009 12:38:15 +0000 (WET)
In-Reply-To: <20091229123127.GA6154@bit.office.eurotux.com>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135794>

Hi Luciano,

>> [Tue Dec 29 12:12:25 2009] [error] [client 192.168.1.3] [cgit] Unable
to
>> lock slot /var/cache/cgit/53200000.lock: No such file or directory (2)
> 
> Does the directory /var/cache/cgit/ exist?

Yap, with 777.
But the parent dirs don't, they have 755 the debian default, and both /var
& /var/log owner by root.
I also tryed to make /var & /var/log/ be owner by apache's user (www-data)
but nothing, and also tried make them 777 aswell, the same.
This lock dir can't be configureable?
