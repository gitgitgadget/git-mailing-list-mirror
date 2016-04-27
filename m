From: Stefan Beller <sbeller@google.com>
Subject: Re: BUG on OSX `git p4 submit` can fail when the workspace root
 doesn't exist locally.
Date: Wed, 27 Apr 2016 09:28:55 -0700
Message-ID: <CAGZ79kZ6rx4UpPmeGjC8TyHKbVd+Y6i1JyEdDzKuF_9rj4c_7g@mail.gmail.com>
References: <CAMsgv2UXPkxpocjKhoR7HbmubSBnhJPJ3hMq9Jsk2AD0DoCifA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Smith <jaroslov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:29:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSKr-0001e7-PM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbcD0Q3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:29:04 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36453 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcD0Q3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 12:29:01 -0400
Received: by mail-io0-f180.google.com with SMTP id u185so59533756iod.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ekg14dkjnHjAHP3iVeT/bXJdO1uQ4op0KIXW0C+dKFE=;
        b=UHfi59WweRbCZqLlC+11x47vFDh/djczavB07sa5990Ud9SXjdZ3gTA+G1a95lGkT6
         NEXt/D/kaYgzxunGdWp9insWt+G68iDGzN9v3r3BhW+b1i7ERx9Ght+5RL4Bmrkw36Vw
         5uD3J4ru1KhR17S7y3i0E5lho+ZQyqjBbSpIpZQnds7AyGXCdZtxpjbvJ6GpLFCRPOU+
         6kEdt1KiP+ooNHzabNVJi1TvQkJb85TOTKGkc+cBbLDrj8vWNI226DBDMsV2A0QKAN+q
         pHGHMZbPPvdWqas/JECCe3xXqIZdrrO3/eOHs/ryKZvwqL2x9YKtHd0WSiUr3gvPYlLP
         7JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ekg14dkjnHjAHP3iVeT/bXJdO1uQ4op0KIXW0C+dKFE=;
        b=A8HolFS8hbo7XIHCtgLel/4Jr7jAFwcHVPVdpDE9akJLHXIT11waaLwqrf/qZ6UT2u
         +wB+HL/fM3Vyg3hfXahfJ+oE8iu9wpb+QGInJ/izsA4LVcihKQadMdP0bZ9fsfqcV9FJ
         cy9I5iAW49ewDNc/5ZMjU78nd2srxP/DMkZitT7oxfwT5rYEwobhWfHkQNo2iZUok65Z
         nKMfeZIJYSRwK1a5pfWf+4jQZk4Ii9bPgj54HUd+e2lPUNc8H4+OzY8SyLZtNy7OQb3H
         lBK+htTQ3vYVwmumSKewFOuvQPHjevQTGqFUoNit6gqlMqG3W8h/jvDojv7wXbDhPVsp
         z+wg==
X-Gm-Message-State: AOPr4FW7TacWLNuA8ecWKPt2sm4gBveshBd5tPD4RHyi5wNgUB5eWbOPYSn6rQ4n68QcdD/V+AJuJ4zD4i8xK6/w
X-Received: by 10.107.174.205 with SMTP id n74mr11392949ioo.96.1461774535787;
 Wed, 27 Apr 2016 09:28:55 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 27 Apr 2016 09:28:55 -0700 (PDT)
In-Reply-To: <CAMsgv2UXPkxpocjKhoR7HbmubSBnhJPJ3hMq9Jsk2AD0DoCifA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292741>

On Wed, Apr 27, 2016 at 9:15 AM, Jacob Smith <jaroslov@gmail.com> wrote:
> On OS X,

Do you use the Git as provided from OS X? In that case you better report the bug
to Apple, as their version of Git is slightly different (not close on
upstream, by both
having additional patches as well as not following the upstream closely IIUC).
