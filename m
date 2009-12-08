From: "James P. Howard, II" <jh@jameshoward.us>
Subject: Re: [PATCH] Add commit.status, --status, and --no-status
Date: Tue, 8 Dec 2009 09:07:33 -0500
Message-ID: <88a2333a0912080607q1881ce68j269eeba75769b1fa@mail.gmail.com>
References: <20091206131217.GA12851@sigill.intra.peff.net>
	 <1260225927-33612-1-git-send-email-jh@jameshoward.us>
	 <20091208060415.GC9951@coredump.intra.peff.net>
	 <7vr5r6ndkz.fsf@alter.siamese.dyndns.org>
Reply-To: jh@jameshoward.us
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 15:07:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0jA-000165-Cd
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbZLHOHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 09:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755369AbZLHOH3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:07:29 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:53146 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbZLHOH2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 09:07:28 -0500
Received: by ewy1 with SMTP id 1so2772335ewy.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 06:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=IpWvopFI/bw08gQP2VgmQWOxiRxAP5SaeizZkhq8+Bs=;
        b=O2KVe30HaCI9D3zaR7bVXT6X2oKUcNOdFtb123ecAU5CHPXmsxe+WdRyHd4tBgfpDt
         Mpo86ZgVRWZN1CjMAUdCLb1414wx3HG1W95G3PAQrExf3VToVpMegT4pZkvzzljXPogh
         KQvjJdRdqL+/GtZbdqdVDzb68D5hVRkSqZB/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=C1/FKlLmpT64rZVu3L+wxMhek1MPqCnVq7Mm6ipFno+X4jMcCL2AUbAgxbO2JDFKP1
         mFSH447uVg4YNt/EyilXoQcAqr2IYJkthyTArw3MFcyR42CwvSQNT7/V9NmLMX8rkzRZ
         aKzdlvAojb2nvbG9FjZIf+y0/DqOTnQFB2PSo=
Received: by 10.216.89.209 with SMTP id c59mr170564wef.181.1260281253705; Tue, 
	08 Dec 2009 06:07:33 -0800 (PST)
In-Reply-To: <7vr5r6ndkz.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 3806ecc7f54722e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134875>

On Tue, Dec 8, 2009 at 02:13, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Dec 07, 2009 at 05:45:27PM -0500, James P. Howard, II wrote:
>>
>>> This commit provides support for commit.status, --status, and
>>> --no-status, which control whether or not the git status informatio=
n
>>> is included in the commit message template when using an editor to
>>> prepare the commit message. =C2=A0It does not affect the effects of=
 a
>>> user's commit.template settings.
>>
>> Thanks, this looks very cleanly done. The only complaint I would mak=
e is
>> that it should probably include a simple test case.
>
> Yes. =C2=A0Also I am a _bit_ worried about the name "status", as the =
longer
> term direction is to make "status" not "a preview of commit", may con=
fuse
> people who do read Release Notes.

Right now, this option does not affect how the commit message is prepar=
ed
in git tag.  If the option were extended to cover that case as well, wh=
at would
a sensible name for the option be, then?

James

--=20
James P. Howard, II, MPA MBCS
jh@jameshoward.us
