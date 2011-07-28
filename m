From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Why isn't there a hook for all operations that update the working tree?
Date: Thu, 28 Jul 2011 13:59:30 +0200
Message-ID: <CACBZZX7dJhGT0H8JZRbQ_t9mNnJocaktYAXgMSihfLBuFmL3nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 28 13:59:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmPFk-0006if-Ps
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 13:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab1G1L7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 07:59:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46482 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab1G1L7b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 07:59:31 -0400
Received: by fxh19 with SMTP id 19so1206728fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Gw23q064bpgOUU3Av3gR/YpEFVWVT9Qi5OIpPnzOiig=;
        b=ch3dl0fguH1ALeb81P9VU2mAcDEY3oPPNhQvAS8x/bkXB4fvxCrZTSVjL6oVp47/Fm
         JracEJFlxS9w+hFQPMC3HcJBVtMQ2z9MnyzubzWmKSbrokV/6mgi3pRe11HjvhzKvQxi
         L+p2zCyHby4BzyAu4j5lrZ6KJHPII7YreHdW0=
Received: by 10.223.23.26 with SMTP id p26mr1289094fab.98.1311854370124; Thu,
 28 Jul 2011 04:59:30 -0700 (PDT)
Received: by 10.223.148.78 with HTTP; Thu, 28 Jul 2011 04:59:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178064>

I have a repository where I'd like to run a program every time the
working tree is updated. githooks(5) specifies that you can use
post-{checkout,merge} hooks to hook into those two operations.

However that doesn't catch e.g. "git reset --hard". Is there any
reason beside omission that there isn't a post-reset hook? Or hooks
for any other thing (most of which surely slip my mind) which can
update the working tree?
