From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] format-patch: fix dashdash usage
Date: Sat, 28 Nov 2009 13:18:25 +0200
Message-ID: <94a0d4530911280318nd6ea6d4s7ee159fe173a3f2f@mail.gmail.com>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
	 <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
	 <7vd4355aaw.fsf@alter.siamese.dyndns.org>
	 <94a0d4530911261414o533aa108l202d4c6926da361e@mail.gmail.com>
	 <7v7htc3mqo.fsf@alter.siamese.dyndns.org>
	 <94a0d4530911261523q25147f12h2e6c9e4fe4f6b12b@mail.gmail.com>
	 <7vhbsg25sb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 12:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELJv-0000Ao-1m
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbZK1LSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Nov 2009 06:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbZK1LSU
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:18:20 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:50861 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbZK1LST convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 06:18:19 -0500
Received: by iwn1 with SMTP id 1so1336883iwn.33
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LTnis/akX5dBIi9VLc8qr+vDd6nJVxZ5wJqJoyFQnd4=;
        b=gxOwI6JiUU8Rj151ltpAZZICiYe0vpQf48/qKb44nTVNs/7Y/g+PScJH/0am4xhH5p
         jSC5kthgUD0lHBtKFyydGYlD9LgM4YDwY6SyqCQV/RJoyhLLyReBe3yO2eqO42D9pYK/
         ZUHaep/2IyK6rsOMmCPPMnvia5Q51oRhQznXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FzLQ7pXZo3mDsK6182SqobYFhq8gu6E9rruqLyVhpJG490EkrTrJXaVvosrkAnzniz
         VOIS2aXwVvPpYYa0jN1AH2lfFsabJlkhZii7nD5n28LHEHqyhJw5rG8IEbzTbo5YJRUe
         XqMXOtZ8qNERxHrwVWP+E52IIr7mRFVXVXFts=
Received: by 10.231.167.204 with SMTP id r12mr5038074iby.31.1259407105561; 
	Sat, 28 Nov 2009 03:18:25 -0800 (PST)
In-Reply-To: <7vhbsg25sb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133950>

On Fri, Nov 27, 2009 at 2:03 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C2=A0(0) take your patch with an updated message (eh, that is not "n=
ext step"
> =C2=A0 =C2=A0 but the "first step");

I guess it depends of what is the "fist step". To me the "first step"
is realizing there's a problem. First patch submission is already many
steps afterwards.

But sure, I'll do this next step :)

> =C2=A0(1) make --full-diff implicit and default of format-patch (--no=
-full-diff
> =C2=A0 =C2=A0 could be supported _if_ somebody can argue successfully=
 why limiting
> =C2=A0 =C2=A0 the diff is also a useful thing to do); and

I started writing this patch but it turns out there's no --no-full-diff=
=2E

> =C2=A0(2) document clearly that format-patch takes optional pathspecs=
, and in
> =C2=A0 =C2=A0 what situation they are useful.

I guess this would have to be done in multiple places so it might take
me some time.

Cheers.

--=20
=46elipe Contreras
