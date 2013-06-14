From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] rebase: use 'git stash store' to simplify logic
Date: Fri, 14 Jun 2013 19:10:43 +0530
Message-ID: <CALkWK0n+f6xSfTCyxe+aY4vYq9Dhq5jFohmkXOuUkEVHv0FxCw@mail.gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
 <1371205924-8982-6-git-send-email-artagnon@gmail.com> <CABURp0rEzKwE__Sg+Z66iOo7qZn0NKPzPuuhb52taBs8zyga=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:41:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUFt-0002hv-NR
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab3FNNl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:41:26 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:57981 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab3FNNlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:41:25 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so1406027ieb.24
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0Ljvs2EOoRtZFIfpP06SQ5Bd2fd8fV/19af8HxoJj3M=;
        b=i67OgsL3a0CpxUMQZLjcPPCB2cQYrE4HSMsueY+mVshwpoo4JpZZOWwmqW/uroDb5e
         vGravAclbB6WmIeRBmWfBslvJ5/+hRHNKaPwYvjAykZLDVYI51YIUs3QEUFRuhvP8bWw
         b5iJfi/+/1l00fO/RpLFBp3TLDHaDIE5M1nVIUXezIVmg3MvRpXWlEmytGZRCA6qwA2C
         RdE80UYqsO9KHi8u7t0FUkjeZLIYOFJJl3h3bScfDJ/75hr0oWcdb9jfe3DOVomGoGe4
         P/EOX2QUmiApms8tqOMGRZ5YZo9+oTakeWRTpP3zjIl+EC6t/U1s708K/MfZs3UtaFcr
         J4XQ==
X-Received: by 10.50.118.72 with SMTP id kk8mr1096503igb.13.1371217284766;
 Fri, 14 Jun 2013 06:41:24 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 06:40:43 -0700 (PDT)
In-Reply-To: <CABURp0rEzKwE__Sg+Z66iOo7qZn0NKPzPuuhb52taBs8zyga=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227832>

Phil Hord wrote:
> nit: adds a period where there was not one previously.

Stripped periods in both, thanks.
