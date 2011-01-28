From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: Why git tags are there in git?
Date: Fri, 28 Jan 2011 10:03:22 -0500
Message-ID: <4D42DABA.5060603@gmail.com>
References: <1296214676536-5969544.post@n2.nabble.com> <4D42B623.5060709@sysvalve.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vikram2rhyme <vikram2rhyme@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=22L=2E_Alberto_Gim=E9nez=22?= 
	<agimenez@sysvalve.es>
X-From: git-owner@vger.kernel.org Fri Jan 28 16:03:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiprI-0006Ky-Py
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 16:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab1A1PD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 10:03:27 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33989 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1A1PD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 10:03:27 -0500
Received: by vws16 with SMTP id 16so1140955vws.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=5M5ZrPFDw80XtGNvH2R3nZ4qjaHhd97Bv3QrIjdy6ek=;
        b=l8zoJdrbSf3Br5qYBlGzgTmDripESJkE77d5OcHY1AfhvVhu+7OMsAnEHF/RK0/XOl
         jLwwf0oEB3o/xO9wKj8HE7a8CK9CruEJlsC1TwAHNVdMMLajH4mYUlVmHPOd0T8avR8q
         6atfT8eAcB5usFcYz+uputfh75ICKISuudDXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=vfPezeF6wVsm60xxgRPkci5TwOw16drvmuDE0La4j2l92ewP9RTTJrBYXaI9ktVVhH
         nLyX9McC2dMq5Gs0JPO2oCH310NqNU9YIwlPqCZ9oxRPdB7lT4rVpAV6w15IqNDOeLx8
         eYybx03gr+jJoVekEJZGIrW5sGI0KxBWOnk4o=
Received: by 10.229.183.135 with SMTP id cg7mr996336qcb.210.1296227006301;
        Fri, 28 Jan 2011 07:03:26 -0800 (PST)
Received: from [192.168.2.203] (dsl-149-236.aei.ca [66.36.149.236])
        by mx.google.com with ESMTPS id s10sm12687258qco.35.2011.01.28.07.03.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Jan 2011 07:03:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D42B623.5060709@sysvalve.es>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165619>

On 11-01-28 07:27 AM, "L. Alberto Gim=E9nez" wrote:
> On 28/01/2011 12:37, vikram2rhyme wrote:
>>
>> Hello friends
>> I am wondering why the tags are there in git. As they are just point=
er to
>> the commit
>> we can refer those commit by SHA sum only then why tagging?
>=20
> Hi, I tend to find easier "release-v1" than 2cff0e391ab127ae...
>=20

In general, tags are used for marking a point in time. That marker won'=
t
move, whereas branches can move with time.

=46or example, in most projects tags are used to make it easier to refe=
r
to commits that mark official releases. In git.git (git's own
repository), the tag v1.7.3.5 points to the release with the same numbe=
r.

--=20
Gabriel Filion
