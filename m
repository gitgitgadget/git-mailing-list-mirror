From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 23:38:58 -0400
Message-ID: <CABURp0rd1owLCwTudQ7WkX7JzmnNOT2ZKvNDv9aqqWOpVOn-mQ@mail.gmail.com>
References: <vpqobdg515m.fsf@grenoble-inp.fr> <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 05:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URwjs-0005S6-2E
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 05:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935619Ab3DPDjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 23:39:20 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:47873 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDjT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 23:39:19 -0400
Received: by mail-ve0-f180.google.com with SMTP id pb11so43987veb.39
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SwyeU+q3oXrlhX3pEOb+r4yJGFjvrsmJaVKwjW+s3AM=;
        b=XxsSJmiAvWYJ8SZ4vVozErft5E+6I9+XiIKyB5yF1MmyfQBwmxc8E0AnW4PO/6JhBk
         lBv9SZ2sfwV96iRHYFGBQc+SV7TaiIb0W0FHKvn0YC21tbgtpjUXqHWVz13ZSzeCf9tG
         zPRM60iXzWMIZA+xjxoge8pp0LorpULeLMvwxYY2cbMZgyp2uRQ8F+d5ybURji1vF7c3
         UBJHU3dQFhazgb9NCoQ0+ZUJ/a5E/LNSJCJUTIMYdSArrXZp5MNIQzF95tTHGWtmrdTc
         VVra1e4XHxemsexK5TefOfk7azicZ/Li+xfGO1h+mnXlc8eIUzyDvXdmoAwILuA7yL5P
         /5ng==
X-Received: by 10.59.11.199 with SMTP id ek7mr336571ved.19.1366083558448; Mon,
 15 Apr 2013 20:39:18 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Mon, 15 Apr 2013 20:38:58 -0700 (PDT)
In-Reply-To: <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221356>

On Mon, Apr 15, 2013 at 11:18 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> A few small personal itches off the top of my head:
>
> - Make git status -s show "state status" as well: this essentially
> requires writing an equivalent of wt_status_print_state() for use in
> wt_shortstatus_print().

I actually submitted a patch for this last fall.   I was going to
reprise it and give it another run after your wt_status changes died
down (and I found some free time).

http://comments.gmane.org/gmane.comp.version-control.git/208209

Phil
