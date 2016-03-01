From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 16/22] run-command.c: mark strings for translation
Date: Mon, 29 Feb 2016 16:00:00 -0800
Message-ID: <CAGZ79kY8sg7XRUyhkqy7v=MHc83TcGisZ8mUXyHpU-CD2-Mj4Q@mail.gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-17-git-send-email-pclouds@gmail.com>
	<xmqq7fhnbb7j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 01:00:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaXjV-0005ig-90
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbcCAAAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 19:00:04 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35959 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcCAAAD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 19:00:03 -0500
Received: by mail-io0-f172.google.com with SMTP id l127so204880896iof.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=ftM9Opvfrx1d8OU9kdDLFBCbe6pEsz+sXxy9j37ORUw=;
        b=ZsYQa8a66eng45tGKd3KwSMeEp+72tKCRgPFtFZ9bjIj+0LqpXYW2yl9wJddkWpJZ1
         C9qSkS71JayifXLHA7j0EAURX8mJaygLh3rc6NkYjte32obocEwnOaemucK1J0IlqqQD
         9Y5Ncytll4U4N1Tzrqpc8mOuGwIUEKXZmgccllRK24sVrLODc7e4ha8hn8IwgwuTbgur
         GFiG86LVxOEjLyE4Ce1+ZyCoKygsGLXRtVBSxYW6+fpDlGaHjsmE5B9UnqzjWuhEXnOU
         D07+vaNVKtoSN8GWEhbgQSA0hkI0/BJUtq/EoUC2ucbxoJtzg/Cawc8NNyJ9SUmNUycq
         70Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=ftM9Opvfrx1d8OU9kdDLFBCbe6pEsz+sXxy9j37ORUw=;
        b=eQCx0pWxSNLrYu4Xf3opLIFj/4RP4PFOgShMuPVn+tXDUsMtyeHiYe+0LE4VLJwLEH
         gowJELWMliG7lb92G3560hwArfwwM0Y71sXK/FPCF+EqUttyMwqe3cvLruejjYE5IwuX
         6wAloJqBb4AM0HRrSE0m9+cPyYetapgOZ9nsqq9kVrF2IXRDMSMFkDWQGZmmhjW72KPg
         faucYRRh1Y3iCvTBMThL7YibF7ogHcPLEshIXIIPM26NBZur4i7UqpSO9rQTdrVeBibr
         WMRvx4M19LVSIqNCV1miirkpAyXsaWwA138MOZdCo47eHecPwxhcIaK++tmklyqEZ1iL
         Y6uw==
X-Gm-Message-State: AG10YOTqiQon+kcPPKB1eBdinlGxOtQD7QsBRZmqhVu2WdTachOVtU1eYZvFYnphS7ayZdQOiS46dFyuuVs9lFtj
X-Received: by 10.107.168.149 with SMTP id e21mr21753597ioj.96.1456790400279;
 Mon, 29 Feb 2016 16:00:00 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 16:00:00 -0800 (PST)
In-Reply-To: <xmqq7fhnbb7j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287944>

On Mon, Feb 29, 2016 at 10:52 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> This is new and there aren't many non-BUG messages that are not
> marked, so let's take this one for 2.8.0.

This would collide with "[PATCH] run-command: do not pass child
process data into callbacks",
dropping this patch would be easiest.
