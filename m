From: David Barr <davidbarr@google.com>
Subject: Re: [PATCH 1/3] vcs-svn: rename check_overflow arguments for clarity
Date: Thu, 2 Feb 2012 22:25:31 +1100
Message-ID: <CAFfmPPOeFk871m_N+nLXgQx3Uj4wVhgR9BNFzM2ggtseop0JaA@mail.gmail.com>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
	<20120131192053.GC12443@burratino>
	<7vipjpzxav.fsf@alter.siamese.dyndns.org>
	<20120202104128.GG3823@burratino>
	<20120202105923.GJ3823@burratino>
	<CA+gfSn9Exv3T0UCB-bFShmSvRCMgygVuWraiToR6ZjgOA_sZ8A@mail.gmail.com>
	<20120202111628.GN3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:25:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsunI-0003wn-UF
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757Ab2BBLZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 06:25:32 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37081 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab2BBLZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 06:25:32 -0500
Received: by ghrr11 with SMTP id r11so1036937ghr.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 03:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=FgIqHlAF+neRYSjRgVffEqcaMxxRhHcNfnWUAdQScNk=;
        b=Jhvxti3f/OW+NgWJEtfRy9bnZYMNhY+h1ERMeOoQQC3MmrxLRj11+Rlx3IsNpu40CT
         IMu7KSKNE8o96WnM232Z9R0dF1Ro37AyQdtzk1x55+C14I1jA+1EQ43xTBcr7y8TJrTv
         IVK8esH/dE5zQl8KUxGm5Gb+iTlH3egK7vwRo=
Received: by 10.236.191.134 with SMTP id g6mr3144109yhn.95.1328181931521;
        Thu, 02 Feb 2012 03:25:31 -0800 (PST)
Received: by 10.236.191.134 with SMTP id g6mr3144068yhn.95.1328181931333; Thu,
 02 Feb 2012 03:25:31 -0800 (PST)
Received: by 10.101.197.7 with HTTP; Thu, 2 Feb 2012 03:25:31 -0800 (PST)
In-Reply-To: <20120202111628.GN3823@burratino>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189630>

On Thu, Feb 2, 2012 at 10:16 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Dmitry Ivankov wrote:
>> On Thu, Feb 2, 2012 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>
>>> From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>>
>>> Code using the argument names a and b just doesn't look right (not
>>> sure why!). =A0Use more explicit names "offset" and "len" to make t=
heir
>>> type and function clearer.
>>
>> Well, it's still not clear. Given off_t a, size_t b, check that a+b
>> fits into type... which type?
>> "offset" and "length" don't imply that it's "type of offset" or mayb=
e
>> "type of length".
>
> Hmm... in vector arithmetic, position (i.e., file offset) + displacem=
ent
> (i.e., size of chunk) =3D position (i.e., new file offset). =A0Any id=
eas
> for making this clearer?

Maybe rename to check_offset_overflow to make it explicit?
--
David Barr
