From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: BUG. Git config pager when --edit
Date: Mon, 7 Nov 2011 17:26:52 +0400
Message-ID: <20111107172652.0faade61@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 14:27:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNPE7-0001c7-90
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 14:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393Ab1KGN06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 08:26:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64749 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab1KGN05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 08:26:57 -0500
Received: by faao14 with SMTP id o14so5081600faa.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ZyijPSg8S/Hj+Ry2g0FXSEe0vhvA7mHDIJVVGC3Ua6Q=;
        b=eEpA9dtIoaJOiGtcJ2QONU/Lcb6oq51FI7SC06GhN69TaaFVFVgW57WYeTxTIjPIVl
         NhAYXizuh1qibmh7Fabz/2V9VIcaU7RwGMSJUx4eJDapzHWoaQ3q8cjSxIEDr8Tvjxpk
         oqBrzc+nFzZpgXKDedyEdXuMZ/vvAJBnWV6i0=
Received: by 10.223.75.129 with SMTP id y1mr5060248faj.1.1320672415966;
        Mon, 07 Nov 2011 05:26:55 -0800 (PST)
Received: from ashu.dyn.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id k26sm31243529fab.8.2011.11.07.05.26.54
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 05:26:55 -0800 (PST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184983>

Hello!

I've found an annoying bug.
When I wanna review my config I run
$ git config --list

When I wanna edit config I run
$ git config --edit [--global]

As far as my config is large enough to be paged I set pager.config=less
setting. But since that moment when I run
$ git config --edit
I get 
Vim: Warning: Output is not to a terminal
And some messed config output

The same happens if to run
$ vim .git/config | less

Can anybody skilled enough fix it? :)
