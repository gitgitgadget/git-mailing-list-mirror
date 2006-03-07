From: Jacob Kroon <jacob.kroon@gmail.com>
Subject: gitk : Lines not showing up in diff
Date: Tue, 07 Mar 2006 20:43:30 +0100
Message-ID: <440DE262.7020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 20:36:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGhyK-0007kQ-PW
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 20:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWCGTfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 14:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWCGTfs
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 14:35:48 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:45677 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932066AbWCGTfr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 14:35:47 -0500
Received: by uproxy.gmail.com with SMTP id m2so1247uge
        for <git@vger.kernel.org>; Tue, 07 Mar 2006 11:35:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=LT42yNB2avLvJyn7We2juTPFKcoF0WvlS555drZzYq0lRk4Ru0/gkTv4tXeBZ8hmLBoGCw7szGShCt7OXeFK8HKQ3dUS+8otSH8ojGoQMYyeK8/vb4rD8IPpqF9cAzLdihEna+li7pW724Zi0IL2yCGVAiy/xnL0MTFMh3q+uSo=
Received: by 10.66.225.7 with SMTP id x7mr3805126ugg;
        Tue, 07 Mar 2006 11:35:46 -0800 (PST)
Received: from ?192.168.0.3? ( [83.249.217.43])
        by mx.gmail.com with ESMTP id k2sm11191ugf.2006.03.07.11.35.45;
        Tue, 07 Mar 2006 11:35:46 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: paulus@samba.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17347>

I "think" this is a bug in gitk:

If I have a textfile in which I remove or add a line that looks like 
"-----------...", it won't show up in the diff gitk produces. "cg-log" 
shows the line correctly being added or deleted.

I'm using gitk 1.2.4 (From Fedora, gitk-1.2.4-1.fc4)

//Jacob
