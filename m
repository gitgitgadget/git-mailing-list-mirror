From: Eric James Michael Ritz <lobbyjones@gmail.com>
Subject: [RFC] git rm -u
Date: Sat, 19 Jan 2013 16:35:18 -0500
Message-ID: <50FB1196.2090309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 22:41:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwgA4-0004Zg-Ru
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 22:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677Ab3ASVkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 16:40:51 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:48931 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3ASVkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 16:40:51 -0500
Received: by mail-yh0-f52.google.com with SMTP id 24so22910yhr.11
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 13:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=3HJPrm22S6m682VY/Xf6H7DkQgH9yBiTZ+AJpZsBwMU=;
        b=hn7aFBzbuAJLMaBMVYDdebPk1Y6q4F1fBrCsne+vbn7PhgXHq0fy3eLhPe9eNq2Dwe
         H02gRg+ev61h7PObvMtpOnllJCejXtT6wh2uqxJFrLZALTxBiAvlhuK4swxc3huUrB7Z
         tjDbgJXT6/ZwvdoPIgFOozh4AWX8QxOOaFVC8VidjhW1XHYDsIwhVYrWvQwyxqDyLYWY
         kk+A5/9yfcJtdrzxNe906+ExRntv5ehIOo3+i2VnrRi/IHzEFHQpjgMCA7xt+Zu4tSaJ
         jZEIrfwV608Dnlw1FAFRjLUd+jptRe5mcKT6lFFw7iuIIu3eK1kwoRmiaY2XpcSrNB01
         rqQw==
X-Received: by 10.236.103.70 with SMTP id e46mr15790340yhg.12.1358631319861;
        Sat, 19 Jan 2013 13:35:19 -0800 (PST)
Received: from [192.168.1.102] (97-81-212-183.dhcp.hckr.nc.charter.com. [97.81.212.183])
        by mx.google.com with ESMTPS id i26sm8631899yhc.10.2013.01.19.13.35.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jan 2013 13:35:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213988>

Hello everyone,

I am thinking about implementing a feature but I would appreciate any
feedback before I begin, because more experienced Git developers and
users may see some major problem that I do not.

Earlier today I deleted a file from a repository.  I deleted it
normally, not by using `git rm`.  So when I looked at `git status` on
my terminal it told me about the file no longer being there.  In my
sleepy state of mind I ran `git rm -u` without thinking about.  I did
this because I have a habit of using `git add -u`.  I know `git rm`
does not support that option, but I tried it anyways without thinking
about it.

When I came to my senses and realized that does not work I began to
wonder if `git rm -u` should exist.  If any deleted, tracked files are
not part of the index to commit then `git rm -u` would add that change
to the index.  This would save users the effort of having to type out
`git rm <filename>`, and could be useful when a user is deleting
multiple files.

Does this sound like a reasonable, useful feature to Git?  Or is there
already a way to accomplish this which I have missed out of ignorance?
Any thoughts and feedback would be greatly appreciated.

--
ejmr
=E5=8D=97=E7=84=A1=E5=A6=99=E6=B3=95=E8=93=AE=E8=8F=AF=E7=B6=93
