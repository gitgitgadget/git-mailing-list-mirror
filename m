From: Stefan Beller <sbeller@google.com>
Subject: Re: O_NONBLOCK under Windows (was: git.git as of tonight)
Date: Wed, 4 Nov 2015 12:07:25 -0800
Message-ID: <CAGZ79kZk-oAcdVNHsFe_cRhR+TuGi8RqLYigHajC9KJu7ATJJw@mail.gmail.com>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
	<5637D266.4060904@kdbg.org>
	<CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
	<56385587.1010601@kdbg.org>
	<xmqq37wndndp.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbAj-tZS3X1EwFw_gGh1=YU8M0OmEX91W8f++fqs6TiBA@mail.gmail.com>
	<56392106.1010401@kdbg.org>
	<CAGZ79kZM-Q2oxVkMO9=v=tAdJkpWWOTVkaSMRDKZSZia2MY5Ng@mail.gmail.com>
	<563A63BA.9020407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:07:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4LD-0004dC-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 21:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965374AbbKDUH1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2015 15:07:27 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34547 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965309AbbKDUH0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2015 15:07:26 -0500
Received: by ykdr3 with SMTP id r3so92667663ykd.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 12:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hD/J3MyTjza0IZEKqX8lhFeNCIRX42v9J0AyHqJCrzk=;
        b=cDJhjnqfhNmkHHA4aPVt/oviQGg4DwmEyJDeEvdam9g5sGG/VaR71/Kib6If86R7ag
         pJ/21qzKDM0dWfJmNsg97VmVhzY3pHALPL8/9JBipgD4J/6TxFwY8BUO0JcYEDP2h0E4
         EiVo6NfYawoDNMnN/RWUvW830oEkNiMwhJUwuUPPmYdvwecg96AD7VmaEaqBfdIYS37D
         puAafAxsbLY9QEwwJUQ1qc81Z6Fh3Saz4UTn8WOyA1FdTExvTnyfyldVlvAXJFrA2zYI
         HFIbhZexB5tYSVJLRM1lLMo0N4H3Q/mEkmrwHnyvFmc93wG6dYRjulHusB78eT212D10
         V0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hD/J3MyTjza0IZEKqX8lhFeNCIRX42v9J0AyHqJCrzk=;
        b=g4Utqg5ecNlkdk1IX74k18tjpah+7jbBlZdw2GOAH4LecXhfS6Yu20Jm3xPHYtsmrq
         y9rPw6Ub1L6pOx89TN2ASmktNACxGDd3VN2BqPpBV7x1uuTUTcP/JIpVcol1D89jEOxH
         FRoMR+ILn9/G23bhNxoygSIvIeLxOJXK2PP4cxSWGBtkvgz9xzbCh7LO2fiWr3ONhJmR
         4Q4YkWRmWehVBe41/7diNrpCS4rSNifNiCX9hELe3mcW5YHVSXoZ+WtgFyHTgUf5dtbX
         0n0jls72Jhbq3W4hEVdPCOVbRTUZW7JHh5tT4BfibNAfRezFYMz5iZcRXrVO4BdRFtSU
         YjFg==
X-Gm-Message-State: ALoCoQl4qQvHvl1XbYPVu08kBxtKigLKugePpiY/GOHc/Xwkx4APwdX6jOEvrZ5mLqyYONhi1/on
X-Received: by 10.129.78.67 with SMTP id c64mr3321204ywb.320.1446667645985;
 Wed, 04 Nov 2015 12:07:25 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Wed, 4 Nov 2015 12:07:25 -0800 (PST)
In-Reply-To: <563A63BA.9020407@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280877>

On Wed, Nov 4, 2015 at 11:59 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 11/04/2015 12:00 AM, Stefan Beller wrote:
>> On Tue, Nov 3, 2015 at 1:03 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>
> The #ifdef assumes that Windows never will have O_NONBLOCK/F_GETFL)
>
> Does the following make more sense ?
> #if defined (O_NONBLOCK) && defined (F_GETFL)
>
> Or may be:
> #ifndef NO_O_NONBLOCK
>>> #ifndef GIT_WINDOWS_NATIVE
>>>         int flags =3D fcntl(fd, F_GETFL);
>>>         if (flags < 0)
>>>                 warning("Could not get file status flags, "
>>>                         "output will be degraded");
>>>         else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
>>> #endif
>>>                 warning("Could not set file status flags, "
>>>                         "output will be degraded");
>>> }
>>>

Reading Junios answer to the resent patch[1], I am currently debating
if this is the right way to go anyway. As Junio points out, this is
not a warning
but rather a critical issue such that we'd maybe rather die(...) than
just warning(...),
which would make the discussion about the correct condition in the #ifd=
ef moot.

[1] [PATCHv3 02/11] run-command: report failure for degraded output jus=
t once
