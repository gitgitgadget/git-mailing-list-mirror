From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git vs git
Date: 30 Jan 2006 08:55:36 -0800
Message-ID: <86acddirjr.fsf@blue.stonehenge.com>
References: <d93f04c70601300714i4b7b3b58qa5aa151e3e42a413@mail.gmail.com>
	<20060130153715.GE30671@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hendrik Visage <hvjunk@gmail.com>, david@dgreaves.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 17:56:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3cJc-0001VZ-QL
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 17:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWA3Qzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 11:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWA3Qzm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 11:55:42 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:65314 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964777AbWA3Qzl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 11:55:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 112BB8EBD9;
	Mon, 30 Jan 2006 08:55:37 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 19413-02-23; Mon, 30 Jan 2006 08:55:36 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 95BB68F283; Mon, 30 Jan 2006 08:55:36 -0800 (PST)
To: Erik Mouw <erik@harddisk-recovery.com>
x-mayan-date: Long count = 12.19.13.0.3; tzolkin = 9 Akbal; haab = 1 Pax
In-Reply-To: <20060130153715.GE30671@harddisk-recovery.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15283>

>>>>> "Erik" == Erik Mouw <erik@harddisk-recovery.com> writes:

Erik>   #! /bin/sh
Erik>   # sct: call git
Erik>   gitpath=/path/to/git
Erik>   export PATH=$gitpath:$PATH
Erik>   exec $gitpath/git $*

You must not get a lot of spaces in your pathnames.  I think you want
those last two lines to be:

        export PATH="$gitpath:$PATH"
        exec "$gitpath/git" "$@"

Typical lazy shell programmer. :) :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
