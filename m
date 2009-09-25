From: Marco Costalba <mcostalba@gmail.com>
Subject: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 10:40:21 +0100
Message-ID: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 11:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr7Hw-0000b7-Rl
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 11:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbZIYJkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 05:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbZIYJkT
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 05:40:19 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:56986 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZIYJkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 05:40:18 -0400
Received: by ewy7 with SMTP id 7so2403634ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=89A7mxnGvJVcZqvls2K4c0eJqSKvrJj5uE5u9c9IWsw=;
        b=Tg7iw7x8p/DBtL2wYz7bkEdW2i4Pg8uAaOCt0IwZeTorV3CGAieLPpCAytXXeajxiy
         ZVJ0gWyeRzekfobszU0HPdRzPCzbZreFQc5nf+Rzms/+FAlf8bViX9uhM4mWioZkHN+B
         LDjfSUwtOuE6Y48OnKG07jLqj1alW97kF4AKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=O8ZYxkNy6XpdWNZCJS9lss0AGw9GNS/YiQMcHcFeH6Esy3cRYEqrORkSmAkLOvHpkB
         DTcyw+ugPCoWk1HtilDx7+8NmdPhuBg18/CiKzbtjZostAslfmw7D7CujB7fMp2kjzUR
         7VA9pq7ati+ZNUBdHZ2L6QYjNDqvD7HGleY+k=
Received: by 10.216.39.141 with SMTP id d13mr980310web.183.1253871621123; Fri, 
	25 Sep 2009 02:40:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129070>

Perhaps is a dumb question, but for me is very new.

I have download and installed msysgit:

git version 1.6.4.msysgit.0

and now

git log --pretty=format:%h

prints a list of abbreviated (7 chars) SHA instead of the full 40
chars as I want.

I didn't change anything in git config and I am not able to restore
the original (correct) behaviour.

Could someone please help me on this ?

Thanks
Marco
