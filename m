From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH 00/95] Add missing &&'s in the testsuite
Date: Fri, 24 Sep 2010 22:02:14 +0000
Message-ID: <AANLkTimMrw-QgFPy=EjNciLSGBicrwE-Gi8CxbmVWX+i@mail.gmail.com>
References: <1285362413-18265-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:02:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGLV-0001zr-Ur
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728Ab0IXWCQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 18:02:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37841 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312Ab0IXWCQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 18:02:16 -0400
Received: by iwn5 with SMTP id 5so2704315iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oTYJk0BGjyB7r4mE0lp4vh/75LNqYsbrNKp5MGsD8S4=;
        b=RbI4rujaZ7nGlZ0zLfZxwYFmk6NMNi4EAg4Ycl797oGqSC7I5zyFD4roK4yejnmI7D
         z0rJXI4Fd8575Hb0NaZME66+FiaXVQubWS+LGRqoxVBmpPKYsICYE7JI4otGt5jbJVJv
         /KpTaR1flyFojXQE2uaS+V061ZXKB0TKi5Bdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=faLRvOh5dQPE3c3wZOQnB9KPG8BI8xnIlcueBuAjszkb+eLo3hJIpgbYWwbCpVLcB/
         3s7VbLxPhu8eKWbZARYURBn9+O9h+VWDt/RmIsFGelwfpJgbn7KFyXG2Qa37jvZ3cwtR
         HdLqGd85NJS2FqEegTH+bdNVWgJNsNGxWIqbc=
Received: by 10.231.35.138 with SMTP id p10mr4519684ibd.33.1285365734831; Fri,
 24 Sep 2010 15:02:14 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 15:02:14 -0700 (PDT)
In-Reply-To: <1285362413-18265-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157069>

On Fri, Sep 24, 2010 at 21:06, Elijah Newren <newren@gmail.com> wrote:

> =C2=A0 git://gitorious.org/~newren/git/en.git =C2=A0 add-missing-ands
> Let me know if you're fine with mailing list spam, and I'd be happy
> to flood all your inboxes.

I'd be fine with it on list. But maybe you can fold it all into one
E-Mail and send it to list. I'd like to comment on some of them.

It's probably best not to squash it too hard, at least not the ones
with TODO and FIXME comments. It'll also be easier for you to manage
this if you don't squash it prematurely.
