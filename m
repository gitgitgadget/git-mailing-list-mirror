From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 08:59:21 +0100
Message-ID: <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <87ps9d7j6t.fsf@morpheus.local>
	 <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josh Boyer" <jwboyer@gmail.com>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 08:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7SBD-0005Fg-Iy
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 08:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXARH7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 02:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXARH7Y
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 02:59:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:41180 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbXARH7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 02:59:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so110109uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 23:59:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CNHgUfha3C06hZzvly6RLcLUbLwaC0h+09qUCHiZvN+pfMuW7v7Y926/F3DD5xMcYGymYo6yK7zS/R0426j40cCc/aXRqe2iYfxIzP/tFGZsjDI1CSDj4E9pGBv7K9cBAFAwqVRqWmmeMNbmBcTYxYNpWuR6ka6eOYt6HgY0k2w=
Received: by 10.78.138.6 with SMTP id l6mr541434hud.1169107161889;
        Wed, 17 Jan 2007 23:59:21 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 17 Jan 2007 23:59:21 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37064>

On 1/18/07, Junio C Hamano <junkio@cox.net> wrote:
> Editors often give easier handling of patch files if the
> filename ends with .patch, so use it instead of .txt.

I'd like to see ".patch" there, but...

I have to mention, though, that the majority of the editing
programs is used on that stupid thing called windows
and they usually and most notably have no idea what
the patch is and how could it happen a file extension
having more than 3 characters. I am already having
hard time explaining to my coworkers what the patch
(the program and the file) is. With mixed success.

Also, how many mail clients know that .patch is actually
a text and not application/binary? It'll make patch
reviewing harder for some (not sure if I'd like a review
of such a person, though).
