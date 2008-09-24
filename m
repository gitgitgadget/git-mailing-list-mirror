From: Jhair Tocancipa Triana <jhair.tocancipa@gmail.com>
Subject: Re: fatal: cannot store pack file (git 1.6.0.2 + sshfs)
Date: Wed, 24 Sep 2008 21:05:21 +0100
Organization: Golem. Ubuntu Laptop
Message-ID: <87hc85mhry.fsf@sms.ed.ac.uk>
References: <87iqsmy8q7.fsf@sms.ed.ac.uk> <20080924163400.GU3669@spearce.org>
	<d77df1110809241057rb1d7361pf76a4cde8834b1df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jhair Tocancipa Triana" <jhair.tocancipa@gmail.com>,
	git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 22:06:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiadH-0000hg-DW
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 22:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYIXUFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 16:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbYIXUFe
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 16:05:34 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:59637 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbYIXUFe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 16:05:34 -0400
Received: by ey-out-2122.google.com with SMTP id 6so35299eyi.37
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :organization:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=RtPHcKQFp9bTqqycezNpV9PEkX22M1VSkKfszvNZjws=;
        b=UtWxXQEJ5X6uENanok8OGjqJIXcxAcJqvLcM75DGC+Jnw1MHEuw+LhA3bcX2hgndk8
         jOWjBlVI66bylWLn5CA6oZFxigG8i4FWj0kUamaG9ebDrSgbVJOpu23ViRrqFZi7zhBT
         MHkJxQFAg8NrLS1ugq5ZBEM4nDd16qlwKqFBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=JGDxoZkoDnPFk+kvAYMdBly8tqi4NKWtnq7FerDPo/ND4/OWYN3x+w45OqnKAjFTtM
         RBweDVcjwQlhBJfITnyX0mEJJalGjTflXM2PPus/JyGM2+Fm0SNcPsmLQXTvrzD1Oidd
         JvFvAnFe1pn4mDelc5+l8MMzO1Fp0OVTer0GQ=
Received: by 10.210.52.15 with SMTP id z15mr8986295ebz.18.1222286732439;
        Wed, 24 Sep 2008 13:05:32 -0700 (PDT)
Received: from localhost (resnet-nat-357.ucs.ed.ac.uk [194.81.255.57])
        by mx.google.com with ESMTPS id q9sm7313573gve.5.2008.09.24.13.05.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Sep 2008 13:05:31 -0700 (PDT)
In-Reply-To: <d77df1110809241057rb1d7361pf76a4cde8834b1df@mail.gmail.com>
	(Nathan W. Panike's message of "Wed, 24 Sep 2008 12:57:55 -0500")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96688>

"Nathan W. Panike" <nathan.panike@gmail.com> writes:

> Resend with reply to all:
>
> When I mount with sshfs, I have to give the option
>
> sshfs -o workaround=rename ...
>
> to make things work normally.

I also mount with the same option (-o workaround=rename) to fix other
issues I had before, see

http://git.or.cz/gitwiki/GitFaq#head-c04838bdb94dae45b743fe6ebefde24e4df04c62

Will try with latest gist "master" as advised by Shawn.

Thanks,

-- 
Jhair
