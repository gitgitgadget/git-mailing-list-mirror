From: Edwin Kempin <edwin.kempin@gmail.com>
Subject: How does 'git notes --ref' work?
Date: Fri, 14 Jan 2011 11:21:13 +0100
Message-ID: <AANLkTimL137aFt2dyvdHxTMUjB4diwJQG-FQiYEK8tVJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 14 11:21:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdgmW-0002WV-KC
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 11:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab1ANKVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 05:21:16 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54215 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab1ANKVO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 05:21:14 -0500
Received: by qyk12 with SMTP id 12so3187297qyk.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=G1kMYPX6ESMRJB2ZrmFpgvy0SOuaWzqCkzJZL7Vaap8=;
        b=t85XhaGDn4oWanrOquciXsWImLbAZubNHDoX1kWjY7J6tMsheVh3jVWfGeW4Ie4xaq
         G3FEz5gpMydmPW7zUxWZzcbfSG88qM5zUQLoKL1uUxLc6liE96/+rmGfKkY4CXKqw1cD
         2KVf6TnZbUHDa7jSElNYznSJnjtbdG81w6X2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=hFKGogQUj3ib1hwJThnLgK1uJ48IoiUkUERCaYGohre9PCZ5wtmBPqVCs8hpgZbwVK
         l9/gzbzjyU1dLmJteLBNMKwU3An/MCtgMb65jsDUI5Cb/DfxGRnLBQqXCQQWon3Te+bG
         CjsEQByyHtAM1mjhA5uReq+3KU4CWthvdKkb4=
Received: by 10.224.10.197 with SMTP id q5mr510361qaq.261.1295000473983; Fri,
 14 Jan 2011 02:21:13 -0800 (PST)
Received: by 10.220.117.67 with HTTP; Fri, 14 Jan 2011 02:21:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165090>

How does 'git notes --ref' work? If I try
'git notes --ref refs/meta/reject-commits add -m "reject" HEAD'
then the note is added to 'refs/notes/refs/meta/reject-commits' and not as
expected to 'refs/meta/reject-commits'.

The description of the --ref option says [1]:
"The ref is taken to be in refs/notes/ if it is not qualified."
What is a qualified ref?

Thanks, Edwin

[1] http://www.kernel.org/pub/software/scm/git/docs/git-notes.html
