From: Carsten Mattner <carstenmattner@googlemail.com>
Subject: git-completion with bash alias
Date: Fri, 18 May 2012 13:35:24 +0200
Message-ID: <CACY+Hvqd6L7gWgDBvjPmLPsfA2o1CVKuqkDZ_j7XYf=WjuwvKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 13:35:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVLT5-0004YQ-I8
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 13:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761741Ab2ERLf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 07:35:26 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:44134 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697Ab2ERLf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 07:35:26 -0400
Received: by gglu4 with SMTP id u4so2695174ggl.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6hV/1wpo34epSLPzRkw5xItNvzzm7vGPIID66w7x6gE=;
        b=EfKOq1UWsFlt2CPwaRIFz9dZfR8CmSI1H4Bz7zhcvogBpBQ+eLb3qIW0aVIQPq9v7d
         93d1o2uPn1PPyoW3nPf+Umsqwlh6eBZlqoD4d/6O5AZ2XhDKwM7mzLiIE1GKlVWQuh6m
         V5PytmTsw6tDHQ0vTL/vNUJG2JKkYvX7QPW8tprsSMOT55MhxiiM2rsHUvppHnuuaIsS
         JMsIJvBxkEeB6jpA6zNjWJSirxOJiZGGtLYb1pbozN4/yxxiRrN3kMdgM3+k5RQY/lxb
         d6xAxsjg7q7dPda63Thg4vthR8ZmwDtnOIq6wAP4i/0ES8Qrw3EZfc41ZOoSvvTILiBF
         JDZw==
Received: by 10.50.47.230 with SMTP id g6mr117803ign.74.1337340924957; Fri, 18
 May 2012 04:35:24 -0700 (PDT)
Received: by 10.50.6.231 with HTTP; Fri, 18 May 2012 04:35:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197948>

Completion works when used as "git checkout foo" but fails with
"bash: [: 1: unary operator expected" when trying to complete
via a single character shell alias like "alias g=git" as in
"g checkout foo".

git version 1.7.10.2.548.g9de9681
