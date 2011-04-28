From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 13:26:08 +1000
Message-ID: <BANLkTi=vJeUAwMH0Fa7SXmK=2hwu8vnPGg@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
	<BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
	<4DB84D65.6070906@gmail.com>
	<BANLkTimyFmujc+Lsd7DMWfJgUzZME+Sveg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 05:26:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFHrs-0003Um-JJ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 05:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab1D1D0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 23:26:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53555 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab1D1D0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 23:26:10 -0400
Received: by ewy4 with SMTP id 4so698936ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 20:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=SrApbkoF5QphYhVFIsCOuCk5H0Lqy2UHwiUBeOWXfsE=;
        b=inDilbanVYYy5NrLzmlS1wORPjGrliBDCAwSTye/L4q9J4VlcnO11Qkd+pB+NOXeiE
         di7tU3iTjs/ffpYRRms8YGWOAgMYJ8onV3pz0XbTy3SswLudMuq3abeD1MaA1X/WZezH
         opbwTU9I25Raj9UT7DExkEB4rSuoKipADaECo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=eA/gE6IIDIvyhpDDH8covwWJsx+St5j7CGaLPp3jTOCXkliAA+3COEa1DAO4Pb4qFN
         /tjE6qYJStaGy7ec3uCOsvR1VJASzDT/2W5ImOR1muOxtsLVaJQFXTDb7/7AqFFTh10v
         bgFc0PLRfDo4OnmrTeOvmMdvXW649UW81GdmU=
Received: by 10.14.123.9 with SMTP id u9mr1289060eeh.53.1303961168841; Wed, 27
 Apr 2011 20:26:08 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 20:26:08 -0700 (PDT)
In-Reply-To: <BANLkTimyFmujc+Lsd7DMWfJgUzZME+Sveg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172314>

Just in case other people haven't noticed...

A sane plugin management architcture also provides a sane way to
manage hooks that might contributed my multiple parties and to provide
a sane way to deal with conflicts between same in a
distribution-agnostic manner.

jon.
