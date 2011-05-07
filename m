From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Separate default remotes for pulling and pushing
Date: Sat, 7 May 2011 11:50:35 +0200
Message-ID: <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Lee <davidomundo@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 11:51:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIeAS-0004l4-OA
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 11:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab1EGJvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 05:51:16 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54469 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab1EGJvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 05:51:15 -0400
Received: by qwk3 with SMTP id 3so2347594qwk.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Slm6Yp9aREWvdpefGADKD+TNPGj7biV/vddIOmercc4=;
        b=rFRxxnItly2gQZMtDKPZMNPBKgmkCvUtp8djFWbV394Xj3kBAYUP6gtY7rV3+DZ5yD
         AvVAj7vLUMciPxKSsQcZOtwnRw9qQn72cGgk1uKZRXpNdR4eDJT9A1OzpCv/ByzL6iBn
         Fe/b8pvpDIdan7+vH0+s4aHslwszQ9IwDavFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KnlgjRuZ1Waeo5mzGHfjhJ8xaT5MqhgV1Ij7ZEJ4RY/xOnkbgud7PbuWgPkff8pl6W
         SiJLasovfUeKhQ+mtozquBUdFeHjar+VaJY++XqXQj5/NzNIkk+i2rwiH0WsppFJTIMC
         Eg/HyVaxOaRfj92+EQUYfLIJjsxw1cs5sqanU=
Received: by 10.229.78.216 with SMTP id m24mr3404626qck.60.1304761875130; Sat,
 07 May 2011 02:51:15 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Sat, 7 May 2011 02:50:35 -0700 (PDT)
In-Reply-To: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173043>

Heya,

On Sat, May 7, 2011 at 10:10, David Lee <davidomundo@gmail.com> wrote:
> I want to set up different default remotes for pushing and pulling

See 'git remote set-url --push' [0].

[0] http://www.kernel.org/pub/software/scm/git/docs/git-remote.html

-- 
Cheers,

Sverre Rabbelier
