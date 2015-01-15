From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PULL] git-svn updates from Ramkumar
Date: Thu, 15 Jan 2015 18:52:32 -0500
Message-ID: <CALkWK0kHQ-qhD3p0_VEhVrbD39yV=F5t2nQZ4D6RKP_gpg9tKA@mail.gmail.com>
References: <20150115090703.GA12333@dcvr.yhbt.net> <xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
 <20150115224652.GA25482@dcvr.yhbt.net> <xmqqtwzr4ofo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:53:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBuE7-0002yL-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 00:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbbAOXxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 18:53:16 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:44637 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbbAOXxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 18:53:13 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so766042iga.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 15:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zBYZcxNepPTJBDdYmIyEo1gzPDvcD7HjftBF5VLzfaI=;
        b=fgloqNZfSq5MpeupkX+17l9NLf6ityUB4O5e9mvAhMzwX0ejkUE56AUNBlrGcYO7/a
         fHmJtLjd2FyRyJo7h4a88vrOgZa01IZ9l/JSz7rav+eEyOt2GO0WQudRA+MuWuEe3WUd
         Yvw9hk36aFnkrSo8v7A87YE4L9SOCtDTygW8xWvKbPdHt8ZCuoGxVCPS+BmdLHHw/3R6
         aZ2h++Tiez4C3FAG9+IUf+u8bCYrcRQ1Es7mN9xFMt+TSXqUncYmzP3vHsNdl7hgszKd
         igt4IBamnm/O42MgTYQF6TNWonT6N+oa0KYpURg8GWBqOLnFljSk6ZFsFW2BZDasaSgT
         pKVg==
X-Received: by 10.50.43.133 with SMTP id w5mr649154igl.44.1421365992718; Thu,
 15 Jan 2015 15:53:12 -0800 (PST)
Received: by 10.107.13.18 with HTTP; Thu, 15 Jan 2015 15:52:32 -0800 (PST)
In-Reply-To: <xmqqtwzr4ofo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262526>

Junio C Hamano wrote:
> To which a natural reaction was "Can the existing breakage
> demonstrated by a test?".

There's a lot to do, if we really want to dig deeper.

The second git-svn-basic test onwards doesn't pass for me, so I really
can't do much in the way of contributing tests until that's fixed.

Couldn't open a repository: Unable to connect to a repository at URL
'file:///Users/artagnon/src/git/t/trash%20directory.t9100-git-svn-basic/svnrepo':
Unable to open an ra_local session to URL: Unable to open repository
'file:///Users/artagnon/src/git/t/trash%20directory.t9100-git-svn-basic/svnrepo':
Expected FS format between '1' and '4'; found format '6' at
/Users/artagnon/src/git/perl/blib/lib/Git/SVN.pm line 148.
