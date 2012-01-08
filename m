From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/6] revert: decouple sequencer actions from builtin commands
Date: Mon, 9 Jan 2012 01:37:52 +0530
Message-ID: <CALkWK0=kw=EEXDfnrFkeNV678r4u3v72-=hKh9w8ujRN125NPQ@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-3-git-send-email-artagnon@gmail.com> <20120108193454.GG1942@burratino>
 <CALkWK0kHn+SDaeRHa8bUHWvOEVkr01sVDzvnw9E+-Nne2cii1Q@mail.gmail.com> <20120108200910.GK1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:08:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjz2R-0000lf-Fj
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab2AHUIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 15:08:15 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:61177 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab2AHUIO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 15:08:14 -0500
Received: by werm1 with SMTP id m1so2184121wer.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FOaG7L42f+sJqb9kK8imR+fG3WbEVHHSy+aHt0kmIVM=;
        b=QbHNKy7AvGCcsRjymWiInBsrMZZDoFiUddWTANBhjrOWZSh2OQQXI8vVdENjhpsNeC
         VlgjCwHwRcgSBkBn0kIgXyLy4fkg3pPTtkqsDh3kKrIAcRZc1taEpw8rt/envYg5b8cd
         9ZDaC6GApxJfF5IzEd7F61FoNpKhxNV+M/z0M=
Received: by 10.216.139.153 with SMTP id c25mr2589208wej.25.1326053293177;
 Sun, 08 Jan 2012 12:08:13 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Sun, 8 Jan 2012 12:07:52 -0800 (PST)
In-Reply-To: <20120108200910.GK1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188125>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder wrote:
>
>>> So what change does the patch actually make? =C2=A0Is this a renami=
ng?
>>
>> Yes, it renames "action" to "command" where appropriate.
>
> Wouldn't a simple renaming have a diffstat with the same number of ad=
ded
> and removed lines?

Yes, almost.  A few extra lines added because I needed a new data enum
for the "command"; also added a convenience function: action_name().

-- Ram
