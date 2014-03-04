From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git submodule foreach: Skip eval for more than one argument
Date: Tue, 4 Mar 2014 15:53:24 +0100
Message-ID: <CALKQrgfC1Cf=ZnwhaDUz-2q=vLa0UbO4ONybvCPu7RiF+3sm3w@mail.gmail.com>
References: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
	<20140304135106.GD11566@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Anders Kaseorg <andersk@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 15:53:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKqiv-00065E-09
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 15:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbaCDOxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 09:53:31 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:58174 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309AbaCDOxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 09:53:30 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WKqim-0007Ro-G0
	for git@vger.kernel.org; Tue, 04 Mar 2014 15:53:28 +0100
Received: from mail-pb0-f41.google.com ([209.85.160.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WKqim-0003MV-1L
	for git@vger.kernel.org; Tue, 04 Mar 2014 15:53:28 +0100
Received: by mail-pb0-f41.google.com with SMTP id jt11so5296348pbb.14
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 06:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=WZ2h9aOaMCuqW+TDIvZutct7LgzwRDKIfBSMkTnlQhU=;
        b=HwS99rEFvkXvMsqg04fcvEvVK4SSTtVK9WWPhQD7HfR4zSKngwXD8IotrWfJCdbuPf
         SYtypBkkKEryE6c39iNMNGpZnVfd96x79dExXsBI/PHg7fdlz1OqwGH/kH61HP7qzXsg
         hYh9Z3dTovnNkZVnBUkqL9xOE3TVOD/+4aj/5+qREy9kp7X+MjXzHK6HW7quU3zhOmrk
         kn5HonuKr+J4I6im+A9mkLbC7EBb2JCxO64mlucM+xs/XruWTaaHykMqNbudjafrXmxs
         0R4azFdI7G8ftVHOPkWD8ZiMa+BocEFemjFweaACL4hz48jYI6R9OtqMTMgiYM/Pfb6Y
         5u5g==
X-Received: by 10.66.156.4 with SMTP id wa4mr6556058pab.49.1393944804332; Tue,
 04 Mar 2014 06:53:24 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Tue, 4 Mar 2014 06:53:24 -0800 (PST)
In-Reply-To: <20140304135106.GD11566@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243345>

On Tue, Mar 4, 2014 at 2:51 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
> matthijs@grubby:~/test$ git submodule foreach echo '$name'
> Entering 'test'
> $name

jherland@beta ~/test$ echo '$name'
$name

What would you expect echo '$name' to do? What happens if you use
double instead of single quotes?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
