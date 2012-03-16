From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add "first parent" to gitglossary
Date: Fri, 16 Mar 2012 12:35:08 -0500
Message-ID: <20120316173508.GD28004@burratino>
References: <1331680716-31915-1-git-send-email-nkreitzinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, bfields@fieldses.org,
	phil.hord@gmail.com
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 18:35:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8b3k-0000Wn-PX
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 18:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab2CPRfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 13:35:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39223 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab2CPRfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 13:35:17 -0400
Received: by iagz16 with SMTP id z16so5694904iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Lx2JOeZAr/Lc2gwcsH5RHjgENl0pg5uMp0dU86d2ZQE=;
        b=tTJVw2K5gXoJ4z83MuVwM227QkzsiiPrey1l+LvZeMZOd3LA3/S+/6ra811jhKUKWL
         iuOd0wBvNyjNynYKOkegnU4sFxsY66GGlu7c6iQodx3kLCcm+SH/dUMjnYxov1yBqzhu
         +G2wuf0LIFgkXkQcZr6LpSAPnZfZHUAekEJ4dHWx69ffvHHr4SMkfE7hHzo/HJDezQ6t
         Ya8klmSRHZBinFnoncGly+aAOm8B3aopUZUtWUEK/aEGRyCR0eMHW2ASc6wYsExNwBjB
         wxrVYtoq/Um5B/DVoXPW7Pz/etz67sjm0wTzlTKTI7fS+MU01XWlvtu4V6Sj1Ja57zKL
         8sMg==
Received: by 10.50.170.104 with SMTP id al8mr150465igc.9.1331919316304;
        Fri, 16 Mar 2012 10:35:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id al5sm111995igc.5.2012.03.16.10.35.15
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 10:35:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331680716-31915-1-git-send-email-nkreitzinger@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193279>

Hi Neal,

Neal Kreitzinger wrote:

> Add "first parent" to "gitglossary" reference manual page.

Sounds to me like an odd thing to do.  The term "first parent" is just
a special case of "nth parent" --- if someone is confused by the term,
is such a special case definition (rather than a general definition of
"nth parent" that explains that the second parent of HEAD is HEAD^2,
not HEAD~2) going to help him?

Adding information about the conventional meaning of first-parent
history does sound like a reasonable and useful idea, though more as
something for gitworkflows than the glossary.

Just my two cents,
Jonathan
