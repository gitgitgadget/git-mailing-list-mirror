From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git merge man page, upstream
Date: Tue, 23 Oct 2012 19:30:03 +0200
Message-ID: <CAB9Jk9C3hybpSNMZE-PYKWS7ZQbC7BwmBkhv9-UaeJXbB_sz3w@mail.gmail.com>
References: <CAB9Jk9BT3F1_yvf7jQQyT72_EWskFS4bEgXCkmJs7uZOPhEK8w@mail.gmail.com>
	<vpqk3uhr5gp.fsf@grenoble-inp.fr>
	<CAB9Jk9CEbT=Y=yjw2tPSLiLibejDSheabcBPEpHCLa_TS+6Cpw@mail.gmail.com>
	<vpqehkpqv3k.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 23 19:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQiJ0-0003PN-8c
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 19:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336Ab2JWRaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 13:30:05 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34517 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab2JWRaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 13:30:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2912685pad.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LdzC8vNESytUOOSnxk+Voxz3RH3GE41oEi5lSMOK9zY=;
        b=kMC12E67S3FAdTeBJGPNG+p7Tv2u2w9d/6O5G/WVdiNYkM68kkUlMk4vGFtqm1Oj/C
         tHM+oHGoZe5j2r/1QGZhuAQ0clPDqDUIpHcqsrMwj9fUN+mWnrtMreEnYhs3zDrbuZ46
         59LBGpjI0rQPvbgohizaTqdt8bfb34r2AZ3Pcm/1mNQ6CHYg4LLe5o6XPhzTDsUGSBRa
         t5IVpFBNrms/3ipZoUgzHoRMQegZh/t0BiXLSQlJIH1BlA7W6wwo2EoKF5jlAqR4lNDd
         O42vwJZ2aZ0or14LX1NkMEvB9g5Gvzk8716S8jiJMEJJEVLY+NhyVDOwplHrShekPm9R
         t57Q==
Received: by 10.68.200.72 with SMTP id jq8mr42043813pbc.38.1351013403369; Tue,
 23 Oct 2012 10:30:03 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Tue, 23 Oct 2012 10:30:03 -0700 (PDT)
In-Reply-To: <vpqehkpqv3k.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208233>

Hi Matthiew,

man pages should be clear, and easy to read. "Remote" usually means
"another repository"
(git glossary), and also in natural language conveys the notion of
something far away.
Internally, it can be handled as a special case of url, of course.
My suggestion is to be consistent with the git glossary, that defines
"upstream branch" as: "The default branch that is merged into the
branch in question", which is exactly what that paragraph of the
git-merge man page is describing.

-Angelo
