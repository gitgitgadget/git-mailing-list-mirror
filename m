From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 p1.1 00/14] fast-export and remote-testgit improvements
Date: Tue, 27 Nov 2012 00:23:44 +0100
Message-ID: <CAMP44s3LR6T6H8z0LPJr7DHXde-JUoN9X4mWhju-5ECvG7wDpg@mail.gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2z0otie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:24:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td81x-0007yr-Ue
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364Ab2KZXXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:23:47 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44962 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238Ab2KZXXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:23:46 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so11751480oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 15:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oSz8vIqKaA/MEZBwxty4NAFPF3C6allBVAhKZoMfnCs=;
        b=OtbrvzUlQDxUYKRG0USPBRKt+Ea1UA2kRbKyRKKOFRPAuQR6xukscWc2RyBZHCvD7T
         7bC8bM7ICWDjn9dA84rVhVCrzIR3ZhIy57MHpAXWx6G9cc3oYvOOZF3aESPji2VGN14l
         SvBQxU1RHKLxGEBi+NPp9p+h5eREylzWZklmXgN30otZlkSOG1gTdDqQZnt1qE2VaWKv
         mSaG0h6rZ84WBVu64jMlU6dDiyJyggGr+2jGDwmipEzt/4d0yTYoNw0YZFwzyOUxlS7Z
         QJaG14FEfhEyg498seBZHiQN5bJS/Hcf+2v0R49iIoX7ce4yeG08bPhkYQnAYIHFatnT
         w4VA==
Received: by 10.60.30.70 with SMTP id q6mr10379497oeh.103.1353972224684; Mon,
 26 Nov 2012 15:23:44 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 15:23:44 -0800 (PST)
In-Reply-To: <7vd2z0otie.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210513>

On Tue, Nov 27, 2012 at 12:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I'm rerolling this series with the changes fron Junio, plus a bit more cleanups.
>>
>> I dropped the last patch, because I found an issue and a separate patch series
>> would take care of that. Other than that the main changes remain the same.
>>
>> The old remote-testgit is now remote-testpy (as it's testing the python
>> framework, not really remote helpers). The tests are simplified, and exercise
>> more features of transport-helper, and unsuprisingly, find more bugs.
>
> Thanks.
>
> I've queued [v6 p1.1] but not later parts (yet).  The result merged
> to 'pu' however seems to break t5800.  It could be a stupid and
> trivial merge error or something, but I didn't look into the
> details.

Yeah, the last patch triggers that. It should be moved to part2. The
patch "fast-export: don't handle uninteresting refs" should fix that,
which is why I believe it should be applied first. Didn't I already
say that?

Cheers.

-- 
Felipe Contreras
