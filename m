From: adr3nald0s@gmail.com
Subject: Re: Anomalous conflicts during git rebase
Date: Fri, 28 Dec 2007 09:54:53 -0600
Message-ID: <m3k5my7r1u.fsf@euroclydon.lan>
References: <m3ir2ju5ce.fsf@euroclydon.lan>
	<alpine.LNX.1.00.0712271840030.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: adr3nald0s@gmail.com, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 16:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8HU4-000571-I7
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 16:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbXL1Pu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Dec 2007 10:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbXL1PuZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 10:50:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:2784 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbXL1PuY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Dec 2007 10:50:24 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1002511wxd.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2007 07:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:subject:in-reply-to:user-agent:references:from:date:message-id:mime-version:content-type:content-transfer-encoding;
        bh=RV75gOUlT8VipZ6+biuwZyo2deSlemGII6/CNVNM5nc=;
        b=MTmCqv86IBpcNuU3ZFFcCJ+dPydNLHeCgdZNf35k8S1gdFBT97h0vMvxNfXkh1O2uycko1/BzRogZi0Y0ZYa1nV2VjBC8g0rHBqLzYxz6+uNrjPMRTOq5rqLkm4vOjtYoRIM8kOGtVGckQe25898jjVC33sI2Nb0i63KyunYo4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:in-reply-to:user-agent:references:from:date:message-id:mime-version:content-type:content-transfer-encoding;
        b=YcTLfTz7aThshAUBmnBEGUsIZ0lXg0LqY6IsuDZ3CAX8SOusgNMiwJcxYDXWD3h6jKkN7EiUenPhQdrLq+x9rdrqR0thikvjgfAIRqIUGiTDDxs1JF11LNCXoc4tCZdifxiqGZWrKyeybqgb6Sh4FUk17j07dqAXG9IWVOf8Ub0=
Received: by 10.70.54.2 with SMTP id c2mr83669wxa.85.1198857022255;
        Fri, 28 Dec 2007 07:50:22 -0800 (PST)
Received: from euroclydon.lan ( [66.148.187.210])
        by mx.google.com with ESMTPS id i18sm14870206wxd.0.2007.12.28.07.50.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Dec 2007 07:50:21 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0712271840030.13593@iabervon.org> (Daniel Barkalow's message of "Thu\, 27 Dec 2007 18\:45\:29 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69290>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This will rebase temp0 (=3D v2.6.16) onto topic/test. This process=20
> linearizes the history being rebased, and conflicts in that history (=
that=20
> were resolved in the merges) show up when the second change to those =
lines=20
> gets introduced.

Thank you for the explaination of why this is happening.  This is
something I had not considered WRT git-rebase.

When you say it linearizes history how is this done.  Mentally I still
have a model of where the "mainline" is at all times and I assumed
that git-rebase was following this mainline.  However, upon
reflection, I realize this is na=EFve.

When there is a branch and a subsequent merge, does rebase follow both
branches?  If so, why does it not use the original merged result for
the newly rebased file if there are no conflicts between the original
merge result and the file that is being rebased onto as compared to
their mutual ancestor?

Thanks again.

--=20
Adr3nalD0S
