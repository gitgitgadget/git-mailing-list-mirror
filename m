From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Tue, 12 Nov 2013 21:19:02 +0700
Message-ID: <CACsJy8BiBmeYuZ3VVyvocB969sYpdFNCOJ8GYSA2his5Vebg=g@mail.gmail.com>
References: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 15:19:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgEod-0001ef-4J
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 15:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab3KLOTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Nov 2013 09:19:34 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:53134 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab3KLOTd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Nov 2013 09:19:33 -0500
Received: by mail-qa0-f49.google.com with SMTP id cm18so2849217qab.15
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=K2hdYuN3/MnZTc9yWQ4AKOjwRFhyf16used2EqsT30c=;
        b=iZ3+WA04ycAR9Nn3L83SDQ33wxiEzbXD0HxhFU4bNE8JclJwqcaJM/MgfVxgRbox7u
         Q4ITeHpom/ks5LmiC7IMbMCp5eoA24jcUz7vFcrHttahfA9U+txkuRVoJ/pkZFZNiqRl
         hxygc9/BNGTREUgykkylGeejYsXSEU9ubdBJsAZiYQLglB3wqSztPcK4R+VuoGiK7xt7
         T/Wn4QQ7ueuniCUVm/7PgiwMGlsJyVp328P9Ete5B4oAqMOzR+5jcJZZYXB7ouoOuMG6
         XHHZ7XblXMnp5/6kj+gMNEIyJ3UsaN729/okInabOMypwUMmK9mUG1n6kHqpuH0flQ0W
         T7sQ==
X-Received: by 10.224.32.66 with SMTP id b2mr59209059qad.80.1384265972714;
 Tue, 12 Nov 2013 06:19:32 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Tue, 12 Nov 2013 06:19:02 -0800 (PST)
In-Reply-To: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237709>

On Tue, Nov 12, 2013 at 3:02 PM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=
=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
> I get this error message every time I want to do a `git push`.
> git version: 1.8.4.2
>
> Is it a known issue? Do you need additional info to investigate it?

What OS do you use? If the repository can be published, please do.
Compress the whole .git directory, don't push or anything. Does the
error message begin with "remote: "? If not you could try strace and
at least identify what files are opened.
--=20
Duy
