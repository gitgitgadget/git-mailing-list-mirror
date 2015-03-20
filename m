From: Stefan Beller <sbeller@google.com>
Subject: Re: A git hook that does git cherry-pick and push automatically
Date: Fri, 20 Mar 2015 09:51:45 -0700
Message-ID: <CAGZ79kYsuY1u6_j=_9dBx3cK8o6kV3L4cOGafBv+doDVdJFUuQ@mail.gmail.com>
References: <CAA4Z6SXzekMdPgKKaXqAObPcpFXDWpaQvNhJg6DEsOxbMOy3Lw@mail.gmail.com>
	<20150320071625.GA90632@gmail.com>
	<65D8F41C-9576-4899-B700-F779A30A1F42@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ray Xie <samuiotoko925@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 17:51:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ09H-0004v7-Ea
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 17:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbbCTQvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 12:51:47 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33502 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbbCTQvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 12:51:46 -0400
Received: by iecvj10 with SMTP id vj10so97678273iec.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MQgM3en78ljWdiT6q1mT9q2f/d9jvqMR7tsB+YovH1M=;
        b=g5CowI1BvYsIp2PY+ITdD+lCNQiqwFi5VQ0SGadu1wqkLORvuFYdYI/mPkCMfpggoW
         ftX3/WTJuWAtZ+49jThfF3FY5KCKsQ0eH9wZ5+q6EzGoeUSdSNiEFVpD3jlzwjvp8hZM
         j5XgoJv+F5unNUC4g9E1ph5+/sCMiBX6HdWVRI09PIlru8nYORO9OzqjnJl2ehMODRjV
         OURhr5DjLOaVixFL6IavGYm/JYCc0p0hx7isbn3KhOGOVeG6GlHzTyXGLaCo9EVhSbYe
         UTQ6J9VUdydE64Z83jGnEZufslA/OqiTQymNJjt1R8zbHIkmKXkZoGaZtgBNqisjVAqL
         IfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MQgM3en78ljWdiT6q1mT9q2f/d9jvqMR7tsB+YovH1M=;
        b=bPVFdHz0KrFY+elUdNnqfcWrs8sskwnraYHamr2jXlGp2wje4404Yrzq0ui1rq2c9b
         tCAxCTZKBDwVfdZ6u2kc/GosnD6INo9hKhEkYKTsILMRQ1jRASQ5miWaLc03ow6hPeqT
         C3vaxAbGBhy0tZf8QCMDsbkt+eOwJJdUJmik/G4M8tFtygNI4ldNszJlzAsz621tCZUy
         wM5rm/CLMsr6CrxWe29mT1sJa23V8GS1kQLIAsjTUn8zqmw9EaoCKjrnaUWvgNVGkB6M
         3DAgPyfpW36y3HIi6jvPq8T8jYaJV4jb4bMMGdFamidx7fOA4kic4kM9asu34ZOZATE9
         Nlxg==
X-Gm-Message-State: ALoCoQkOcD641SbUtp8SBa0koqEyBKW5Wf4CHAUG9pxRP3ENuHQjz3ojubYBI5fMz9ILXOnnBSlq
X-Received: by 10.107.15.155 with SMTP id 27mr131085782iop.49.1426870305751;
 Fri, 20 Mar 2015 09:51:45 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 20 Mar 2015 09:51:45 -0700 (PDT)
In-Reply-To: <65D8F41C-9576-4899-B700-F779A30A1F42@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265910>

> so it's a sever side hook that it's forced down to all developers.

How does that work?

/me is just curious
