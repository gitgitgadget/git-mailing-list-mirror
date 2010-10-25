From: Kynn Jones <kynnjo@gmail.com>
Subject: Are "private blobs/trees" possible?
Date: Mon, 25 Oct 2010 15:19:49 -0400
Message-ID: <AANLkTimQ7Z9Cd2yKw5jFD6UBzFRBZk_-SpC7jc6+JACw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 21:20:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PASaM-0008UQ-Hd
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 21:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab0JYTTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 15:19:50 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44006 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab0JYTTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 15:19:49 -0400
Received: by qwk3 with SMTP id 3so1733707qwk.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=wyrIeF+uBh3i+Jt9CA5/sQGBpJ5n0o0oPIcuJroFDBY=;
        b=N0WL/ocndE4UkAEB3XAQPUnCzuJz1GVjxNb6PReYa8/rpD3ie0sZ+lhj9pMPdVZLju
         HjvhE6jkjamXHW85apKouqdGPyZEyAGlDq4jr0l/EzqCuRI+m7iu/vYSUMiKtrRVf/RL
         Fn6eZqIf9iiwJaXo/go1P5uR+D18QFNIamAQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=w+83hlW0o4fzdrlx+ZXEO19MH4U4/AQl4a/8sfVsGKrB7ndXt2On05rAEcrwjg52Qt
         8jofuDNkq1DbT8qRlI1dun2SeROs7++EmghPQw0xFQOvvOcr1rl8p5iQcMbNgt52MGqP
         hAdUQfdHxSdKE1MeNSfih7IRCuJltai5/CnWQ=
Received: by 10.224.76.68 with SMTP id b4mr552326qak.383.1288034389190; Mon,
 25 Oct 2010 12:19:49 -0700 (PDT)
Received: by 10.229.232.83 with HTTP; Mon, 25 Oct 2010 12:19:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159968>

There are some files that I want to keep under local git control, but never
push to any remote repositories.

What's the best way to implement this idea with git?

The best solution I can think of is to put these files in some
git-controlled directory that is not below the "main" working directory, and
have an (ignored) symlink to it in this working directory.

Is there a better way?

TIA!

~kj
