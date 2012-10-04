From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Thu, 4 Oct 2012 21:00:38 +0200
Message-ID: <CAB9Jk9CDXE_Qgsm8e8EFHV-77W_bK9mu4xMyw_OzYTnn_XNb+A@mail.gmail.com>
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
	<CABURp0pgE=J9yCa+nUa7J0MZ-O-6bUHrj58zLQZ9mToh6YcOFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:39:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtg9-00033L-5o
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab2JDTAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 15:00:40 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54969 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab2JDTAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 15:00:39 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so988852vcb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3iu8qmO72JrIYcvjTC+xgZNoFjh71SVFDvTFPkhcFZs=;
        b=OLTDVxVN2uLwri9dVu7RlKQOOp0595suVMoB7IdJJn03KSlbmGbbBBoM55Ed9AUNyv
         p6Q2VbrUHkhUFW9jVzFMJjXjyiLqmD9cy9+vhQlKsvZXPAk9n4/Pfve0mu4DqLV0iHMR
         L57wHq6UEpg1M5dQmU8IwpHPng1wK1FNnIYKXr8jJ7YH7F4Wkg0eEICBpuwiRbAKUzQT
         GVnSKsZALnzt5NHx0NMmzLH1l2xmbMpOQCsmFMpVAP+DguYS18Vn7tWSCqZogChASIDK
         iokBilDzDQPgJLi/e4Hl4+knoyYzDaiyilysHu/3/U8pqge2uh/DMVrI4gsuGri2BS8D
         vG1w==
Received: by 10.52.90.2 with SMTP id bs2mr3033401vdb.23.1349377238733; Thu, 04
 Oct 2012 12:00:38 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Thu, 4 Oct 2012 12:00:38 -0700 (PDT)
In-Reply-To: <CABURp0pgE=J9yCa+nUa7J0MZ-O-6bUHrj58zLQZ9mToh6YcOFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207015>

Hi Phil,

\>
> And why is this a problem?
>
> Is there a process or person watching the server for a new commit?
>
> Is it not enough to notice that the pushed-to branch has a new HEAD?
>

Yes, the developers use the git gui to see the graph of branches and commits.
The simpler and uniform it is, the better.

-Angelo
