From: Phil Lawrence <prlawrence@gmail.com>
Subject: Re: git push doesn't honor .git/config
Date: Wed, 31 Mar 2010 17:03:22 -0500
Message-ID: <w2u530ac78e1003311503m3a70b571ge9708428911f6582@mail.gmail.com>
References: <h2x530ac78e1003310754v88853e2bj6d59d835025ec140@mail.gmail.com>
	 <vpq1vf0a5gs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:03:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx60X-0002qP-O8
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab0CaWDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 18:03:24 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:57205 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab0CaWDY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 18:03:24 -0400
Received: by qyk9 with SMTP id 9so599307qyk.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ukBoKeTf1S+mNmANWsIZNi3VTAe9tWVDgrJbzs1zuy8=;
        b=jGbEGvyig723n7TzM35aVn+iSVGeBJG9ikzC906W7yl6SDYLZUFHJobdUZPb/P1JCW
         m3dX9BwlRwXxDZLPNWWbOxjvdL2sshX4li9mbA1q1mB8Sv0dDp6GU9fABHXl6/JDcEYj
         NxwQV5GnfpxVTMw1dF4c3BZO4phaq5berSw7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WmcvA//AEcSfchxAEzdGcnnGCYO8DRLmJkqR56MZgRYQf4ObqmB86bpnsP5JomlvJ9
         dTbUSl+YkdiQS+7La98oZuoMxCVGMqDtObNnw7e3IaeEkrggdRZPREraaPYdOKakHcnc
         U7/G8m1hn9jy6a2CK3RZqKZOeQCheZEeh1feY=
Received: by 10.229.241.202 with HTTP; Wed, 31 Mar 2010 15:03:22 -0700 (PDT)
In-Reply-To: <vpq1vf0a5gs.fsf@bauges.imag.fr>
Received: by 10.229.131.39 with SMTP id v39mr121838qcs.66.1270073003027; Wed, 
	31 Mar 2010 15:03:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143695>

On Wed, Mar 31, 2010 at 10:14 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Phil Lawrence <prlawrence@gmail.com> writes:
>> ...
>> However, .git/config is not being honored by git push; I have to
>> supply all the parameters to actually push changes.
>
> ... or read the man better ;-)
>
> =A0 =A0 =A0 branch.<name>.merge
> =A0 =A0 =A0 =A0 =A0 [...] It tells git-fetch/git-pull which branch to=
 merge and
> =A0 =A0 =A0 =A0 =A0 can also affect git-push (see push.default). [...=
]
>
> =A0 =A0 =A0 push.default
> =A0 =A0 =A0 =A0 =A0 [...]
> =A0 =A0 =A0 =A0 =A0 =B7 =A0 matching push all matching branches. [...=
] This is the default.
> =A0 =A0 =A0 =A0 =A0 =B7 =A0 tracking push the current branch to its u=
pstream branch.

Thank you!  That was helpful.

Phil Lawrence
