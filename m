From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 17:28:38 -0500
Message-ID: <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
	 <loom.20090216T101457-231@post.gmane.org>
	 <20090216135812.GA20377@coredump.intra.peff.net>
	 <49999ED6.7010608@gmail.com>
	 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
	 <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com>
	 <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>
	 <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>
	 <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 23:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZByZ-0007TN-JT
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 23:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbZBPW2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 17:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbZBPW2j
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 17:28:39 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:1108 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZBPW2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 17:28:39 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1732149rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 14:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0r0gHUl6yamI+gLDXHon3WNLAdP2K4c2pnGopbJbR/c=;
        b=oLvdpa2Lo8EFMkdmamFEb8bbyrvyKKWNvNkFWrHQ/3FZcVzBBDOat8PFMxcjrRYPaS
         ArbnmFXo3kj+rkjYv2G/svJ0Fmwoo34+CsPry4iWQZu2m+dNnwaMVYd9Fwoejo55JhDf
         tTkDSGNjhXMjDZZzM40eJq8s1P48IurLGS8LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h5YSX/EcKZ6SPV3eYT8Z69dNpyh1idvm0XoSG/NF0Q/mEr/JKv2bScMO6eEz3l1Htj
         /hRwfhRdmPsJIEluzFGbZHGyPBQwA36PEk1syw8j5HW88OYvtYMCidfs4thgM+fw0g3J
         3PT0RzVGLj8LLNdF0/TCZKkrvfAdcmKVTwqLc=
Received: by 10.141.210.2 with SMTP id m2mr25038rvq.48.1234823318134; Mon, 16 
	Feb 2009 14:28:38 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110255>

On Mon, Feb 16, 2009 at 4:15 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Not consistent with what?
>
> With pushing into bare repositories.  And worse, with the existing mode of
> operation.

I don't understand why pushing into a bare repo should have the same
behavior as pushing into a non-bare repo. They are different workflows
after-all.

j.
