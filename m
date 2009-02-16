From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.2-rc1
Date: Mon, 16 Feb 2009 12:02:27 -0500
Message-ID: <76718490902160902q50c0d730j4f18664455626b93@mail.gmail.com>
References: <7v8wo6bvn9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 18:04:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6su-0003Ya-OP
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbZBPRCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbZBPRC3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:02:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:43741 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZBPRC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 12:02:28 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1625927rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yswVaBq1PTfZksBpwifrJHCu+XOg2nO8jpPXc9CibOc=;
        b=e13D2gTIVdQ2O1A0bz+S890CPbE2GX1onYIiIjiL6ZbQ5cID5P1HDCsId5b8CsfmbJ
         /VmDPUdAY6YzjMnDycvWy8i9ldN6ElEpyXFFrpRFEDjwVBWrp+LsiTXb0bu3LDXXj7CU
         I1UC9wr+LFTpACRlTB5cgwAgdyO6UMOOn43PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fvKikuR8Q8o5w5CVrEkTtTG6N4ZhH5gaN94jUje9dVVUsR3cyhkL0KWUKp9l8xXriP
         TvIBfFlAc53FhS9waYwUpRVcHsIW0LPM7Px0bTTI2JLESJT6CerzSq5DJydGwev/XYkO
         QEjb24S2H17Gd6YdSUdDLhytsMaO6BqhN3gXY=
Received: by 10.141.29.21 with SMTP id g21mr2765807rvj.198.1234803747604; Mon, 
	16 Feb 2009 09:02:27 -0800 (PST)
In-Reply-To: <7v8wo6bvn9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110211>

On Mon, Feb 16, 2009 at 4:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * @{-1} is a way to refer to the last branch you were on.  This is
>  accepted not only where an object name is expected, but anywhere
>  a branch name is expected and acts as if you typed the branch name.
>  E.g. "git branch --track mybranch @{-1}", "git merge @{-1}", and
>  "git rev-parse --symbolic-full-name @{-1}" would work as expected.

I always find explicit examples clearer, especially since you really
have no idea what the reader expects. Some folks just have
unreasonable expectations. :-)

So,

 master> git checkout next
   next> git branch --track mybranch @{-1}

Creates "mybranch" from master, *not from next*, correct?

Also, the "--track" option is an unnecessary distraction to the
example, isn't it?

j.
