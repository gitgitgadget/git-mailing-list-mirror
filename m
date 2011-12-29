From: Dave Borowitz <dborowitz@google.com>
Subject: Re: git alias question
Date: Thu, 29 Dec 2011 09:08:16 -0800
Message-ID: <CAD0k6qTp9sKCb==Jh1vuLuZoxx99Kt2Z=VAbjYbGaUE7nbOxdQ@mail.gmail.com>
References: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Thu Dec 29 18:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgJT9-0007Z7-9D
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 18:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab1L2RIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 12:08:39 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45519 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab1L2RIi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 12:08:38 -0500
Received: by qadc12 with SMTP id c12so7877401qad.19
        for <git@vger.kernel.org>; Thu, 29 Dec 2011 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-system-of-record:content-type;
        bh=9BgWMCS2p8bHR3v99ci37cLud31Xy2QIFn7Q9Y1XHKw=;
        b=Sw+J8MydgHYszDTRKYIOWrHC8OvrfGDB6McUOA5cmEwYF2ylFa0aJ6EGcF5uASQq5x
         ilLtr2aHPZX/0t6jZRVQ==
Received: by 10.224.192.1 with SMTP id do1mr43631691qab.21.1325178517366;
        Thu, 29 Dec 2011 09:08:37 -0800 (PST)
Received: by 10.224.192.1 with SMTP id do1mr43631679qab.21.1325178517264; Thu,
 29 Dec 2011 09:08:37 -0800 (PST)
Received: by 10.229.250.10 with HTTP; Thu, 29 Dec 2011 09:08:16 -0800 (PST)
In-Reply-To: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187779>

On Wed, Dec 28, 2011 at 17:27, Michael Horowitz
<michael.horowitz@ieee.org> wrote:
> ldiff = "!git diff `git rev-list --reverse -n 2 HEAD -- $1` -- $1"

FWIW, you can also do this as:
  ldiff = log -p -1 --format=format: --

> ldifft = "!git difftool `git rev-list --reverse -n 2 HEAD -- $1` -- $1"

I don't know that you can do something equivalent with difftool. I
suppose you could do the above with "GIT_EXTERNAL_DIFF=<some difftool
wrapper> git ldiff", but that's not very helpful.
