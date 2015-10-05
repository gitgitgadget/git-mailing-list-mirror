From: Jacob Keller <jacob.keller@gmail.com>
Subject: git interactive rebase bug?
Date: Mon, 5 Oct 2015 15:39:59 -0700
Message-ID: <CA+P7+xqMFFtVPnZ7Pw9B9oYXHe5N=Ectyd-M+_aGb2NKjRvLAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 06 00:40:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjEQm-0007R0-J5
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 00:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbbJEWkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 18:40:20 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34229 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbJEWkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 18:40:19 -0400
Received: by iow1 with SMTP id 1so166073159iow.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=lpqoHpI5fcmExpfFU96zGHPwv3rEMk9ktKJAblprywI=;
        b=xqlqgE3/vJRZj7y2u/o9HABdTzXyU40Wb2bnCpUWAaGGFyzNK4/l94LnE4UDvy4/2p
         TLgemKI9dxl7VHcqe30LYUajD9NqJ83Zl3rTFB8Man2dSL+/64WdOgz0xdXmVrrQkIe4
         XHT5EgZi2TYjGrwmzT1DVZ64ixj0Ic9+IB5PujuwdWhN8YkwQni9yzjYeo0l+aXFT8No
         Wb4cwH+GgpGs9nB7qMjW36WDeCa0Gm+qJhgQ9aNHMUroBzieEFM9qKZtkt8FOKdGFlLH
         M15ztiGiPdqrM1qMd3erxwNCoZ3LgRn8WPTt8KM3zSBAN3FqJrqPCSzRcl0GyjHt82g2
         2xxg==
X-Received: by 10.107.166.201 with SMTP id p192mr37688547ioe.0.1444084819280;
 Mon, 05 Oct 2015 15:40:19 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 5 Oct 2015 15:39:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279102>

Hey,

I've been experiencing a very annoying bug when performing interactive
rebases. The rebase process will stall after I close the editor, and I
have to kill the process and then restart the rebase using "git rebase
--continue"

I am not sure how to debug this further. Suggestions are welcome. It
is an intermittent issue, so it doesn't always happen but it seems to
happen fairly often (at least every other attempt).

It appears to only occur after an interactive rebase, with an editor is closed.

Regards,
Jake
