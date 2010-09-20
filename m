From: Kevin Ballard <kevin@sb.org>
Subject: Re: Newbie question
Date: Sun, 19 Sep 2010 23:55:43 -0700
Message-ID: <F47832A2-C25F-470A-81DE-9670F13DD4C2@sb.org>
References: <1284940287810-5548737.post@n2.nabble.com> <04E0C626-C16F-43A9-9AB7-41760B682F13@kellerfarm.com> <1284943806785-5548842.post@n2.nabble.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: kinley <arjuncode@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 08:55:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxaI3-0001IQ-M5
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 08:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab0ITGzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 02:55:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34428 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab0ITGzq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 02:55:46 -0400
Received: by pwi3 with SMTP id 3so1135686pwi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 23:55:46 -0700 (PDT)
Received: by 10.143.163.18 with SMTP id q18mr2848695wfo.319.1284965745984;
        Sun, 19 Sep 2010 23:55:45 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id d10sm6045937wfe.22.2010.09.19.23.55.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 23:55:45 -0700 (PDT)
In-Reply-To: <1284943806785-5548842.post@n2.nabble.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156553>

It sounds like git-upload-pack is not in the PATH of your non-interactive shell. Assuming git is installed on the remote host, you should ssh in to it and figure out where git is installed (run `git --exec-path`), then run your command like so

git clone -u /path/to/libexec/git-core/git-upload-pack ssh://user@host/~/GPUProject/Histogram

In my case that path is /usr/local/libexec/git-core/git-upload-pack.

-Kevin Ballard

On Sep 19, 2010, at 5:50 PM, kinley wrote:

> 
> Thanks for your help.
> 
> Actually now I tried doing this
> 
> git clone ssh://user@host/~/GPUProject/Histogram
> 
> but getting
> 
> bash: git-upload-pack: command not found
> fatal: The remote end hung up unexpectedly
> 
> I tried several ways of specifying the path of the URL assuming that this
> could be a path issue but every time it gives the same error.
> 
> Thanks once again.
> -- 
> View this message in context: http://git.661346.n2.nabble.com/Newbie-question-tp5548737p5548842.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
