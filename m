From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] checkout: Fix test for s/local branch/branch name/ 
	change.
Date: Fri, 29 Jan 2010 22:20:32 +0100
Message-ID: <fabb9a1e1001291320s25e237bdidf40e4b8a432e7b5@mail.gmail.com>
References: <1264799342-11093-1-git-send-email-srabbelier@gmail.com> 
	<1264799942-4531-1-git-send-email-jacob.helwig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:21:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayGx-0002eV-Pq
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab0A2VUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653Ab0A2VUx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:20:53 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:51555 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab0A2VUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:20:52 -0500
Received: by pzk28 with SMTP id 28so1873239pzk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 13:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=jYeFzs/hvU0KWXPZM+qInabVquUSdUHzTB6aaZdaGMM=;
        b=dbrEH4X05a1aX9gXJFXZvgDmdqKBJfOWyKRpIuk3MumTQ6HFjNn/1BDqWPJ//Oi/hz
         buADwhrbo4ZClFqC/+m1Bp1bqC3MM7wI+hb9uWCiV/XKBvChFLNoCpkYjo8u6loIw/XN
         EH6PPUKoDVxMykX4mF75Y9hMqcVXJb6uqClpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uRwdbN3IktkLBqLiGdHTnVvuVDpBgMuT2TVVBBkzbGeiAyHVcD4K9GUHDBhHCUncYN
         iY+6G7xo4XGav9+ffyrLKTej7tiYG0U1xiXa90IL2OKfriFHUuuya4FOSU+QLEsKJpbp
         WSrwV5/I0+pbodeuUsYdypZ+FPev/pdNmrphU=
Received: by 10.142.152.40 with SMTP id z40mr905171wfd.211.1264800052140; Fri, 
	29 Jan 2010 13:20:52 -0800 (PST)
In-Reply-To: <1264799942-4531-1-git-send-email-jacob.helwig@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138361>

Heya,

On Fri, Jan 29, 2010 at 22:19, Jacob Helwig <jacob.helwig@gmail.com> wrote:
> This should probably be squashed into Sverre Rabbelier's change, if this is
> decided as the way to go.

Ah, excellent point, apologies :(. I saw it show up when I grepped for
the message, not sure why I didn't do anything with that.

-- 
Cheers,

Sverre Rabbelier
