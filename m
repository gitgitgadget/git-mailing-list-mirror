From: "Tony Luck" <tony.luck@intel.com>
Subject: proxy documentation
Date: Fri, 10 Mar 2006 16:49:14 -0800
Message-ID: <12c511ca0603101649y51311f0du1a165596428b31b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Mar 11 01:49:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHsII-00027a-1W
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 01:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbWCKAtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 19:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWCKAtP
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 19:49:15 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:49388 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752279AbWCKAtP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 19:49:15 -0500
Received: by zproxy.gmail.com with SMTP id i1so928904nzh
        for <git@vger.kernel.org>; Fri, 10 Mar 2006 16:49:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uGtwPrx/A2231JDJ/ZIs1NQ3sevh3JNNirZAtWRFatvUo5IT4qYaExV6z495paewjGKaN4hVWj8CMxZFXGFYgzLzq8Z95ev33nfIIM6aQhgjnXAZLI6J5RZ4fIir3k6oj/8SrTR0jVSH8eSM8CVrvFVn8d1ogSDptKNTCOoDG8s=
Received: by 10.65.222.6 with SMTP id z6mr1203682qbq;
        Fri, 10 Mar 2006 16:49:14 -0800 (PST)
Received: by 10.65.194.4 with HTTP; Fri, 10 Mar 2006 16:49:14 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17485>

Example documentation for proxy settings in Documentation/git-repo-config.txt
shows:

[proxy]
                command="ssh" for "ssh://kernel.org/"

But the code in connect.c:git_proxy_command_options() looks
for "core.gitproxy" rather than "proxy.command".

I've only just started looking at the proxy support ... is it just the name
that is wrong in the documentation, or are there other issues here?

proxy.command sounds like a better name than core.gitproxy ... so
maybe the Docs are "right" and the code is "wrong"?

-Tony
