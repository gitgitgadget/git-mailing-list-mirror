From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: How to ignore a modified file?
Date: Thu, 5 Mar 2009 14:58:02 +0100
Message-ID: <fabb9a1e0903050558q311f0a7fy50a5c29fa86067ca@mail.gmail.com>
References: <20090305145308.6117@qkholland.gmail.com>
	 <fabb9a1e0903050209i1e70c8b3n69d7ade9e382b617@mail.gmail.com>
	 <7v4oy82rt4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Quim K Holland <qkholland@gmail.com>, dealmaker <vinkhc@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 14:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfE6s-0003wk-66
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 14:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZCEN6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 08:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbZCEN6H
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 08:58:07 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:47797 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbZCEN6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 08:58:05 -0500
Received: by bwz26 with SMTP id 26so3266714bwz.37
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AHwlJ08Io5M8t3uYasTn5RIn85VLqKAZhOHojCOZAHw=;
        b=n/YZLjjeEayDuiFa0MPgifdURzvA/4uZnmbdd7NZt1AAejD8wchgogNi6XaLOp/kle
         uEAjrMOgzaa9aamDenu8YXCgZfXlUR7mI/RaJktPDBNfrvr+Qf9qEd2N/c0qlssHDRuS
         /K4OrG47Rgu9f+I3Xtj78MzL7lbusnH3juubc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kEaXohnwtnhMvf/j/G4zo/gD532A8dYau1j7RFV/CMPSSY0/s0KqGAHwfP3ldbHjLh
         3rn5AvJwt9hJj6HczOvlRNoIKyLmBksX6JYPhz/aol7wFqu4fFCvrcKLbVUU/o7yRxk1
         KNS5Oleq5C3ZN6pGtyEiVwknr6DbxGJHiNDFg=
Received: by 10.86.53.11 with SMTP id b11mr951857fga.70.1236261482163; Thu, 05 
	Mar 2009 05:58:02 -0800 (PST)
In-Reply-To: <7v4oy82rt4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112308>

Heya,

On Thu, Mar 5, 2009 at 11:21, Junio C Hamano <gitster@pobox.com> wrote:
> Yours didn't *ignore* changes, but staged (and would result in a later
> commit) a different change to these paths, namely removal of them.

You are of course right, thank you for pointing it out.

-- 
Cheers,

Sverre Rabbelier
