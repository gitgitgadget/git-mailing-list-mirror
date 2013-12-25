From: Roman Kagan <rkagan@mail.ru>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Wed, 25 Dec 2013 17:13:18 +0400
Message-ID: <CANiYKX60-ONS8Zc4O9WkieXaMWWqyqkq+ZdVy02EPUzx7XSEbQ@mail.gmail.com>
References: <CAM-uYMiLpsQdN41Gs8iJOT-v0qKgod2vEeoC3C+QJ5+wKiVK-Q@mail.gmail.com>
	<1387919476-27921-1-git-send-email-rkagan@mail.ru>
	<CANiYKX40naaeUxaZEnYBcb7o5h7A9HPq5inuGjXn28R3NtzT1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
To: Benjamin Pabst <benjamin.pabst85@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 25 14:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvoHO-00010T-8P
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 14:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab3LYNNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 08:13:22 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43244 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab3LYNNV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 08:13:21 -0500
Received: by mail-qa0-f53.google.com with SMTP id j5so6929805qaq.5
        for <git@vger.kernel.org>; Wed, 25 Dec 2013 05:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YlaWvbev5Lh+gF37zh2+N0mpN6azlqvzeYaLNNA9LdY=;
        b=oqTlAaD7jdM82BQApfjljRSwPgAZO1PPRuN+BxYeuHE81ACjaHeQqXHGsa/SAxkv5v
         1V9MBjLSFBoqwx08Nned0sZmC8Q9YOoQHBDi2/phzoxNJDVAyXdUAA3ifohkNKcuOqBh
         ewcpvToqjUa6sQzm0jGIaottYaccUrueUkac+zM26iJLirdrYud+e9DvRy1Y/YIwu+u5
         4wapuOU/T4j9Kr00mks+0A70mm18jV6NokXGbSSVXZ2UAIKemoL2rWgoQil213azbFrt
         xXQGLrrWlEJ3Z6xF+JdI8TNbwXNflBou1S9c/3G4Y4zdoJZuKtFUrm/PfNvscGdZylAt
         5iEQ==
X-Received: by 10.229.65.130 with SMTP id j2mr61940650qci.6.1387977198812;
 Wed, 25 Dec 2013 05:13:18 -0800 (PST)
Received: by 10.224.98.146 with HTTP; Wed, 25 Dec 2013 05:13:18 -0800 (PST)
In-Reply-To: <CANiYKX40naaeUxaZEnYBcb7o5h7A9HPq5inuGjXn28R3NtzT1g@mail.gmail.com>
X-Google-Sender-Auth: gnS-X92kBSOnJYpluoJE0l44lbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239674>

2013/12/25 Roman Kagan <rkagan@mail.ru>:
> 2013/12/25 Roman Kagan <rkagan@mail.ru>:
>> I've hit this problem too, and tracked it down to what I think is a
>> bug in svn.
>> [...]
>> I'm going to submit a patch adding apr_pstrdup() to subversion folks.
>
> http://thread.gmane.org/gmane.comp.version-control.subversion.devel/145186

FWIW the patch was accepted and committed in subversion trunk.

Nevertheless I'll submit the workaround to git-svn, too, as it's
harmless and may help some people (depending on the release cycles of
git and subversion).

Roman.
