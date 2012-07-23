From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/5] difftool: Eliminate global variables
Date: Mon, 23 Jul 2012 08:54:44 +0200
Message-ID: <CAHGBnuMvcW-yZQ7viUfZg+aomk=KyCm3kEdUD7TizYdLRYQUXA@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
	<1343014940-16439-2-git-send-email-davvid@gmail.com>
	<500CEB9F.4030406@gmail.com>
	<CAJDDKr7oDc2CxoiWqUMri93FM3WHecanCYBkezLYY1A_BZXdxw@mail.gmail.com>
	<CAHGBnuM9LgeLiOoFfny8NbF547okjQBLDXfzrbTj6vt+d=M4Eg@mail.gmail.com>
	<CAJDDKr77d0vot30txya7Z0QpOj2xgV4-0ZhOuyXiJbG2OSUNQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:54:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StCXb-0003Sf-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 08:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab2GWGyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 02:54:46 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51517 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab2GWGyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 02:54:45 -0400
Received: by vcbfk26 with SMTP id fk26so4434352vcb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OYRuvRy2oDhIKEwWJrGKbVq9H7WWqAlSgFpn6KTO6g8=;
        b=Xs6h7fZczkkXr4ch42EYcZgkOWuH4DuGxZ5TpVL7ZcucWmaryMXyyK5liqc7lwLFWL
         Ym25u0R94BHL6Q7FeMlrPe0g7QmLDvYivmAZkqM+xBM7vjuGNj9JLgMI/RQLOo0gSCwn
         fKj1BLvW2VypAN0+562yyOlH/3c8J3LW2jd8Xaus0wZiaWJwHoTg3Grnmmw9XFLazT7Z
         nwQ43ScVslKghg7hWbNu2bftIYLI9YXQ8W0Jl0IJEr2nWXYWAN6IMrJ+9wsiBwfXrFMl
         dniBzgQ6upE7on8dctMV6uBGhxCTRWT03wvEKVdQCm/x6F4ijCqNWX816rjCi/Cis30i
         nbJA==
Received: by 10.52.174.81 with SMTP id bq17mr10126025vdc.119.1343026484264;
 Sun, 22 Jul 2012 23:54:44 -0700 (PDT)
Received: by 10.58.35.135 with HTTP; Sun, 22 Jul 2012 23:54:44 -0700 (PDT)
In-Reply-To: <CAJDDKr77d0vot30txya7Z0QpOj2xgV4-0ZhOuyXiJbG2OSUNQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201912>

On Mon, Jul 23, 2012 at 8:44 AM, David Aguilar <davvid@gmail.com> wrote:

>> Well, I'm not asking for a test. From my side, I'd be happy if you
>> could just try it and confirm that it works, as I currently cannot
>> easily apply your patch.
>
> Heheh.. I was hoping you could provide a test ;-)

;-)

> I just tried it now.  They work outside of a repository.

Great, thanks! I'm dropping my patch then.

-- 
Sebastian Schuberth
