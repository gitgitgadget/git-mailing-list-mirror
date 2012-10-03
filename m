From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 09:45:36 +0200
Message-ID: <CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 09:46:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJJeS-0004hE-Jj
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 09:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab2JCHpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 03:45:38 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36557 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab2JCHph (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 03:45:37 -0400
Received: by vcbfo13 with SMTP id fo13so7909455vcb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Jw7xLFhm/gFE6EWYmCS3WTFTjSwFrFz3DgmAm7mzzeA=;
        b=O2BN/xbMUu20M1jtMdEH+guezoATlaZdqGhFe0NJR/Y7eE/p+pxjAqUyd8pUniXcJt
         IF3uy7IE8QKVxJ50nzCA+sUk+Oqzz2go5h/jUj7ysfJUmoYXja2dK4OiabBi2nfu8o7U
         dolIWodB6mkpjHxPYVoi1dvFS2Q2t21vOo4/q4DIenFghhk8e+jGmGR57agi1f6wXdI7
         k6SyeELpR8aTOQZ2/RZOwlm053zbM6ZlFq+ca8j08cj9g2K4qUGpnEQ6h0HI+DUypXWn
         QS5azKR0qmKJy8vV+kS0I704OSOPxc6jqKYXqlRu2fVOTVH82FuwKpEuNFoVlQXNLmhO
         B15Q==
Received: by 10.52.90.2 with SMTP id bs2mr560977vdb.23.1349250336575; Wed, 03
 Oct 2012 00:45:36 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 00:45:36 -0700 (PDT)
In-Reply-To: <90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206865>

In reply to Philip,

I understand what the implementation does, but I am stating that it is
not what the
user (by reading the man page) expects.
The user adds --allow-empty to have a different & unique commit, such seems to
be the purpose of the option.
Unfortunately, it gets that only sometimes, depending on the exact
instant in time
the command is executed, which is out of his/her control.
I think that you would agree with me that this is not a nice
behaviour. How could a user
ever use a command that is not predictable?
If it is not possible to change the implementation, at least warn the
user in the man page.

-Angelo
