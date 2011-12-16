From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 19:28:22 +0100
Message-ID: <CAN0XMOJFCwORt_VaddgeeCNp3S-nm8DxYDPDyPCsVngRhuEP6A@mail.gmail.com>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
	<vpqr504wf70.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:28:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbcWL-0003SQ-5m
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760503Ab1LPS22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 13:28:28 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46059 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760464Ab1LPS2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 13:28:22 -0500
Received: by yenm11 with SMTP id m11so2433062yen.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2g+V2NhAQ7n8sqmcvgOSeyXw4bi7i498b6PjQSPLN94=;
        b=A7r+oOb1DWbaLPGz968+j8zUdMb6jE4k49HA2UvDLNm75idic7Y3jbZoDuNRtH1gFh
         SCHrV+5Sq6yerhhsFVa2GYheYDESEIdPfZC9JYODmfSENdkkGEqWAldaulIkFzTcHg5a
         qYhWHtC7U6arhubkbnFDpVGoqa8PkR0YDhJGc=
Received: by 10.236.123.108 with SMTP id u72mr13581393yhh.45.1324060102350;
 Fri, 16 Dec 2011 10:28:22 -0800 (PST)
Received: by 10.147.22.19 with HTTP; Fri, 16 Dec 2011 10:28:22 -0800 (PST)
In-Reply-To: <vpqr504wf70.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187297>

> What behavior would you have expected?

I've expected that git doesn't change the line endings
because it's already CRLF.
