From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: More use of levenshtein?
Date: Sat, 2 Jun 2012 17:26:57 +0700
Message-ID: <CACsJy8DuDzxrcb8kbWhH9N=1APQeEOUZzUvSaKCJ7LJ9rc9tKg@mail.gmail.com>
References: <7vzk8m26sf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 12:27:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SalYU-0007JQ-In
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 12:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760095Ab2FBK1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 06:27:31 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35273 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760079Ab2FBK1a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 06:27:30 -0400
Received: by wgbdr13 with SMTP id dr13so2639169wgb.1
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hAKOQrGhaFAWTUVYQ4BP1Zxiu7u4OaW4HVXIELvWcfU=;
        b=m18O2d3pVKshOQx/522ExcG6LtBBMxWwgdcbEPO/U68OdKKhlnixGQUmrhJ0xsKAzj
         Ifvsn6bGcqk1gfOYihMGzrJZ9zfnpus3sh5J7Ha2AWArzWcF9MxDix2IiqirGahQMGwp
         ZoO09xSB2UolWMqGpa5igTiwGMkMvSF0LpD2sU9YkIyMzdes+IWpCPhKi9xSToqwHGJw
         IYAiiO7TWs8S4sv30c6srsiZi1dZznZr8iseMbTgjWnAGWC2nbRm84i564DbhZGcQ4T7
         PiY7xNfzfeW+AyD5osseZHdgWGefjBAYtN6+SJrrVVg1aQNs0nkby31btxM2OTPbG+uJ
         2YzQ==
Received: by 10.216.213.79 with SMTP id z57mr4814572weo.27.1338632848467; Sat,
 02 Jun 2012 03:27:28 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 2 Jun 2012 03:26:57 -0700 (PDT)
In-Reply-To: <7vzk8m26sf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199035>

On Sat, Jun 2, 2012 at 2:04 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Perhaps we could go one step further when we issue this error message=
?
>
> =C2=A0$ git checkout -b jc/ls-files-i-dir maitn-1.7.8
> =C2=A0fatal: git checkout: updating paths is incompatible with switch=
ing branches.
> =C2=A0Did you intend to checkout 'maitn-1.7.8' which can not be resol=
ved as commit?

Yes, please. Also to correct misspelled option names.

In case there are more than one candidate, we should print extra info
(for commands or options, it's one line description; for refs,
probably commit subject line)
--=20
Duy
