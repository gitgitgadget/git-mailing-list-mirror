From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git -- how to revert build to as-originally-cloned?
Date: Fri, 20 May 2011 16:42:34 +0200
Message-ID: <BANLkTi=nFf_6oULwqtC=--JBS9py3fvjwA@mail.gmail.com>
References: <4DD44DCD.7010508@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Lumby <johnlumby@hotmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 16:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNQvG-0002EG-12
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 16:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935003Ab1ETOnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2011 10:43:06 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44583 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933468Ab1ETOnF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 10:43:05 -0400
Received: by qyk7 with SMTP id 7so316377qyk.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=/BF5y3JTjyMcU3sTBYVBGe6P1cvSKcNlA1SrE/MBTJk=;
        b=dm42POfX1+DgndxISlWPPwpq+s6EnIFlQGrYyKVXTV8Dsz1nNYOvlzfzmKvvVDSD6+
         DmnYuUeGrfda/q6+qRONKtZzDl0ZUCV30MrQ0vbZTozHp6wLIcUHteudBsTsu0gRXkhR
         rbkPdtLFlQ/8dlcOBOwW8KsrqWrg9WdgV+6V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vPi1yPl6cTI12PTeHVLaeEGkKy0dICUcSRMJOj1GQYB9lKooBjmfGLnKoZVBg/bJtv
         mJuHBxtcLgwonxJqc3inqG0628uQEEyQd6n2GWw/roAHN3TQw3fQXaPilEpOE2GEqh5e
         35oqdrsTA0hYUtQtrKVLO4ARpkpym784HwOGM=
Received: by 10.229.68.203 with SMTP id w11mr3316796qci.291.1305902584332;
 Fri, 20 May 2011 07:43:04 -0700 (PDT)
Received: by 10.229.100.132 with HTTP; Fri, 20 May 2011 07:42:34 -0700 (PDT)
In-Reply-To: <4DD44DCD.7010508@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174062>

> am stuck trying to revert a private kernel build back to the state in=
 which I originally cloned it,
> (after probably doing the wrong thing =A0- =A0as below). =A0 =A0 Hopi=
ng someone can advise.

I just wanted to add that usually when I "mess up" and want to revert
to a previous state, I usually simply `git reflog`, find where I was
before messing up, then `git reset --hard` to the desired SHA1.

Hope it helps,
Philippe
