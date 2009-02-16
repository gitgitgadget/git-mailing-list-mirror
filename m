From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] format-patch: thread as reply to cover letter even with in-reply-to
Date: Mon, 16 Feb 2009 12:52:50 -0800 (PST)
Message-ID: <m3bpt2t8a6.fsf@localhost.localdomain>
References: <cover.1234801852.git.trast@student.ethz.ch>
	<1234810812-30499-1-git-send-email-trast@student.ethz.ch>
	<76718490902161222p7f1ecbf9x6f965ff94b3cfae7@mail.gmail.com>
	<200902162134.28850.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 16 21:54:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZAU7-00066Z-2G
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 21:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZBPUwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 15:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZBPUwy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 15:52:54 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:36064 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZBPUwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 15:52:54 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1833344tib.23
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Sb9iNMuGXC9MMVL6FWkHnri8DXdAxPa3AABzqklR1+w=;
        b=J2oc73xJMONsegvDbm1rwDFUdHENQSASkw7vtVEH504g7AEtk1nN/53Vctn5iaGQZ5
         fQpqa4cKyeJooveW7SPZ7ETDz2MmQuDm+TsTGCkEP+j5oeoMyG3rb1F559/njW228n8e
         D6MhrEQj9JCXMUDV50mOiUWganxSOlG43ZOV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ivpaaSuIe2F4uEG3qlc8MEmjkFgblSycWuXXHTTAVbBIhv6+UKiUTTbKZh23sh/aFO
         zimEA0H+SLI/6y+LKG26GiGAe/XtdaK4FErSGK7sv44hEnAn/fEfINhBavotvdcFMmsx
         NGn/FzcUZDKopP2ZQ9zN+rRaepxQ71ZgODTrI=
Received: by 10.110.86.3 with SMTP id j3mr9188607tib.51.1234817572138;
        Mon, 16 Feb 2009 12:52:52 -0800 (PST)
Received: from localhost.localdomain (abwe74.neoplus.adsl.tpnet.pl [83.8.228.74])
        by mx.google.com with ESMTPS id 2sm1609208tif.6.2009.02.16.12.52.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 12:52:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1GKpvRE005754;
	Mon, 16 Feb 2009 21:52:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1GKpTD5005747;
	Mon, 16 Feb 2009 21:51:29 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200902162134.28850.trast@student.ethz.ch>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110239>

Thomas Rast <trast@student.ethz.ch> writes:
> Jay Soffian wrote:

> > I think this change may be okay, but I think to go with it the
> > cover-letter and all the patches should have a "References:" header
> > with the message-id given by --in-reply-to.
> 
> That's a completely separate issue.  I'm only proposing to change
> what is formatted as a reply to what, the In-Reply-To and References
> formatting is handled by the existing code.

Perhaps a follow-up patch then?

>  That being said...
> 
> > RFC 2822 says:
> > 
> >    The "In-Reply-To:" and "References:" fields are used when creating a
> >    reply to a message.  They hold the message identifier of the original
> >    message and the message identifiers of other messages (for example,
> >    in the case of a reply to a message which was itself a reply).  The
> >    "In-Reply-To:" field may be used to identify the message (or
> >    messages) to which the new message is a reply, while the
> >    "References:" field may be used to identify a "thread" of
> >    conversation.
> 
> The References formatting can't satisfy the following requirement, two
> paragraphs further down in the RFC,
> 
>    The "References:" field will contain the contents of the parent's
>    "References:" field (if any) followed by the contents of the parent's
>    "Message-ID:" field (if any).
> 
> because it doesn't have access to the mail being replied to.  It
> merely sets References to the same as In-Reply-To.

I think "References:" field can be shortened, and although IIRC it is
recommended to leave first ancestor, two separators, and three last
ancestors in shortened "References:" header, it would be better if
patches had both '--in-reply-to' message id AND cover letter id in
"References:" header.  That would make for safer threading...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
