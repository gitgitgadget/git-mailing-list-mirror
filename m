From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/4] completion: prioritize ./git-completion.bash
Date: Sun, 5 Jan 2014 15:38:27 +0530
Message-ID: <CALkWK0nt_EJ_Ajy1Tp9P_Z-Vj_03ZTETBcDTJBiCptKfa2qyLw@mail.gmail.com>
References: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
 <1388736031-6068-2-git-send-email-artagnon@gmail.com> <20140103225541.GG3338@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 05 11:17:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzklX-0000fU-Pi
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 11:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbaAEKQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 05:16:44 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:57445 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbaAEKQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 05:16:43 -0500
Received: by mail-ig0-f171.google.com with SMTP id c10so4778745igq.4
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 02:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=p26ZQh+W1DTHYQxpUSbIqVZP0nsispJGbd5kVw0AX0w=;
        b=CvZLLhGcwZTjLBH+u6T7sASpuSOv28DAkN8bV32uTUdGsfbRXG9JUhDv5kXYXUDN07
         yu+rGp41VjS3a5R+BJvkRndY/UCgORernC/6axE6nKjAAdNoy5q0omyMwmHwp2bXGk6l
         7P3DGC+oVO3fwI6FjRHHynXzOu0VFKx7CVgo9K7cIZ4kAKazgy406/9oyqU4FLEAlWZM
         mzd5BK1yb5zzjkXtdIF/OLlEArgjumRrTloTEBPLAl7p/83XGhWe9v7XapjvTKmZ+WB6
         Nj0CH2KeFbLJMLDDqGsLb01ORA8FH1lBv7ys1yYDd+j4cg7ftwv8esju0fprcYOs0I8+
         woLw==
X-Received: by 10.50.79.228 with SMTP id m4mr12655915igx.47.1388916547463;
 Sun, 05 Jan 2014 02:09:07 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Sun, 5 Jan 2014 02:08:27 -0800 (PST)
In-Reply-To: <20140103225541.GG3338@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239960>

brian m. carlson wrote:
> I'm not clear on this change.  It looks like this loads
> git-completion.bash from the same directory as git-completion.zsh.  Is
> this correct?

Yes, and that's what I meant to convey with the "./". Junio's message
is clearer though, so I'll use that.

Thanks.
