From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Thu, 1 Nov 2007 08:05:44 +0700
Message-ID: <fcaeb9bf0710311805t2083bc75mcb6ed47ee1144ac0@mail.gmail.com>
References: <1193861145-20357-1-git-send-email-mh@glandium.org>
	 <alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Mike Hommey" <mh@glandium.org>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 02:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InOVn-0002sh-G2
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 02:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbXKABFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 21:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbXKABFq
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 21:05:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:27382 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbXKABFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 21:05:45 -0400
Received: by nf-out-0910.google.com with SMTP id g13so334430nfb
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 18:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vT7bN9nQdJnwQciPXb2ccwy0yhHUEF+4UGFwFfMEPy8=;
        b=Pm/zhNh7DupRtwkEUgPvvysMFOdPs2rF32wNmgqieV/IgKqj/rdG789DqCxvUyshfHSgbr76FAn5VEsUxPxiCCZLWWthJuMjehm/cQuKloeGMEI6CTjzU2qHJLOM4+qEjIAo7ip06QqgJmk59ZRckonqoZu3MvW6mlBN5x0jox8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TkRM47PCVLHZdm3R6a/qs9vfNqbcRriOQxd1giZP0r2P+OA3YUwLMhQV7CxqFdNNB/FEOd4/enygq33FxfnNueE64aiPU9A8DwZ3rhpW35skL34Nx8SotTQ4poSHf2Lb9eZ+ToSFmacJe4IEcgaW/YbdGdQFNWSVtydVDSW3Jh4=
Received: by 10.86.91.12 with SMTP id o12mr1081fgb.1193879144311;
        Wed, 31 Oct 2007 18:05:44 -0700 (PDT)
Received: by 10.86.73.5 with HTTP; Wed, 31 Oct 2007 18:05:44 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62902>

On 11/1/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Wed, 31 Oct 2007, Mike Hommey wrote:
> > +     if type cpio > /dev/null 2>&1; then
> > +             local=yes
> > +     fi
>
> Isn't "type" a bashism?

busybox ash has "type". I'm happy.

-- 
Duy
