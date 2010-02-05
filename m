From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Showing whitespace on minus lines of diff ouput
Date: Fri, 5 Feb 2010 01:17:06 -0500
Message-ID: <76718491002042217g42e85a70r195cf75e0892dc54@mail.gmail.com>
References: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
	 <7veil0o02z.fsf@alter.siamese.dyndns.org>
	 <7vr5p0kyp0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL3O-0003Bj-JY
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464Ab0BEGRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 01:17:08 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:54680 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab0BEGRH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 01:17:07 -0500
Received: by iwn27 with SMTP id 27so618488iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 22:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=3/yjpGFURrvDaEczgljBcJftswvqDEY2XGGMXvXUd1E=;
        b=XAdx5u6D2j31WVgK1eahgN0I4Za5Ta1oI+EaPFqDjVfRxG7WwUVby6hWrJsNmewFVM
         QKA+bNqsC+kLOvONOcXI/lN5aqD2f5slRHJ+f86xqIsYQ+1GVUHFO5cpVNm5it4+jbez
         Hf8A2bOGGnwIa88KFGivV94/eWcgkvWsR1Clo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=T8dMdclGGcZEdveiNRCRKzPqG45MwB0gqIBOClpgpWMQHYktjFe1tu+UQEFad8c3J7
         aeDNIFmKL6Td2ANnReaFRdwFDihVhzGbc23c7hpzr/CBXjvitSGX0FvkQLLVbrvS0PGK
         CQ2jZU2u/+XYuJuqsObWt/0OdpbtF0UUkkiqY=
Received: by 10.231.145.148 with SMTP id d20mr1066267ibv.3.1265350626112; Thu, 
	04 Feb 2010 22:17:06 -0800 (PST)
In-Reply-To: <7vr5p0kyp0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139033>

On Fri, Feb 5, 2010 at 1:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Actually the reason I don't like the idea to highlight corrected errors
> was not just because "'diff -R' is enough".
>
> The coloring of whitespace errors are like compiler warnings, at least to
> me, and giving similar highlighting to corrected ones defeats the purpose
> by making the output more distracting..

That makes perfect sense. I didn't think it through very well. :-)

j.
