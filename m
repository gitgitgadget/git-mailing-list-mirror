From: Gavin Guo <tuffkidtt@gmail.com>
Subject: Re: How do I get a list of all unmerged files?
Date: Wed, 27 Oct 2010 00:23:02 +0800
Message-ID: <AANLkTikthqc9xzJd0sDTXfVW6eGCNjZ0xpZuOmocFTt0@mail.gmail.com>
References: <20101026143245.11433.qmail@science.horizon.com>
	<7v1v7dhrc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 18:23:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAmIp-0002Zb-UW
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 18:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702Ab0JZQXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 12:23:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64832 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab0JZQXE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 12:23:04 -0400
Received: by bwz11 with SMTP id 11so3521097bwz.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+AgCEjw8qOl4MUQtG8YzI0Z+0xJqKs6bczc1MIMkTiw=;
        b=sDNevCwgMeLwGX7nlWJ3S5+AZRKBl0zqMkb9TUflMvPdcK9PHGCRSsTErScRVKzsY6
         ShbAAP1E7j47pOw2tP+ga8ras4HScx0LWDRKlFaTjEJl+sFg59fUm+efQSfOR+ExTVUK
         njNkXiegmo4/p4Nwhjfxdh4iWfVMKxaTNF2KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YPJSyK5pVdcPseueHN5TROFD/eF4UdJwXAE3qufdL/POI9PYj+SBD5zJHi8HGeh3vT
         4VurUU8HyAUk9GWr4IgH+z/dfaMYPgb7b1+FssSZssiNN0yGlBPdcD1XGYjfvdNUE78/
         4I4PTaW7C0QzwIV6pjUVsMaVy3R9NSHIPO3h0=
Received: by 10.204.98.84 with SMTP id p20mr6263579bkn.213.1288110182225; Tue,
 26 Oct 2010 09:23:02 -0700 (PDT)
Received: by 10.204.55.9 with HTTP; Tue, 26 Oct 2010 09:23:02 -0700 (PDT)
In-Reply-To: <7v1v7dhrc7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159997>

2010/10/27 Junio C Hamano <gitster@pobox.com>:
> "George Spelvin" <linux@horizon.com> writes:
>
>> After a merge with conflicts, mostly resolved by rerere, I want to p=
ass a list of
>> all unmerged files to the editor for manual review.
>>
>> I can see the list (wrapped in a bunch of inconvenient human-readabl=
e cruft)
>> in "git status". =A0I can also get a list (again with a bunch of ext=
raneous
>> info) from "git ls-files -u". =A0What I can't figure out is how to g=
et
>> "git ls-files -u" with --stage turned *off*.
>
> "rerere status"?

I think it should be reset ?? or revert ??
