From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Wed, 29 Sep 2010 23:29:57 +0100
Message-ID: <AANLkTimbiKGLKKxF-OL7SA7QQG2j4SRgD-MpOHPdW4sA@mail.gmail.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
	<201009282252.25688.j6t@kdbg.org>
	<20100928210837.GA8317@capella.cs.uchicago.edu>
	<7vhbh8o2ui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 00:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P15A5-0008AN-8L
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 00:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab0I2W37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 18:29:59 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37983 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab0I2W36 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 18:29:58 -0400
Received: by qyk36 with SMTP id 36so1642709qyk.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6qN+l6W3ia/ponEG2N6nHJTAyi0LglaPJu8Sd0Ur4LY=;
        b=J92QD4xfYLrk2tdR7J/sCSYBI0bl6T+bfXQzKKbGYFVy5RA2rzfp2G9wOHbnFL3f+m
         N9Pp+mTgoTFWf9Q8me19GMtEHS/BFFXa1aFyE0UA+Aeur+D6dWg4V4z4Q4ZLdGdNcMUD
         5HZqQi67Xw23DgBvTFhZ4jXtzVZhOkVZs2dlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j958eEGBl+V3/kJj6BDkS6gDa8YghoOoQk5vAoEnkYTg4JrvxrSFLeVctvHv3hgCjF
         kj8xxf2K8kMajDYEIUKfo79A0wcIac9kX38yUkqZWcC32xh7dnYMzLVsN22WKA7EKUcu
         mPn8t0xypbneBomQmul+39uuBDEyxl8ll1Wns=
Received: by 10.224.29.4 with SMTP id o4mr1709269qac.203.1285799397688; Wed,
 29 Sep 2010 15:29:57 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Wed, 29 Sep 2010 15:29:57 -0700 (PDT)
In-Reply-To: <7vhbh8o2ui.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157616>

On 29 September 2010 18:51, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Johannes Sixt wrote:
>>> On Dienstag, 28. September 2010, Pat Thoyts wrote:
>>
>>>> Johannes Schindelin (11):
>>>> =C2=A0 =C2=A0 =C2=A0 Avoid TAGS/tags warning from GNU Make
>>>
>>> OK.
>>
>> Wasn't this one reviewed on-list recently?
>
> Yeah, I remember it vaguely ;-)
>
> Although I do not care very much either way, this probably is a bette=
r
> approach, I think, if there are people on MinGW and/or OS/X who use
> tags/etags.
>
> Will queue.

I've just tested this suggested patch with msysGit and it's fine here.
We can go with this rather than Johannes' original.
