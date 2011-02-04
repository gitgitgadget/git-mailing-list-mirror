From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Fri, 4 Feb 2011 12:17:50 +0100
Message-ID: <AANLkTinFHs=sgcPSAdPMrCORpzTO7no-6CqUi_9AFzXQ@mail.gmail.com>
References: <20110202022909.30644.qmail@science.horizon.com>
 <alpine.LFD.2.00.1102030036420.12104@xanadu.home> <AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
 <AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com> <87bp2sy2mf.fsf@catnip.gol.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Eugene Sajine <euguess@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 04 12:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlJgA-0006Rf-3m
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 12:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab1BDLSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 06:18:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56452 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab1BDLSL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 06:18:11 -0500
Received: by fxm20 with SMTP id 20so2277583fxm.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TdFV/WXtKI5uygA0OXlPjtkbyRrLFBeyrVmVgj/j9oc=;
        b=xBbI6avNtQmdkeCEpW7zDWxwOhEEid60gs3U/s+I30tJF/UfEqS+0mk6GljTwhSN5i
         QHXce/t9ZYf9zSJqBTa1P0writRSQwv83sAEln6WIF243kKHMKzKBdrxPE3/lcOsK9qz
         6OlFWd1v3yxB/ON9QGcxpa+1XuQ95VFrW6SZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=hLXoUUs9qtj6k6VYv9c3uwlT30KSG4PAfODkXvN36rdavZ74Q1HhpI01CVuY2b09Lm
         dleOXrskYbEhnOuStHp3rIiAq3q5WWjMYH1CLImyeu20Ogu8PHx2Lvfwy40n/txzgaXg
         2vSLQ1Hi/fjPXwUg3DXl4CBSnFYelwoSoQg6k=
Received: by 10.223.112.1 with SMTP id u1mr91889fap.109.1296818290141; Fri, 04
 Feb 2011 03:18:10 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Fri, 4 Feb 2011 03:17:50 -0800 (PST)
In-Reply-To: <87bp2sy2mf.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166036>

On Fri, Feb 4, 2011 at 3:06 AM, Miles Bader <miles@gnu.org> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>> Quite frankly, I'm surprised there are (presumably experienced)
>> developers who do not immediately see the value of a little
>> organization. Surely, given the use of code conventions, formatting
>> rules, etcetera, the obvious one step further is to also organize
>> where the files go?
>
> I think one of the problems is that what's been suggested seems like
> window-dressing. =A0Moving everything into src/ and calling it "organ=
ized"
> doesn't actually accomplish much other than perhaps making the README
> file more visible to newbs; things are _still_ a mess, just a mess wi=
th
> four more letters...

=46WIW, I don't quite see what's wrong with "window dressing" here.
Making those files more visible is a good thing, IMO.

But I'm not so sure I agree that the rest of the source tree is such a
mess that everyone makes it out to be. OK, there's a lot of
source-files on the top-level (which would be the src-level with this
change), but why is that such a bad thing? And if this is a big deal,
perhaps moving libgit-sources to a separate folder would help?
