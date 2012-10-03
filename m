From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 16:46:51 +0200
Message-ID: <CAB9Jk9Ar3PbbBu-8AEBsNGDAUeghyi2maLCbdZjSdpMCWseq6w@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	<vpqvcer4xvo.fsf@grenoble-inp.fr>
	<CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
	<vpqfw5v1wva.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 03 16:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJQE6-0007fY-SK
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 16:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab2JCOqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 10:46:53 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48594 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab2JCOqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 10:46:52 -0400
Received: by vbbff1 with SMTP id ff1so7920435vbb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ft2rEbkprKiQ0WscSVuST8c+ztnMVXDAq0u5BzBbE80=;
        b=NjumaoJntdRD8EDd5ImvLwevmjrCFa5wuYAHbeuTJahDLf8VL0R9twarm4D5e/zE4B
         b4/2QTJgS0EjoHAdJgz6uQ0zEiHCEz2ejEBpkXwAXk8Qt/sLqqkD7IrBUoPTUVvfhW7l
         MDfnVM5QNdAHDOfldn7JgRmJw7fn8A1C9e1oKaZujyruvgVkjRYhQrQaewH+WNKNYIQz
         J6GxGYooWiz5oZrJN79IhwItZtHwl1sOScdei/Dkne/7f0hG2RYJuuUkk+0S/9e4nPeX
         z4eKZvQ3EpVBH36+Fxs3g4zKLZOuDd4efQWMkVoklppFV7/w24gH6Dcjs2rHrzTsgqdG
         OmCQ==
Received: by 10.52.72.164 with SMTP id e4mr997928vdv.103.1349275611510; Wed,
 03 Oct 2012 07:46:51 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 07:46:51 -0700 (PDT)
In-Reply-To: <vpqfw5v1wva.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206902>

Hi Matthiew,

>
> You don't understand what an orphan branch is.

I do not think so. I wanted to create a branch with a commit that has no parent,
and I think that this is called "orphan branch".

I wanted also to have another branch, pointing to a different commit,
the difference
being that this contains binaries, and the other does not.
So, having two references pointing to the same commit is not a problem for me,
but it is not either the solution.

-Angelo
