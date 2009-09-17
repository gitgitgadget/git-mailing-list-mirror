From: Rob Barrett <barrettboy@gmail.com>
Subject: Usability question
Date: Thu, 17 Sep 2009 20:01:00 +1000
Message-ID: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 12:01:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoDnc-0000jv-E8
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 12:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbZIQKA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 06:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbZIQKA5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 06:00:57 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:37568 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbZIQKA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 06:00:56 -0400
Received: by yxe12 with SMTP id 12so351346yxe.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=dwOaSPNDJxxELv+ZyEd4APVV7h7PkKUjLArfpjNul0Q=;
        b=ejt7FaUKdxumcD8Xo/Sun+uje7qUDbh3CkWKkdaAxvT9nt+Mo44ApKTkYzh1TK3UKG
         YYmpysWvBqjOXhsNCRGWT6Kd2c+wkP+ITKhWwmvJ5mzbvA9MUEpMbvTD6GqvGY1YnJQ9
         cdn4hfZwIl/Bsw8S0yUh113vhx+UEvEMzl1H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=UFxPoUfiVZNgZYaiMe8NSzMat6I6naNtyrMNMZtZ/0FNQ9hwIf3Tp2unRKfe2tmvAF
         8zC8/K0QBFDtIkRU8RCRkkEbkRlJYIMd/gFFN+QTgPIto3PVriRciRztn5PoFdcmWIR3
         oJTlX0yVEcpvghH3NSRFam2SpTmPeaIotmYH8=
Received: by 10.150.81.5 with SMTP id e5mr794600ybb.146.1253181660509; Thu, 17 
	Sep 2009 03:01:00 -0700 (PDT)
X-Google-Sender-Auth: 37173707ad711bea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128740>

When starting with git people almost always ask some variant of "how
do I know whether this option should be prefixed with dashes or not?"
i.e. git reset --hard vs. git stash save --patch, which coupled with
other path, sha and treeish args make things a bit more confusing.

Not sure if this has been discussed before? If it has point me at the
discussion and I'll go look at it -- no need to read further.

And people stop asking the question after they get used to git - but
that's not the same as being usable.

Out of 60+ commands, most take the form
git <subcommand> [--option]
and a few take the form
git <subcommand> subsubcommand [--option]

(a quick scan gives: bisect,bundle,reflog,remote,stash)

My questions:
1. What is the distinction that makes the 10% special enough to get
non-prefixed options?
2. Is it worthwhile? Wouldn't it be better if to shoot for more
consistency / less complexity?

Rob
