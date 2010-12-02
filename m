From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 2 Dec 2010 14:23:32 +0100
Message-ID: <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
References: <20101202114003.GA26070@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 14:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO98N-0004hF-LE
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 14:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab0LBNXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 08:23:34 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47405 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773Ab0LBNXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 08:23:33 -0500
Received: by fxm20 with SMTP id 20so1122018fxm.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=m9JNvO40d43ckp5ayVaFrp1pM994DpjZpl7SMuo3J/0=;
        b=frXCPTVpIybNLfiqWm0n2a3UpBU5DywGIk1fD9q8AIF2MaC8Ovhzng4G44tZqxG6YL
         11zHtNx4z1I4An4ZANavkqa9Vm1ZCNfuGfYf+LXJbVPfPKk3aY90g0OkHPYGNAo1OCC0
         BE4SEdfSSpGfynDMwzsZMxTcpMSJFuD8sfYdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=T2tZqJ9oKAaapsjhLZoT/N/RSMJjZ/dMiJY+7X7pqgo9oXFWbHiVYie/WSDcH1NtmM
         kAnM8coVawzVKjO/cwzR9NpW0xGKhIqr2ppzbjdaQH/PGXYG0c9nzcsNIJvjzrgKqmoQ
         nAhn9Sy9Pr0EBjgHpm8e2XdkEx1qd/UACETwQ=
Received: by 10.223.71.207 with SMTP id i15mr607197faj.9.1291296212335; Thu,
 02 Dec 2010 05:23:32 -0800 (PST)
Received: by 10.223.74.207 with HTTP; Thu, 2 Dec 2010 05:23:32 -0800 (PST)
In-Reply-To: <20101202114003.GA26070@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162705>

On Thu, Dec 2, 2010 at 12:40, Josef Wolf <jw@raven.inka.de> wrote:
> I am trying to use perl's Git.pm module, but for some reason, it keeps
> bailing out:

Why are you using it? It's for internal use only.

Couldn't you use one of the Perl Git wrappers on the CPAN?
