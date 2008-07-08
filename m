From: "Rob Shearman" <robertshearman@gmail.com>
Subject: Re: [PATCH 3/3] imap-send.c: Clean up coding style to better match the rest of the git codebase.
Date: Wed, 9 Jul 2008 00:21:30 +0100
Message-ID: <1096648c0807081621x669a9bc4ie484fd004674918d@mail.gmail.com>
References: <1096648c0807070105s2b4ea1d9t2ab1eb17e891e3e8@mail.gmail.com>
	 <7vfxqm5ba2.fsf@gitster.siamese.dyndns.org>
	 <1096648c0807070517o8f22f0cs4d25103675bd635d@mail.gmail.com>
	 <m3zloteukz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 01:22:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGMVx-0000w7-CQ
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 01:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbYGHXVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 19:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759623AbYGHXVd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:21:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:8183 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759616AbYGHXVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 19:21:31 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1980805wri.5
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7Btldb4EWrm+C9073h7vHuyYg+FAsrnIFSFwnHig2+g=;
        b=h3bFw9/Eab2wQI3Y46lm0bKqhuGN+ouVXgf6mY7LovoL7VTEvia7EFD3DYll5KxDU4
         nDmZXS6xNscbYYg5vP5ImgwVRGYoqtie+zdAtZ2tDw3EAG8ooCNVXTyC+LgyMdmEtgf1
         GxjLZ1NyjdUH4YxON1lIzyW1q8bZpbLMee1PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tySkY1U0aiiMjl/kVPml5ZtFhNWy1nZBXqKw/shskvu08yOwTXHDfyCVzVApqdN9/R
         VDthX7lxxf+DaAERu0hplb0ks7ocZo8LOkKs2al83a7W+VUkG3Yx8Ta8qdiWyGMR4KkQ
         I8n3BWG3d1muOhTWkCy6EuzfXr5WrnetIi9Y0=
Received: by 10.90.54.11 with SMTP id c11mr7695539aga.20.1215559290257;
        Tue, 08 Jul 2008 16:21:30 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Tue, 8 Jul 2008 16:21:30 -0700 (PDT)
In-Reply-To: <m3zloteukz.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87808>

2008/7/7 Jakub Narebski <jnareb@gmail.com>:
> "Rob Shearman" <robertshearman@gmail.com> writes:
>
>> 2008/7/7 Junio C Hamano <gitster@pobox.com>:
>> > These patches seem to have been linewrapped severely.  I _could_ fix them
>> > up and apply, but the last one being about whitespace and style fixes, I'd
>> > rather not.
>>
>> 2008/6/22 Junio C Hamano <gitster@pobox.com>:
>> > Next time please do _not_ attach *.diff but follow the style of patch
>> > submission other people do (see recent patch from Linus for example).
>>
>> How do you propose I fix this? I attached the patch last time to avoid
>> the problem of line wrapping.
>
> If possible to turn of linewrapping,

It isn't possible AFAIK to turn off linewrapping in Gmail.

> or use either git-send-email
> (I think you can send patches also via Gmail) or git-imap-send,

Ok, but git-imap-send only puts the emails into your Drafts folder so
that you can send them with your normal email client (which is what
does the linewrapping).

For people not familiar with git-imap-send, it has the advantages of
making it possible to automatically add signatures, reply-to headers,
organisation header, etc. already configured in your email client as
well as saving a copy of the email into your "Sent Mail" folder, if
configured.

> then preferred solution is to have patch inline.
>
> If it is not possible, then attach the patch, but preferrably
>  1) with text/plain mimetype (.txt extension instead of .patch or
>    .diff could be required for that)
>
>  2) 8bit (preferred) or quoted-printable (if 8bit is not possible)
>    transfer encoding (base64 is terrible waste of space); text/plain
>    should chose quoted-printable at worst
>
>  3) use "inline" attachement (select 'suggest to display attachement'
>    or something like that), so it is possible to select attachement
>    and hit reply.

I think this was the case with the patches originally sent, but I used
"git format-patch --attach --stdout ... | git imap-send" so if the
mails didn't meet one of those points then it should be fixed in
git-format-patch.

However, I did follow the first suggestion of using "git email-send"
and then I found it didn't work due to a bug, for which I will send a
patch in due course.

-- 
Rob Shearman
