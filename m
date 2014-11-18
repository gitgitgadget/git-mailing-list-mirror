From: Matthew Kaniaris <mkaniaris@gmail.com>
Subject: ag, **, and the GPL
Date: Mon, 17 Nov 2014 20:50:03 -0800
Message-ID: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 05:50:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqak1-0007be-Ei
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 05:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbaKREuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 23:50:05 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:60679 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbaKREuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 23:50:04 -0500
Received: by mail-ob0-f178.google.com with SMTP id gq1so3442012obb.37
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 20:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=NbjdME1gsYepCJr8bI9Nag3E+weTFgmrDPXVP+wQAO4=;
        b=bk5YRwwrAbghySVGRdzHlOYyBL/yuaPR7lxTw0irJ6FhFlcsIO4AEZgmTMy8gWtRuH
         6q+mPBMIEvug8XZzcd85/uHnukbzrpkNr2Mxo8NX6mf08/Pgovv0B199fJU+SaZOlIHl
         CwfgxWQqgWVm14TcIf9iVJfGZ5gvtl7NmW68HJVGoOgDtz77cfkJH6dyB3v1Nj3Y8SG1
         ysDZyDoumNg9vgCD9ngfmo/WIeHbFvDQ3khsJOW1WH0gsb1/ZBh0whtd0oT3ajqef1+3
         +KjGXClkjHFeuWNhFozo2sNwnu3he3LyunHzDu4gxkTlNw1xXCHtdmiRpRVdjFWiQ/QS
         ZNcg==
X-Received: by 10.202.71.212 with SMTP id u203mr10442451oia.54.1416286203518;
 Mon, 17 Nov 2014 20:50:03 -0800 (PST)
Received: by 10.76.100.101 with HTTP; Mon, 17 Nov 2014 20:50:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Silver Search (https://github.com/ggreer/the_silver_searcher), is
a small, open source, cross platform searching utility written as a
replacement for ack.  One of the major benefits of Ag (and a source
for much of its speed) is that it obeys .gitignore.  However, Ag
currently treats gitignores as regexs which produces incorrect results
for e.g. **.  I'd like to add support to ag to obey the .gitignore
spec but I'm not keen on implementing yet another fnmatch clone.  Ag
is licensed under the Apache License Version 2.0 which to the best of
my understanding is incompatible with the GPLv2.  Would you grant me
permission to reuse wildmatch.c (and necessary includes) for use in
Ag?

-Matt Kaniaris
