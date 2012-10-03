From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 13:37:27 +0200
Message-ID: <CAB9Jk9Dqoom-hBQPG5iqe2JyiJtVoFWZ9-5W9ktUsa9F9mbXRQ@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<m2fw5vooem.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:38:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJNGk-0001rz-UZ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 13:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab2JCLh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 07:37:29 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64149 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab2JCLh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 07:37:28 -0400
Received: by vbbff1 with SMTP id ff1so7686565vbb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KMruizBh/SSK0yG0j/xb5FRQVZ+A3JlrF2LGa9oH2yY=;
        b=IMbNfpls72xuVM9Kpc58eNQwLm0Rjfy6jnvsAB89Uz88IXPOVlS4PGxWMMPrzM4jgr
         MQYUNHNfcYOvk4Rld5mwyshw+hFiDbaFCdWA0uEPCeRuKLaeF6LFgDPKHRGc6pQiKOZQ
         m+Mcda8FTDIpma7iP7ZAfurujq9vGwReH/3qAWQLFHtjof/yVu/nQfDtLgMv/HzkXQG2
         0gQIbpJEp50rCmX7/+xGyArcMIHVSgdK2GmnnEjRifFoxp0qZJG30NMK/mDFi/8FNS91
         OrNDTLU1vy94wDIJb2xkmWzb6lGAVwTV7nEz7Dn07ynrXmVP6VuAfsyEq9kg0ktgoQQt
         1agQ==
Received: by 10.52.72.164 with SMTP id e4mr755758vdv.103.1349264247575; Wed,
 03 Oct 2012 04:37:27 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 04:37:27 -0700 (PDT)
In-Reply-To: <m2fw5vooem.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206881>

Hi Andreas,

>
> Where does the manual say that --allow-empty implies a different and
> unique commit?
>

In the git commit man page:

"--allow-empty

    Usually recording a commit that has the exact same tree as its
sole parent commit is a mistake, and the command prevents you from
making such a commit. This option bypasses the safety, and is
primarily for use by foreign SCM interface scripts."

By reading: "the command prevents" I understand that a new commit is
not created, and "This option bypasses" that it is instead created.

Perhaps my reading was a bit straightforward, but a man page is not a
sort of ancient holy writing that the reader has to sift every word to
understand hidden meanings, it should be something
clear and plain.

-Angelo
