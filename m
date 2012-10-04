From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Fri, 5 Oct 2012 01:10:21 +0200
Message-ID: <CAB9Jk9Br7urkZnQZtZ-2nc=BJ221LQQRVP684OW4OR6Adf=VVg@mail.gmail.com>
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
	<A75F75C4DE3C47C7AF43D39355C873F7@PhilipOakley>
	<CAB9Jk9C4Y2LSzZW5Nkz=4f===8_gk4uAG4EKDxT17kUHu4VX1A@mail.gmail.com>
	<20C3105FC8D94F749FAEB7444325B34A@PhilipOakley>
	<CAB9Jk9CiDNNBM9V-VvwCK6q-N0JNwEbf4vJj0ffT82iLnrUwog@mail.gmail.com>
	<74938A94D25C4F1887F30C281A02B35F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:23:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJuYr-0008AC-Jj
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 01:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab2JDXKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 19:10:23 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51871 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab2JDXKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 19:10:22 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2304211iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lk0EchHweJ/JusrJk6cKt4NRVyZgmxVvaCW9H1nCsEU=;
        b=tdRRJk9h9oYE/AhNd8XwKsjSscRkCx7fY5Y4ysQS1ejMrxLACDvwRO7/EvMRB/z6bS
         poQGoeHaNjFBBopGMFgWAehDFBurBsa8tZRa/ef9/2x8x1hlJHeIbWXqNs2IuRhuEIP0
         Twk5GpT7GlG0/LUKvHaECikcrya6ys7g+y1bBm09CcJ69g+TYg7tcvbhZIh4nzhLQuZD
         mGevubg4ZceCbxgH/uOx0G2omTndVbt+Tywe+GvJvPg14pzfhdn4iPZef0Q+3qFEM1Vz
         Bt+vhDNTFXLhQFTrRpwm3jNMunN9E2RVIq0PRxwHZWSgrwT8mNHIoJaPh0nj8IL2RElg
         4SBw==
Received: by 10.43.48.129 with SMTP id uw1mr5679194icb.10.1349392221611; Thu,
 04 Oct 2012 16:10:21 -0700 (PDT)
Received: by 10.43.131.136 with HTTP; Thu, 4 Oct 2012 16:10:21 -0700 (PDT)
In-Reply-To: <74938A94D25C4F1887F30C281A02B35F@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207053>

Hi Phil,

>
> Another technique could be to simply switch to the sources branch, and then
> use a 'git clean -x' with an updated .gitignore ('reset' the file from the
> source branch)[or use the exclude file] to remove those now ignored
> binaries, before doing the commit.
>

Actually, the first time I make a git checkout --orphan to create the
branch, and the following times a git symbolic-ref HEAD to switch to
it. Then I set a proper exclude file and do a list=`git ls-files -c -i
--exclude-standard` to get the paths of the files to remove from the
index. Then I remove them with git rm --cached. Then all is ready to
make a git commit. At this point I restore the HEAD and the index as
they were before.
This allows me to keep the work tree pristine, no files removed or
loaded in it from the repo,
which makes the script quite fast.

-Angelo
