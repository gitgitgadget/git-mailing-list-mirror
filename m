From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Mon, 10 Jul 2006 09:26:59 +1200
Message-ID: <46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>
References: <11524258261798-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 23:27:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzgnx-0003af-Um
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 23:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWGIV1B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 17:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWGIV1B
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 17:27:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:31162 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161163AbWGIV1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 17:27:00 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3677341ugf
        for <git@vger.kernel.org>; Sun, 09 Jul 2006 14:26:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PHDnz8H+7KxKtJB4m0FbWsC/SHS66qS4RzRZtr1smTTFzFzvj+J5Ol+a/AgXBSa6pITGV1Fz0oUecpxCogr1IlidPqF6peRGZB4RMMqo0Hnkvs+tB8WfsxmjzmpZwIZTA/kDY9z2z9JxHZEDYxlm/ARJwmrOOkWHejVK04mwSeg=
Received: by 10.78.156.6 with SMTP id d6mr1433389hue;
        Sun, 09 Jul 2006 14:26:59 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Sun, 9 Jul 2006 14:26:59 -0700 (PDT)
To: "Ryan Anderson" <ryan@michonline.com>
In-Reply-To: <11524258261798-git-send-email-ryan@michonline.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23566>

On 7/9/06, Ryan Anderson <ryan@michonline.com> wrote:
> This is the first in a series to categorize the source tree a little bit more
> than it is currently.

Given that you title it RFC, I guess it hasn't been discussed before.
I personally don't see much benefit from the move/rename. The tree is
not so large, the SCM import/export utilities are a single file each
and their names are quite clear. Having /contrib is more an issue of
marking utilities there as 'new, experimental, unsupported', and the
assumption is that when something matures it moves out of /contrib.

So I have to ask... what are the expected benefits of the move?

In any case, use /interop instead. /scm in the tree of an SCM could be
anything ;-)



martin
