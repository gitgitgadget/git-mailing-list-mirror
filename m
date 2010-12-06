From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: path/to/some/file: needs update
Date: Sun, 5 Dec 2010 19:44:32 -0500
Message-ID: <AANLkTinFHFzjLNb5PpoH8WG_3gHpo4LaZaUOYX-=PFYN@mail.gmail.com>
References: <AANLkTinsUZCUJamUHWN=H7tyL5nKACmEcyvG6hpsTDtv@mail.gmail.com> <vpqk4jq3cpc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 06 01:45:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPPCN-00069W-So
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 01:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab0LFAoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 19:44:54 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60190 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab0LFAoy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 19:44:54 -0500
Received: by fxm20 with SMTP id 20so3760298fxm.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 16:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wmnpy3QNohZdFN9QOzP6fDSw1IcC588LQ5gAJxMmK10=;
        b=b176FIi8Xja+Uyw53RGYXdN2LGgeO8pFLDLEqNRuwDoynDXBU9CXpTkXPw4YwoI9Ir
         ROV7ixyGDo/H/Tx5Ffgaiw6xyoQPdEgAUgKY6vp/850okk7TVZo/mPCybJa+UqR2Tzj1
         t95kq2ww1yFpPyAikJk1af2LlGt1eiaxmiFjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jNWOdTDeYCb3XRn6rc8JLCrBT1WvGFO+HRvZaOLdKfgAIPjBJv6Kh2c90+Q3b67Zaf
         FkpmpbEUQMlf+TTXigrXL4wgH0c0SIGTCrX5l2X5t+4VcUj6TlGxGW21LxcfcXUp6q1H
         MsaX3gzo9+TUQdKa91iHfpQtOWWeM6LIyRvE8=
Received: by 10.223.118.132 with SMTP id v4mr4993342faq.87.1291596292842; Sun,
 05 Dec 2010 16:44:52 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Sun, 5 Dec 2010 16:44:32 -0800 (PST)
In-Reply-To: <vpqk4jq3cpc.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162968>

On Fri, Dec 3, 2010 at 1:58 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Patrick Doyle <wpdster@gmail.com> writes:
>
>> path/to/some/file: needs update.
>>
>> Then things got worse... one of the messages said:
>>
>> error: Entry 'path/to/some/binaryfile' not uptodate. =A0Cannot merge
>
> Which commands triggered these messages? Which version of Git?
>
> AFAICT, these messages never appear anymore in normal (porcelain) use
> in recent Gits.
Ahhh... that's something.

I just checked.  The box they  were using is an RHEL 5 box that has
1.5.5.6 installed on it.  Perhaps it's time to upgrade their git.
I'll go see what repo I need to add to RHEL to get a more recent git.

Thanks.

--wpd
