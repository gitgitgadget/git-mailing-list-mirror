From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 09:37:55 +0800
Message-ID: <be6fef0d1001131737i59b2e843ib032c30027520b54@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04>
	 <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
	 <87eilt5uzx.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 02:38:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVEeu-0003D3-7y
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab0ANBh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 20:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993Ab0ANBh5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:37:57 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:49879 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab0ANBh4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 20:37:56 -0500
Received: by iwn32 with SMTP id 32so114791iwn.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AH9emLtR0Ep9w9DlcXD3pYST2gF64yO23uY3layG3FA=;
        b=QSNOveBvCtCt0yUv9WYDeYSsfpAk6AwT08xHvzaa3+cW/Czy74Jlc6BwIFJB4Ouxl6
         C4V7rVq66Rn5ww+HWZuGhpbVRvWhmD70lNFpx68T2xI6iWuBFXBgl+7OlCCPjP8HWtV0
         l7X1dBlpenceiXTuqbjgRhNbITZ/92O7jsZWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Izm83IUwQ3RXi0it3+v6iCgtpwyCqkbSAzR8e1g0kQef82R5ZgU6K/9ENDJe1nb2Jd
         Nfe4S2UFpUwKbJtlNiBJCDSgiSwd+fg/PLd0TxckQk3UyQA4VLXeEY1bJlEj0rz2jsoA
         YSk+i4D5QjeTvGueen63Jf5vPivE1cYEW210c=
Received: by 10.231.125.19 with SMTP id w19mr142696ibr.8.1263433075725; Wed, 
	13 Jan 2010 17:37:55 -0800 (PST)
In-Reply-To: <87eilt5uzx.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136921>

Hi,

On Thu, Jan 14, 2010 at 9:35 AM, Miles Bader <miles@gnu.org> wrote:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>> before I put up my comments on the patch, I wonder if git-push is th=
e
>> best place to add this feature, as git-push usually deals with
>> "pushing" data to another repo.
>>
>> I think git-branch would be a better place to do this.
>
> No. =A0I think push is absolutely the right place to do it.
>
> I very often create local branches and only later decide that I'd als=
o
> like to push them to a remote -- but just as often, or more often, I
> never do so. =A0It would be extremely annoying if I had to make that
> decision at branch-time.

I'm not saying that the feature should belong to git-branch and so you
have to make this decision at branch time - I'm saying that since this
has got to do with modifying branches (sort of), it should be in
there.

--=20
Cheers,
Ray Chuan
