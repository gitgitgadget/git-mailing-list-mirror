From: "Kevin O'Gorman" <kogorman@gmail.com>
Subject: Why is this known by git but not by gitk
Date: Tue, 27 Nov 2012 09:50:32 -0800
Message-ID: <CAGVXcSYQprvqacDV_EjVSboiao3J8CcOoHwFeUgjJYoyos4e_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 18:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdPJ4-00084G-6S
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136Ab2K0Rue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:50:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33007 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833Ab2K0Rud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:50:33 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5294695bkw.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 09:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=D8yPkYntb5WLRxtpjByxz3FMvHcktLwDjRwjkrWvYqs=;
        b=noQBq2GoqQWIjiWl22SyPLyq3aXM6T4n0fMqgT6TKtDIcvVP5zfh73T4YAteCriAhR
         71gRMKvyHEY/jU9gL5Z93X9Hs2c8SYJBqbGGB+1bC6zCvlV4ZNQOaiTzqYB5E2KIOUV/
         WMYo2TmHyAhgavZmOOw0+87rzV7OkHEts+eNoR88DuuEyhgGQFrN0xAVu5VRglPcblEb
         8hCBbjEnUYg+Kb3TjImHaj5v8OFV4ky47DnGp6UH7sEs1+AE+msTKG5ycKVgicJqQu7y
         QHgqSoHSqa5du2K1/9E9o8T7sCJjo7MhVosWTlROgfo4S+7bY17640Egc6Vh3uHilLGI
         EL8w==
Received: by 10.204.154.202 with SMTP id p10mr2907238bkw.29.1354038632426;
 Tue, 27 Nov 2012 09:50:32 -0800 (PST)
Received: by 10.204.41.72 with HTTP; Tue, 27 Nov 2012 09:50:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210578>

I just converted a SourceForge CVS repo to git using cvs2svn.  One
directory in the result is named CVSROOT and everything would be fine,
but I wan to know why gitk does not see it.

Git itself does not report it either, but it lets me "git rm -r
CVSROOT" and stages the change.

I just want to know what's up with this before I commit myself to
using this converted repo.

--
Kevin O'Gorman

programmer, n. an organism that transmutes caffeine into software.
