From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: http-smart-backend: can clone, cannot push
Date: Tue, 1 Jun 2010 21:15:45 +0800
Message-ID: <AANLkTimqncJ7aqi_0AvjNimyIPsbVN1zSkAQ1LrPhwne@mail.gmail.com>
References: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 15:15:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJRJy-0001rk-Rd
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 15:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab0FANPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 09:15:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012Ab0FANPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 09:15:47 -0400
Received: by iwn6 with SMTP id 6so796567iwn.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ODuhXts5ZwxFWaDL9BYq9TRAPN19Utidvkr05CpD/+8=;
        b=NCWyVVm0S5McSZE4kYYYER2oy17pB1DFS+ZmHN7n77yCTBKaIxtHDaU9lYTrCrEXmA
         of+C2xLX0BGV936/uHzwZJyp+qqTdHwcBpXycPQTrjbL1Nf6aleZeigxz4bT3VOM6n0t
         giQtcJoSsFMs28aGgN1TmUYl7356ZpqL0nBrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AVMWKg0y6tja019dsfWbFeg9KJZWf5Rn4I0dnZ/zuHwRZXm5BjPrIWP3owf4BpuRuw
         OY2N0neX+fOCGbi25lbOXsovZtQc8d4Eaf9+sE2lOpRuIZNJ6Y7ev5D1a52fSLP6x5ua
         fVG/IM4oJQtqYC/O5Z8fUb7Vr1e+bD7QIK/Iw=
Received: by 10.231.79.4 with SMTP id n4mr7818890ibk.16.1275398146041; Tue, 01 
	Jun 2010 06:15:46 -0700 (PDT)
Received: by 10.231.37.131 with HTTP; Tue, 1 Jun 2010 06:15:45 -0700 (PDT)
In-Reply-To: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148111>

On Tue, Jun 1, 2010 at 8:28 PM, Jeremiah Foster
<jeremiah.foster@pelagicore.com> wrote:
> =A0 =A0 =A0 =A0I cannot push however. This is what git says:
>
> =A0 =A0 =A0 =A0$ ~/administrivia > =A0git push origin master
> =A0 =A0 =A0 =A0error: Cannot access URL https://git.pelagicore.net/va=
r/www/git/administrivia.git/, return code 22
> =A0 =A0 =A0 =A0fatal: git-http-push failed

Can you paste the output for

  $ GIT_CURL_VERBOSE=3D1 git push origin master

--=20
Cheers,
Ray Chuan
