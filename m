From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2009, #03; Wed, 11)
Date: Wed, 11 Mar 2009 11:59:21 +0200
Message-ID: <94a0d4530903110259q3db690a3leaceff4ddef2869@mail.gmail.com>
References: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 11:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhLGA-0005IH-JI
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 11:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbZCKJ70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 05:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbZCKJ7Z
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 05:59:25 -0400
Received: from mail-bw0-f178.google.com ([209.85.218.178]:51261 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbZCKJ7Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 05:59:24 -0400
Received: by bwz26 with SMTP id 26so1854677bwz.37
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1t+UI6imhLdfqsrO+OAKO8uHeOw9Z1KRloHCHqUHZtI=;
        b=jP8J32CQ7szkeKh9JyfTD7W4jiHiM30uHaClo9eSM3R8ivBbC/AOe5/NsXLHRc4cVl
         4FJ+055eB2gC5In/fR2wUMnP+8AGow+YPo6j+LtJXbTbbPrRX2oYnkLEFXnCxOqzwUH5
         gzLm00617LrKF0VDz152wrK/CFFg1nP3/hfUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S7jFIdTP+iC2vocTjjOay9wsMh/MS/jA8ro8jFhKKiCqLfueGbWZdH6/Et2INWIvBd
         xsYR45KqkC3v2alQwxeK/o4HU1FcAnhbSaQ+K+WZulyKdCutUUxubmOHH23p3QAEcGZS
         F5WzHy1NNDw2p0P0MbPqK6vJRmPc22gYcNt3s=
Received: by 10.86.53.11 with SMTP id b11mr5794574fga.70.1236765561794; Wed, 
	11 Mar 2009 02:59:21 -0700 (PDT)
In-Reply-To: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112900>

On Wed, Mar 11, 2009 at 11:26 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> ----------------------------------------------------------------
> [Actively cooking]
>
> * fc/parseopt-config (Sat Mar 7 12:14:05 2009 -0500) 9 commits
> =C2=A0+ config: set help text for --bool-or-int
> =C2=A0+ git config: don't allow --get-color* and variable type
> =C2=A0+ git config: don't allow extra arguments for -e or -l.
> =C2=A0+ git config: don't allow multiple variable types
> =C2=A0+ git config: don't allow multiple config file locations
> =C2=A0+ git config: reorganize to use parseopt
> =C2=A0+ git config: reorganize get_color*
> =C2=A0+ git config: trivial rename in preparation for parseopt
> =C2=A0+ git_config(): not having a per-repo config file is not an err=
or

Can you answer my last email regarding this? You didn't like my last
patch and explained me how the config --get-color* stuff works, and
now that I understand I think the patch still makes sense.

--=20
=46elipe Contreras
