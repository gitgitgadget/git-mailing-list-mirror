From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Fri, 6 Apr 2012 22:42:16 +0300
Message-ID: <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
	<7vobr4236g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 21:42:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGF39-0003Ii-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 21:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757853Ab2DFTmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 15:42:19 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49019 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111Ab2DFTmS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 15:42:18 -0400
Received: by wibhj6 with SMTP id hj6so779771wib.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=O+yD5aT5bQ3X4Aw8PqkOsSxiSM+0uWWDD4+3TURg91o=;
        b=BXllPSAcos8xQ9TGL6Hx87Q9SCIPhY4uZVtpqRnScEXoM9bh75skHDBeeDUaTDqilI
         5KeOPBTL/8xg3QAtAsClzU/NyrTYSmEoMXLsNcBvW2bZncRy21hBVVEdUb7JYMD5/sqO
         jDTGCScZmggbr3pnZ+szmsg7Y1U5PfvAAKXbJACZbrI9Lw1bGxJo6UbDBvRERqU+NNtx
         XbwisYvaQfqHa0GhShionjeThSQ5VjoHyVXgNc0vW9h1eCevghDc0Te1SwPisQNFPlVp
         ZNYSyhLCCijId8HS/c4VeeQ/h+ywS/326VgrKu9uWftYGpYOITqKjsVNFW3Jau08g2bf
         Yh1A==
Received: by 10.180.92.71 with SMTP id ck7mr13999068wib.21.1333741337013; Fri,
 06 Apr 2012 12:42:17 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 12:42:16 -0700 (PDT)
In-Reply-To: <7vobr4236g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194899>

On Fri, Apr 6, 2012 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Some mail servers (Microsoft Exchange) mangle the 'From' header, so
>> while applying the patches, the author has to be fixed manually.
>>
>> This option allows to always specify the author of the commit in the
>> body of the message, even if the committer is the author.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> I wouldn't say that the existing option names to send-email are great=
, but
> I have to say that the one added by this is simply horrible ;-)
>
> The first paragraph of the proposed commit log message states the pro=
blem
> it tries to address very clearly, which is good, but is "From: " the =
only
> thing that needs this? =C2=A0I am wondering if this should be named a=
nd behave
> more like "--duplicate-header" or "--in-body-header".

I have never seen any other 'in-body-header' other than From, and I
don't see how that would be useful. Anybody else?

--=20
=46elipe Contreras
