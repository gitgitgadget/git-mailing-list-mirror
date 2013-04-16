From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Ensimag students projects, version 2013
Date: Tue, 16 Apr 2013 12:54:19 +0530
Message-ID: <CALkWK0m=ZFK_+Za=_JabO4fiGTQ4K-Bxpr1hiZTrL_T4XuZKog@mail.gmail.com>
References: <vpqobdg515m.fsf@grenoble-inp.fr> <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
 <vpqzjwzkb4e.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 16 09:25:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US0GK-0005Vn-RM
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 09:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab3DPHZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 03:25:00 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:60150 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab3DPHZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 03:25:00 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so101520iea.32
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9aLkQE3f0SOec5eWjTf3woKj+SkF3x88hWNFkRcY4nc=;
        b=h8cwPyJQwQ/Pq4vP0E4UmYx5UPKJVwPzuSqnrkO6e0Fnn2XGN3nLnOxT8KS9jIZVud
         ivIQSupS+cIUDWG1Qbfk4HS4lbOkOwOERbc6V4CFm7P+uE26Oq2pOx+gZSojdM/luVkp
         KdCaFUrAUS/9X0obFQPgGwNQ8dLfYntpm8sDtPXnLTu8OC2UMTktEjG7dJCIaS7Ydxdp
         FJyzGADKIsriZs+u8+X1iVFT/+y6l5lWc2lUeZfihoFqX2GKfkGYqhKTAYkVMjt2E1Ec
         UpB10pBQvJS4F/wTtxNGNe8qx1MBM2gC+GpLkh3YpEgmVzuvzgXSwLN+J3PcgZX3hmzT
         qkSw==
X-Received: by 10.50.119.102 with SMTP id kt6mr637416igb.12.1366097099786;
 Tue, 16 Apr 2013 00:24:59 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 00:24:19 -0700 (PDT)
In-Reply-To: <vpqzjwzkb4e.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221373>

Matthieu Moy wrote:
> I tend to agree with you, but the idea has explicitly been rejected in
> the past. The problem with an option like this is that it would also
> disable the advices that may be added in the future. By letting people
> disable the advices one by one, people see new advices as they arrive.
> You may think of it like "do not show this message again" tickboxes in
> some graphical user interfaces.
>
> Too controversial area for newcommers I guess ;-).

This is the kind of nonsense that I absolutely won't stand for.  Am I
a less important customer than a newcomer?  Hell, if anything, I'm the
_more_ important customer because I spend time improving git while a
newcomer makes no contribution whatsoever.  In my opinion, the most
important customers of git are (in this order of precedence):

1. Developers who hack on git to make it better.  This means that the
implementation must have a pleasing consistency, and end-user
expectations of UI are secondary.  For some reason, Junio seems to
disagree with this.

2. Advanced users hacking on projects that demand effective use of git
like linux.git and git.git, as opposed to some little project on
GitHub that just accepts pull requests.

3. Newcomers.

I don't develop git for newcomers.  I develop git for myself, and
scratch my personal itches.  The most important customer to me is
myself, and everyone else is secondary.

That said, I don't feel strongly about this particular advice.ui
issue, and Jeff/ Junio have presented a reasonably cogent argument.
