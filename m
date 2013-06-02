From: Peng Yu <pengyu.ut@gmail.com>
Subject: Is there an API to the .gitignore capability?
Date: Sun, 2 Jun 2013 09:40:03 -0500
Message-ID: <CABrM6wnJYSGGsj=ZxHOFRMmDCSgsU0dFwxus=h1PtVazgpg3ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 02 16:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj9ST-00006j-Qy
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 16:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab3FBOkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 10:40:06 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:48394 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab3FBOkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 10:40:05 -0400
Received: by mail-qe0-f51.google.com with SMTP id nd7so1830529qeb.38
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=iKpI8vXGKKm5x+tgRIP5HwIx18kNfFyLXZZ3PPEEQLY=;
        b=wDQOPwgPYl3obxhxOJfJwuDpHH6M+Q3cF/7y5omOZKoSQA8oYKzLlLa7bfY0mPvIUa
         uouk1mC6d8hEKUaIM++spqFxWQdprEKshMk3V4Vj7A6Mdb5XIgtXxQwwJ0+Usl0+dJQB
         chCWsCh5r/i/FRQ7f8lyYFUbfVJK4V+pUWAqdsjZJ/UTwcIK0cI6al6DpPQyyBvsATH4
         BtibByvbN4y8951rPMpcr4gUiUPQAd9kSMlW4VJf5D+0w4grbuwRy4yTosGtnLtTWdQe
         3FIw/ANlet/XJc/g14MX4PFUmytx1WaepB+Jl5ZD1nhpj6HBiD83VAWEuBOiZWTwtd9Z
         Mj7A==
X-Received: by 10.224.78.193 with SMTP id m1mr15370456qak.79.1370184003663;
 Sun, 02 Jun 2013 07:40:03 -0700 (PDT)
Received: by 10.224.88.5 with HTTP; Sun, 2 Jun 2013 07:40:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226158>

Hi,

.gitignore is a flexible way to customize what dir/file to search or
not to search. So it is of general use and is more flexible than what
is offered by "find". I'm wondering if there is an API than I can use
besides using it within git. Thanks.

-- 
Regards,
Peng
