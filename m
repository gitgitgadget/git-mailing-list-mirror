From: Maxim Treskin <zerthurd@gmail.com>
Subject: FEATURE REQUEST: Comment assignment on branches
Date: Mon, 15 Mar 2010 14:33:29 +0600
Message-ID: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 20:08:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrFeG-0001sN-Hw
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 20:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965711Ab0COTIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 15:08:13 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:56747 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965673Ab0COTIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 15:08:13 -0400
Received: by ewy20 with SMTP id 20so1255514ewy.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=dVPj6LkQEeeL5IsvlATZezdlPotGtjS3PkKv8LHfAS8=;
        b=CxH7VSt3z9QJv5WiDhtUId6eUJL4X3QdBWNu6srLqLbGDNLan3Zv50v+WsJhPEPmns
         4amQ3lv1YFsWT3lzX/QVPQIwIpm0qxNozEnAcQKsoiBVr0LVX/1zrnyP7UBDBUjEo0Ys
         J7WY4XpTIDywib6FbqBiwJ1ptFJpYPDK7rEO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ocyQcp7WHNIlmrXvCj+Ndvf0WgU6U9SE5qy8bjr+13brLuDUm6jdFyg8z7d5IfHxus
         jdKZpftW3nsZg0tQENKSqRpNgxWjjdFjmeeXstv8d6dpSIGFC6eoMgCFOyT5af9JJAsi
         WBS61oCOMRr2oSQ/Uj9uHQn2oNd2T6tCPIg2c=
Received: by 10.213.68.129 with SMTP id v1mr2010780ebi.15.1268642009192; Mon, 
	15 Mar 2010 01:33:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142245>

Hello

Is it possible to add comments assignment to branches?
Something like:

$ git branch --comment="New branch with implementation of some features" br14

$ git branch
  br14
* master

$ git branch --comments
  br14           (New branch with implementation of some features)
* master

and when configuration variable branch.comments == true, this behavior
is default.

Thank you

-- 
Maxim Treskin
