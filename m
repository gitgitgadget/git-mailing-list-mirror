From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Missing documentation
Date: Mon, 05 Sep 2005 17:41:13 +0000
Message-ID: <431C8339.7070505@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 05 19:44:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECKyk-0005JB-Mo
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 19:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVIERlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 13:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIERlY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 13:41:24 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:10902 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932330AbVIERlX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 13:41:23 -0400
Received: by wproxy.gmail.com with SMTP id i11so877474wra
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 10:41:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=fZDqnaFxKcjPwo3fpkaQL+7Uv9RzPnNY+ye5OsKLLzKZGb52KGyBWnuIMBwdotmnCimM6z2705oQLK/yYfxzKW2wY7gJ8W5uh5acO5iaVYoBuYsb4NNm/CFYXTfRqerotrrDg7tgT7K57MxMTO0ZJc9iDZzyv240JJ3PXNZ7/GM=
Received: by 10.54.56.56 with SMTP id e56mr4274115wra;
        Mon, 05 Sep 2005 10:41:18 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 33sm4621715wra.2005.09.05.10.41.18;
        Mon, 05 Sep 2005 10:41:18 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8103>

The following is the list of files in the Documentation directory that 
have *NO* useful text in them at all.

	git-build-rev-cache.txt
	git-checkout-script.txt
	git-diff-script.txt
	git-format-patch-script.txt
	git-get-tar-commit-id.txt
	git-reset-script.txt
	git-rev-parse.txt
	git-show-rev-cache.txt
	gitk.txt

The list is the output of the following trivial script:

	cd Documentation
	grep -l 'Does something not yet documented.' *

If you are the/an author of one or more of these commands (or anyone 
else), please create some documentation for it.

If you care to, please review the rest of the documentation for out of 
date and/or incomplete text and either produce a patch or let Junio know 
so it can be added to the TODO list.
