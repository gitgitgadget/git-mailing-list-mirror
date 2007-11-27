From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: lost all my patches again
Date: Tue, 27 Nov 2007 18:12:49 -0500
Message-ID: <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:13:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix9c8-0008Hf-48
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 00:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbXK0XMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 18:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755186AbXK0XMv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 18:12:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:4378 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbXK0XMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 18:12:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1047379rvb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 15:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RuUpW2kK5chmkEv/EwF2+zfIJKqeYsl+DwiyI+MOWRI=;
        b=vvvmpC2xkWUwOWnwwEPuSAUdiFiUX1kti9hJBbVHEidaK0QR+vt9rnG2OdaV6YzDGDYdQ4ZM0qV+UG24nj9adwBGetQiEfM8xroZXqI94K1GePJeIT/VRe4WRfog6CKx3x1iiYo51wrCQAV9AV8kjy8r3JGitKwG0puZ9oRiI6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wfz5H67sqc2O9q6F1dGjlQTkfGuVV+7xNv79wmzvJZeYSDaxsAgTUOxbERHeZnAgBCiaduea2HATTeiHhIWQ5OJZK7DRlrVAnmXC/1XUvOa85TPT2XKG3ToiJ3DgujY+9hcxF0o6MH40kIwL491FTb11jM9h7ASyZ6zoqUv9kQ4=
Received: by 10.114.177.1 with SMTP id z1mr37016wae.1196205169073;
        Tue, 27 Nov 2007 15:12:49 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 27 Nov 2007 15:12:49 -0800 (PST)
In-Reply-To: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66270>

On 11/27/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> My fingers are too trained in doing "git rebase linus/master" instead
> of "stg rebase linus/master". This has resulting in me losing my patch
> stack again. I updated stg to the current version and tried "stg
> repair"  put all my patches are still empty.
>
> What's the easiest way to recover?

I recovered, which wasn't too bad since I had exported the stack about
an hour earlier. I played around trying to recover the tree for a
while and then gave up and whacked it. I used my export and then I
extracted the last hours worth of changes from the old tree.

As Jakub pointed out to me "git reset --hard $(cat
.git/patches/<branch>/orig-base)" would have recovered from the rebase
command. But I had already typed 'stg repair' which compounded the
mess.

> Can we add a check in "git rebase" so that it will refuse to run if
> stg is active?

This is way too easy to do. One simple mistype of 'git' for 'stg' and
you're in a mess.

-- 
Jon Smirl
jonsmirl@gmail.com
