From: =?UTF-8?B?0J7Qu9C10LMg0JrQvtGF0YLQtdC90LrQvg==?= 
	<kohtenko@gmail.com>
Subject: Fwd: git svn die signal 6
Date: Mon, 15 Jun 2015 16:54:35 +0300
Message-ID: <CACbO7BMfDSqTAzNWKhLqgP+eTmsnFTmyDjt7WoZ7nMdJfp-sCg@mail.gmail.com>
References: <CACbO7BMtsgu2eJHa4NBmeZ2-mTDk23NZhhf5f7MM7+_1X5+zsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 15:54:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4UqX-0006cK-JA
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 15:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbbFONyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 09:54:38 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:32899 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbbFONyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 09:54:36 -0400
Received: by obcej4 with SMTP id ej4so64539841obc.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=/cIaMwkfyupD30qCf1YKkzyHnWDEsuYblR87CCoDvC0=;
        b=jeImas1uSEWe99VLyDxtqk84l4LGVebU2mnVXfaaMJ2N1+JHd4FBhfNJqp5o01aMsq
         VumLduo/K9ikqK24i8629hGUxO8EfGVHp5eatsw1mLdZ9mMn4IxQnFzmbpd63vkqcm3O
         ydHXVyCG2hbIoU56Au05SWX3HLzePdzo9k78x47l2I01rJzl6F2CqKrMv0MO4d3riLLC
         ZFyDCJbl+WtjGYPomV5Rwsg8lBejsI692GbZpGEnfsMWfSf8Vqdga7rdVvhogMutQjxc
         wJm3t04avbx+JqCMhbMZ4AuGx++jYdfC+9y+BUNYLf1TWcay7vehwnGFyQWE/RiXRAli
         4XOg==
X-Received: by 10.60.101.195 with SMTP id fi3mr23950505oeb.65.1434376476009;
 Mon, 15 Jun 2015 06:54:36 -0700 (PDT)
Received: by 10.76.41.202 with HTTP; Mon, 15 Jun 2015 06:54:35 -0700 (PDT)
In-Reply-To: <CACbO7BMtsgu2eJHa4NBmeZ2-mTDk23NZhhf5f7MM7+_1X5+zsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271685>

Hi great "git crew" member :)
I found small, but annoying bug in 'git svn'. If you would try to make
any commit with new files (or delete/modify files) which contain in
name "@" sign - you'll see crash with minimum information about what's
just happened. Such file names are very useful for iOS projects when
you can add same pictures with different dimensions with suffix @2x or
@3x. In guts, svn uses "@" sign for pin version of file and it's
probably confused if this sign presented in file name. For committing
such changes thru svn you would use "svn add 'image@3x.png'@". This
will prevent such problem.

I hope you can easily find out how to reproduce and fix this issue.
Please, feel free to contact me for any details about this.

Best regards
