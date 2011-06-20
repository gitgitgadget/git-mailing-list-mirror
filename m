From: Michael Mc Donnell <michael@mcdonnell.dk>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Mon, 20 Jun 2011 12:40:37 +0200
Message-ID: <BANLkTina7Zo6Lg36y87L=fEAGqox8DTTsg@mail.gmail.com>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>
	<20110617141450.GA12114@sigill.intra.peff.net>
	<BANLkTin1DAv0pZmZCcrtDyjrUD-ukO6MNQ@mail.gmail.com>
	<Svak9atXpisIKwqaYKGMzry3LEHEDPnWLLqFpfgP7IOuAVUdRy8brA@cipher.nrlssc.navy.mil>
	<Oe8m5NtYZicsi6Z4FtNIXAfsB9Q9XcHSsoAYmKdxQkoDVJOKykQTEg@cipher.nrlssc.navy.mil>
	<20110617155031.GA24009@sigill.intra.peff.net>
	<tJkMDtbNwQ8q_53P87PeL5TSZPj2DgHxteCyO4IoGfk@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Jun 20 12:40:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYbuO-0006yT-V5
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 12:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab1FTKki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 06:40:38 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53224 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab1FTKkh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 06:40:37 -0400
Received: by ywe9 with SMTP id 9so2016566ywe.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V3iz+MdO4aX0AQMiti411v1JAJ/uahIWE9Uuwrpo7D4=;
        b=Cj/ZctVG3Pgi83zhjRVB+Hv1vo5s8dLftTutMku1yCbRY+EKO3KJQ4jdtA+B6K+Ibi
         hR4jgE2GbVBhdFMG58uaaWFVPNSO7Tq/scdx+NY5bmKkjmmkmA2Gzl9niViLieFHlhu/
         CDk/6CDPBgg/huyoPhdHyysJbbU44PIQiFlPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=fZ7Tjq9pb4MhJ7KyDEZcuYPC6g6rXeY6sK6xKBxxVDzjTydeDLl2xKESrYEifIsgAW
         Hx0z91fByNAvWsvttJHG4shcBRUqLip/0uUrXl9ZtgQqW86aefoQ9fdEp95BucrpFl+P
         bUiFG0J9NWtX/aS4TTwkg6T04bJLdywGJlQeA=
Received: by 10.146.193.16 with SMTP id q16mr5440604yaf.22.1308566437174; Mon,
 20 Jun 2011 03:40:37 -0700 (PDT)
Received: by 10.147.113.1 with HTTP; Mon, 20 Jun 2011 03:40:37 -0700 (PDT)
In-Reply-To: <tJkMDtbNwQ8q_53P87PeL5TSZPj2DgHxteCyO4IoGfk@cipher.nrlssc.navy.mil>
X-Google-Sender-Auth: F9drQbBjDTfvk-Ss0U45ctEQMBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176061>

On Fri, Jun 17, 2011 at 6:54 PM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 06/17/2011 10:50 AM, Jeff King wrote:
>> On Fri, Jun 17, 2011 at 10:37:54AM -0500, Brandon Casey wrote:
>>
>>>>> $ git format-patch --stdout --keep-subject --attach origin | git =
imap-send
>>>
>>> Wait a second. =A0You used --attach.
>>>
>>>>> 2. Open Gmail in Chrome.
>>>>> 3. Open email in drafts folder.
>>>>> 4. Click attachment download link
>>>
>>> Then you downloaded the attachment, which should be a _patch_.
>>
>> Yeah, but if it is text/*,
>
> It is.
>
>> then according to rfc2046, it must be
>> represented with CRLF as the line break. And especially if we are
>> including it unencoded in a message, it is going to need CR's added.
>>
>>>>> 5. Apply patch on a fresh branch with git apply.
>>>
>>> Well, scratch what I said before, you were correct in using
>>> git apply.
>>>
>>> Shouldn't the attachment have it's content preserved exactly? =A0Ma=
ybe
>>> the fault does belong to gmail.
>>
>> Is it gmail's fault, or the browser's? =A0If gmail is handing back a
>> text/* content-type, then my reading of rfc2046 is that it should ha=
ve
>> CRLF line breaks. =A0And it would be the browser's responsibility to
>> convert to native line endings. =A0But that's the MIME spec, and was
>> written with mail in mind; I don't know what's normal for HTTP in th=
ese
>> situations. But if the problem is not "strip CR" but "convert to nat=
ive
>> line endings" (which I think it is), then how could gmail know the
>> user's native line ending preference, anyway?
>
> So it's the same issue of line ending ambiguity that affects patches
> sent inline in the body of the email message. =A0What we really want
> is the _original_ line ending, not necessarily the native line ending
> of the platform, but since any text/* content returned from or sent
> to the mail server must have CRLF line endings, it is impossible to
> determine whether or not the original content really had LF line
> endings or not. =A0Currently, mailsplit chooses to assume the origina=
l
> line ending was LF, based on the assumption that that's the line
> ending that most projects use.
>
> There doesn't seem to be any advantage to using --attach then, over
> just including the patch inline. =A0Maybe attachments should always b=
e
> base64 encoded? =A0I get the eerie feeling that this topic has alread=
y
> been hashed to death.

It sounds like its a big job to implement all those RFCs correctly. Is
there a library that could be used for handling imap?
