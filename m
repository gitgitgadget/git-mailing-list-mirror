From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 1 Feb 2011 23:02:48 +0700
Message-ID: <AANLkTimgv6Hhbu8B9wiydwn9WQrgKfmT+hEyJKbkO6RB@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <20110201014807.GA2722@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101312238170.8580@xanadu.home> <201102011342.06910.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 17:04:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkIiM-0001XT-Cc
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 17:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1BAQEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 11:04:16 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39945 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab1BAQEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 11:04:15 -0500
Received: by wyb28 with SMTP id 28so6835155wyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 08:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KWcQGOOMPFsmXu+Cyu04lg5v4+9sLGZKiBj1/Geaknw=;
        b=eo9+QlUmcbmIEK6V4tWdvW7s70pSjdF9W8Mdpmuxs0yBJ4VuF0AkkmY3m6cBPtMgGg
         pu4YgVzwWrCWFfbBZplaBBIc/MbUY64R8OP2Jw1JxGJ0jt+3xtt3Zd7RjR1uOXIcRi76
         Gkn7YPgpKczbb/asm/YWQNgtr66CJBI4Xkg0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vgaWGCiziHElfl2O23ovCkbctmHoDIgqvwnSMEvagDk+ks1bpWhustZQOYIg3zLCXx
         SqYPSDCQKcUTI8BjPlK05qT1Imm7WnRxyq+tWA5+HBcSj6hqtUhahkKzDkQ5nNb5PfmK
         BtLBevoSqok3O5x5DkL+Jq5WCqdkHyTfglPKQ=
Received: by 10.216.177.9 with SMTP id c9mr7524166wem.34.1296576254321; Tue,
 01 Feb 2011 08:04:14 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 08:02:48 -0800 (PST)
In-Reply-To: <201102011342.06910.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165821>

On Tue, Feb 1, 2011 at 7:42 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Nicolas Pitre wrote:
>> What I see in the root of the Git source
>> tree is a huge clutter of source files, binary files, scripts, and
>> subdirectories all mixed together. =C2=A0If you know by hart where t=
hings are
>> because you've been hacking on them for the last 5 years then of cou=
rse
>> you might not see the point. =C2=A0But since I didn't work much on G=
it
>> lately, things are not as obvious to me as they used to be. =C2=A0Lo=
oking
>> back at it now with some distance, this tree looks like a mess and i=
t is
>> really annoying to work with.
>
> But judging by that assessment, shouldn't we strive to make it
> *easier* to find things?
>
> In particular a prospective git hacker would not care whether
> something is a source file or a script (you seem to imply the
> opposite). =C2=A0He would instead expect ...

A hacker is expected to RTFM first, IMO. Put up a document describing
how things are organized in git and we're good. git-grep will take
care from there.
--=20
Duy
