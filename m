From: Jan Niklas Hasse <jhasse@gmail.com>
Subject: Error on push (unable to create temporary sha1 filename)
Date: Tue, 23 Feb 2010 22:11:31 +0100
Message-ID: <8dacd7b31002231311q46c1c3b9o63c57fabe696f2ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 22:11:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk22b-0005ra-Pa
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab0BWVLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:11:32 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:57472 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0BWVLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:11:31 -0500
Received: by ywh35 with SMTP id 35so2224859ywh.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 13:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=1UiPQO8XezmaVrQeT8jaVECW0AaO/iKK/AuJBf95cUU=;
        b=cw8VrhtJXHjPwqSm9csK1/q/sy9nZIWfSmkLnkiX0Y9gc3F0/EWT1mppZB6XLLvX6W
         o5MmqfgdAKQ9R0pktNn53RKtNUvkp+WOLw3Mj19KYNMrs7EMOhCtFdLUv8n6gMfJSfQ/
         BH73o0MZvQxLu1UYynVtq4VcjP18WdtFNZyQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=mWBvxezclouwWAk96IR9hO89Qs+STGfzw9o4J9JrJ3UZ5do7DP5wFW+QrEtOc/M3Dm
         DKZeImLM+NWutijtOF3AI++n0CdaM7v1lJphweP++gTTrtV8TMfdQ68WYgKveiZADvNl
         /AyMAO7rhpeCxBoZwujQJQPSIIEuELErr0ZqM=
Received: by 10.101.128.26 with SMTP id f26mr5086127ann.38.1266959491297; Tue, 
	23 Feb 2010 13:11:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140840>

Hello everyone,

I'm new to git and recently set up my own server where I can push to
via ssh. It worked fine for several pushes but suddenly I got this
error message:

git push origin master

Counting objects: 37, done.
Compressing objects: 100% (27/27)
Writing objects: 100% (31/31)
Writing objects: 100% (31/31), 5.59 KiB, done.
Total 31 (delta 11), reused 10 (delta 1)
error: unable to create temporary sha1 filename ./objects/0e: File exists

fatal: failed to write object
error: unpack failed: unpacker exited with error code
To git@myserver.de:django.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'git@myserver.de:django.git'


I didn't changed anything on the server and haven't done anything
special in my local copy (just added/edited files). How can I fix
this? (Already tried cloning my repository locally and push from the
new one).

Thanks in advice,
Jan

PS: Please cc me in your response since I'm not subscribed to the mailing list.
