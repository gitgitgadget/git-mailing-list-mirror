From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCHv1 2/3] git-p4: test with limited p4 server results
Date: Sun, 7 Jun 2015 12:11:06 -0400
Message-ID: <CALM2SnZk1vHCxg-47=tktzpvULw9+SaKQNBNNoFre=aMPO-cUg@mail.gmail.com>
References: <1433672505-11940-1-git-send-email-luke@diamand.org>
	<1433672505-11940-3-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:11:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1dAH-0004iH-3X
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 18:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbbFGQLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 12:11:08 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34165 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFGQLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 12:11:07 -0400
Received: by payr10 with SMTP id r10so79553556pay.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9D0AJBQ3Wrbwx4cRoMTLx9MZHYkgit4h6+vA5i7rIbw=;
        b=WQaQAlTv8/PkliN8riVC3imJNAIZ4JZc7LY1iwM5WPrPL0IptpfJ2k1KMe2FkHTrOR
         k8OrXEO7PdAv2z9NzyQx6n9+Hy8pG9bk47Kugk+t07RBC4RQ9nYvRkl3TBisPASkhvbO
         1rNURM8vsUtVhQmk7zNjYHgwz2ymA7pVrF09YyPoRkS4ZEpoX9Ez9EmJpHvNmG2kN3SZ
         24kreTyZgKBTOLUVip9lfd7cyXo23CebdEARZWErgrdLrWIP2RhFQ5A+x8Fxfi+rhsAf
         /QB5jGbVTHHmKJQ858lUTFSUvPvH44asznH97jorwX4ykju1tx4tam2FyeaUCnA3nfDx
         aK7g==
X-Received: by 10.66.147.39 with SMTP id th7mr17046422pab.2.1433693466660;
 Sun, 07 Jun 2015 09:11:06 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Sun, 7 Jun 2015 09:11:06 -0700 (PDT)
In-Reply-To: <1433672505-11940-3-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: DIg72c5IpI0jfWUpe9IwwyxderY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270973>

LGTM. That's great adding a user with the appropriate restrictions on
it to really exercise the functionality.  -Lex
