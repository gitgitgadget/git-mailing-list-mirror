From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 21:53:16 +0100
Message-ID: <CAN0XMOK9P_25M0bVjYn9gZ+ONi7yKEZX+83X_mwJok+P5TEVoQ@mail.gmail.com>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
	<vpqr504wf70.fsf@bauges.imag.fr>
	<CAN0XMOJFCwORt_VaddgeeCNp3S-nm8DxYDPDyPCsVngRhuEP6A@mail.gmail.com>
	<20111216200955.GA8499@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
X-From: git-owner@vger.kernel.org Fri Dec 16 21:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbemX-0006Vc-GR
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 21:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245Ab1LPUx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 15:53:27 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63527 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762Ab1LPUxR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 15:53:17 -0500
Received: by yhr47 with SMTP id 47so3198248yhr.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DrUom0tG29qMU0TVoOs9JOhtFgDhprUAPssTKNnbkqQ=;
        b=QGvTXBBL/zg1c9wQsrg0wSjU/71ug8QP68iAcxpmiXVXMHcUDCN8H2rQzDcApaa/YD
         Mpj9FftVLj7hL9FybIvbW4ctcu/f/VxAwSLqdFtPeO8h4xzN5kjWQ3dcC4tsx8UqsIig
         mLHmAyDomzJbyqgn8ZtOYlh0EioAQ1R6/0pOE=
Received: by 10.236.153.226 with SMTP id f62mr14736001yhk.62.1324068796728;
 Fri, 16 Dec 2011 12:53:16 -0800 (PST)
Received: by 10.147.22.19 with HTTP; Fri, 16 Dec 2011 12:53:16 -0800 (PST)
In-Reply-To: <20111216200955.GA8499@angband.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187318>

> And how exactly can it change the file back the way it was?

It shouldn't need to change the file back. That's actually the bug. :/
