From: neubyr <neubyr@gmail.com>
Subject: adding/tracking remote branch
Date: Tue, 5 Jul 2011 17:56:07 -0500
Message-ID: <CALFxCvzNSbxP64zGp93fu=fF9h4eaoUBcyxZUyJFvWSZ3-CUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 00:56:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeEXO-000857-IM
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 00:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab1GEW4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 18:56:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40092 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1GEW4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 18:56:08 -0400
Received: by yxi11 with SMTP id 11so2083611yxi.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=sYID55KtuQ7mFFQae45rCAMKjfv60w2+9PdLhO8C0xw=;
        b=rq0TkD43CT21F0j9WEf4z21M3AS8eUVovOAURFBgj/XdrInVC8aweP9+6sRL9VBPKV
         OruTj9fnfYGNJx/Jnw+GcpYpE3aCkixwhC0cqEmydVfIwl4LfD8owdViCvX5qUNMD20B
         ON7fmoOsUtIvkWcrgBaRFwWT3qGmMFESfgfdk=
Received: by 10.236.177.106 with SMTP id c70mr8265118yhm.307.1309906567248;
 Tue, 05 Jul 2011 15:56:07 -0700 (PDT)
Received: by 10.236.95.49 with HTTP; Tue, 5 Jul 2011 15:56:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176630>

Hi,

I have a git repository setup with existing remote origin URL. I am
trying to add a new remote URL and would like to get this remote's
master (or any other) branch in my repository. I tried following
commands but it didn't work:

$ git remote add <remote-name> <remote-url>
$ git config branch.<branch-name>.remote <remote-name>
$ git fetch <remote-name>
$ git checkout -b --track <branch-name>
refs/remotes/<remote-name>/<remote-branch-name> # here I got branch
started from my current working branch and not with remote-branch
contents

I appreciate any help on right set of commands here. What am I missing here?

--
neuby.r
