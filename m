From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/7] Teach fast-import to print the id of each imported commit
Date: Tue, 12 Oct 2010 16:42:32 +0200
Message-ID: <AANLkTinRDoSHhzYnnvckPYyiZrsOX1mJECBMb5bNbMJ=@mail.gmail.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com> <1286891424-2067-2-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 16:43:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5g4B-0006k4-R2
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 16:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468Ab0JLOmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 10:42:54 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51948 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0JLOmx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 10:42:53 -0400
Received: by yxm8 with SMTP id 8so643160yxm.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VL8UWyU5nl+oLT++snP3j44wtHgo8xitknVnQZ+5R6s=;
        b=pvwUHENatq+7u9yEO9vEQhCGKLRq8Rk7ILc0xJD3PhJLGoCL2ThcbAiAWupDKTNwUf
         vxUx9/kf3svmoViunzmho+Xzb+/teodDDc0Ep14MP763eSyXX1IuN90+pwQdL/8Xqs7X
         jrOcIEmmcgtxb5V9I6AIYqF7a5sTB1o3iqGHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=F3igRsFR1re+HJSZ0557d5y+ac0W6tMQN8FFRV+dV2kQyY1EMaUQqjWOd/ViwHH9rf
         N3jwnG+CIdPxEp8lYe2tfgkSS6JgTW2K//XElnsJfJUF4/qvnBLKjKeGfdX1gsm7rM6A
         Q9YtmJfVgV4HIju0heqdFweKi2A/B3XaOHN2Q=
Received: by 10.151.87.10 with SMTP id p10mr8454986ybl.101.1286894572891; Tue,
 12 Oct 2010 07:42:52 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Tue, 12 Oct 2010 07:42:32 -0700 (PDT)
In-Reply-To: <1286891424-2067-2-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158850>

Heya,

On Tue, Oct 12, 2010 at 15:50, David Barr <david.barr@cordelta.com> wro=
te:
> + =C2=A0 =C2=A0 =C2=A0 } else if (!prefixcmp(feature, "report-fd=3D")=
) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 option_report_fd(f=
eature + strlen("report-fd=3D"));

Note that adding it here means that we _do_ support in-stream
'report-fd' specification, which is fine by me since it's overridable
on the commandline, but there was some discussion earlier that we
_shouldn't_ support this.

--=20
Cheers,

Sverre Rabbelier
