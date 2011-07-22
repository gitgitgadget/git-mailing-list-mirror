From: Ori Avtalion <ori@avtalion.name>
Subject: reset: silent for some commands, verbose for others?
Date: Fri, 22 Jul 2011 19:38:42 +0300
Message-ID: <4E29A792.9020805@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 18:38:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkIkW-0001Av-Dn
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 18:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab1GVQir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 12:38:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57167 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1GVQiq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 12:38:46 -0400
Received: by wyg8 with SMTP id 8so1617198wyg.19
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=08HJHft5LbW/TxZwXZWJ/ZUZ8WC0mdOGisoQtock8ZE=;
        b=A4J4ERd2kceI6yGaXlTpw1WNL8dKEniiFgq4s8A7BXBZRyGBdUKXBkv2TSJRXgeFIe
         nBThMZzabui1HxMYE8O6ZaE6jGpfkMi+6he6/L7lvNjie6x42zQljVRSUBNJTd/4KzA6
         RPy1/0SMr/GiDpxCWnxTRynefv0vAoSxCO4j8=
Received: by 10.216.88.132 with SMTP id a4mr1433664wef.31.1311352725217;
        Fri, 22 Jul 2011 09:38:45 -0700 (PDT)
Received: from [192.168.1.55] (bzq-109-67-20-81.red.bezeqint.net [109.67.20.81])
        by mx.google.com with ESMTPS id w8sm1656911wec.24.2011.07.22.09.38.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 09:38:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177647>

Looking at the reset's command third form:

  reset [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]

* --soft, --merge, --keep are silent.
* --mixed prints "Unstaged changes after reset: ..."
* --hard prints "HAED is now at..."

If all of those commands move HEAD, shouldn't all of them print "HEAD is
now at..."?

Why should only --mixed print the list of unstaged files? e.g. Isn't it
useful for --soft to give a list of "Staged changes"?
