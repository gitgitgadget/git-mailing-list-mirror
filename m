From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Fri, 5 Apr 2013 13:09:07 +1100
Message-ID: <CACsJy8B9s0=EFUazrb9MhDJiou_dSzx6kezFCET+w+jUdBMv=A@mail.gmail.com>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Larres <jan@majutsushi.net>
X-From: git-owner@vger.kernel.org Fri Apr 05 04:10:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNw6R-0004Yk-Do
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 04:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368Ab3DECJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 22:09:38 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42790 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364Ab3DECJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 22:09:38 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn14so2295387obc.32
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wwAsb5BVFlnP35OweW+U5Y14u8aUlQtOym2jnVsedEM=;
        b=eVqNmsEBPrUc+w3wV4uw84bpeKY34XrdmB99WqVWrJ6Cx+lCHlF5sFFJ3kvderwvrM
         Anldf193PZPGrJi4fZdPwj9iNSkTfJvPW9nLFzFlvYvi/FVgjYwB2SHV6DxB3KLf4r3V
         I/toJqiopoY3PvR4VamzaUjmxIopH+mu7X0QI7cKumBeszPt9Vz55LunSczUIhSqjy4O
         xpSilB7kT2hZ24ka0nWSkFh2orBn7MQ5Hq0DDjN6ZllWxyFljIlp5tvHBUqqbRy1si2m
         DQfqgoPUG3aSbfEKtn7d6SiXXqO96nH3FGD8/dxOejI6Zn3YwKpALZAAhNOvf+WsW+WV
         1BMQ==
X-Received: by 10.182.116.70 with SMTP id ju6mr6389971obb.48.1365127777585;
 Thu, 04 Apr 2013 19:09:37 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Thu, 4 Apr 2013 19:09:07 -0700 (PDT)
In-Reply-To: <slrnkldd3g.1l4.jan@majutsushi.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220130>

On Sat, Mar 30, 2013 at 8:45 PM, Jan Larres <jan@majutsushi.net> wrote:
> I would expect the last command to also report 'set'. I've also tried
> other patterns like 'foo/' and 'foo*', but it didn't make any
> difference.

Try "foo/**". You need 1.8.2 though.
--
Duy
