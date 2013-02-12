From: Reuben Thomas <rrt@sc3d.org>
Subject: git-diff(1) appears to contradict itself
Date: Tue, 12 Feb 2013 02:49:35 +0000
Message-ID: <CAOnWdojOT61XOY6JxL-3sR4W8N0katShsSLsOsuJ0-PuM9Vemg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 03:50:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U55wX-0001OZ-W3
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 03:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab3BLCti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 21:49:38 -0500
Received: from exprod7og106.obsmtp.com ([64.18.2.165]:52460 "HELO
	exprod7og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751456Ab3BLCth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 21:49:37 -0500
Received: from mail-la0-f72.google.com ([209.85.215.72]) (using TLSv1) by exprod7ob106.postini.com ([64.18.6.12]) with SMTP
	ID DSNKURmtwN5C++B8pP84LJOvv1L3YEQwQRJa@postini.com; Mon, 11 Feb 2013 18:49:37 PST
Received: by mail-la0-f72.google.com with SMTP id gw10so7728023lab.3
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 18:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:x-received:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=IAVfxmlb33JEjQWRh6oMUPkAlsCNmmcm1af6TWYkA1o=;
        b=oKzaCRsytMh1h7ZnmTZ8oMbpGNQmf7rkxDFHJSmls/lFzNtQiHhfh1iPHTf/rDaEEk
         8ZBOFQiZeVeN1lVE0QY5yo1SsJAsaXKhHLF0fM8kRyXE4vqzwaZpvHEv8xT2yXmBv3+o
         h9b8gihFBdBRl5iNMbrb3ktlGNWj8HoCYsxJjHxWyzPWxzxR0trQ+yILxIUhCkLft+sp
         i6+YJ6l0kU2Xw0M8u1W+UPqwPz+T+KNZ+QCHq96s8ye3wuAglh00OTIqOUsTCc3m32jp
         jC6GypBNG41vTbZuPGRzxlzEG2+MKvhtYfKeQu6cyfuP/9O6C6PxiORLgpGpUG4YzoVp
         RsWg==
X-Received: by 10.152.110.167 with SMTP id ib7mr9411932lab.22.1360637376092;
        Mon, 11 Feb 2013 18:49:36 -0800 (PST)
X-Received: by 10.152.110.167 with SMTP id ib7mr9411927lab.22.1360637375988;
 Mon, 11 Feb 2013 18:49:35 -0800 (PST)
Received: by 10.152.135.36 with HTTP; Mon, 11 Feb 2013 18:49:35 -0800 (PST)
X-Gm-Message-State: ALoCoQkTDnfc8yN0oIFoWplV5KrvRG9KwWQDvNiWlYrT3k2Wh1Kv/gzJdTDV7o1GgnJShgGjpzCgPoQyxVN0nd+DusEEk8ay2jg6NDJ2vNCLqqQgEe8lxreocD8fA38LSA2P5lIxmqa3/i4Th8J/jdJhVQoeyYGyiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216113>

Under the --color=<when> option, it says:

Show colored diff. The value must be always (the default for <when>),
never, or auto. The default value is never.

That seems to imply that the default is both always and never. If I'm
right, I suggest removing the parenthesis, and putting the correct
default value at the end of the sentence. If I'm wrong, I suggest
clarification!

--
http://rrt.sc3d.org
