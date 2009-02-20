From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Fri, 20 Feb 2009 17:55:15 -0500
Message-ID: <76718490902201455y22b8a861x246fd22845ae282c@mail.gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
	 <499D82BC.7020500@xiplink.com>
	 <76718490902190957td40d425p6b2ae1242060114d@mail.gmail.com>
	 <499F2FF6.10601@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:57:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaeIe-0006A3-1s
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbZBTWzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbZBTWzT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 17:55:19 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:16886 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749AbZBTWzR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 17:55:17 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1131992rvb.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 14:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vc+fCszL+0Q6l1NnIBDjz/xsVqf5G1dGgKNZHn8e6Hk=;
        b=P2DJYqrFcHS6yNY5JUB7+XQTqYkzwVP2Elr8qQMmK0AcnU7xR+wPAcG4CVBdf+6ejV
         Uz2n5gA1t5ga4u6Uo6imzOpFfM/bjmslOwQ5T6whsxORZPCPq1jJGK7QTwsUpt+vIov1
         ATA2HW3NMI5z2zdxifDdtn3MKkCi2/rPY+ywg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qF34Yn585Jw1sGPK1oJRF84zhJY2FPhx/f+dazvaonk58aTPHZLvJodOk2/YWwGQC+
         C03/RjI5DOJKBeUk73DbW7uSQfwZ8Ps3GOjS0gpwcy9VfvKjsxS93wnJysoWy6Asop2r
         zmwYAhtHpakG/PxTt69YEk9UB4covQm9vw3gw=
Received: by 10.141.122.1 with SMTP id z1mr643704rvm.49.1235170515515; Fri, 20 
	Feb 2009 14:55:15 -0800 (PST)
In-Reply-To: <499F2FF6.10601@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110901>

On Fri, Feb 20, 2009 at 5:34 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> All valid points.  But, dang it, I really think intelligently adding that
> extra space the right thing to do.

Already coded. :-)

> It wouldn't be all that tedious -- you could detect the need for the extra
> space in config_read_branches() the first time type is set to REBASE, no?

What is that about everything being easy for the man who doesn't have
to do it? :-)

(It was no big deal, I just needed to rework a few things cause I'd
painted myself into a corner.)

>> I left that out on purpose. The only folks with push refspecs put them
>> their manually, and the raw refspec is clearer and more concise than
>> any English words can convey. That was my reasoning anyway.
>
> Fair enough.

Yeah, I'm fixing this too by properly expanded out the refspecs the
same way that it's done by {builtin-send-pack, http-push}.c.

Hopefully I can have a patch out later today.

j.
