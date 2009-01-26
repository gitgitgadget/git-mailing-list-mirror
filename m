From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: [PATCH] Allow format-patch to create patches for merges
Date: Mon, 26 Jan 2009 15:46:42 -0600
Message-ID: <d77df1110901261346k7951809cv240ccddc22bf4884@mail.gmail.com>
References: <1232978650-7008-1-git-send-email-nathan.panike@gmail.com>
	 <alpine.DEB.1.00.0901261604420.25749@intel-tinevez-2-302>
	 <d77df1110901260827j2200fe41oe1b84c387d88aba@mail.gmail.com>
	 <20090126204543.GF27604@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:48:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRZJU-0001Ya-EL
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbZAZVqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbZAZVqo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:46:44 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:39517 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZAZVqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:46:44 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2663688yxm.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 13:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RAJ5CG5YtB9qfZfVWKJvjXPXJ6wCif7j1pb3PoC2csQ=;
        b=efKsnKw2MAtkOOGSWdm0X/NbJoUVDovaEdU2oNV7SBTwdGoLATwMnANlXxGR3V+l/m
         AAIzfMqluZ0YxbWAgqafaKTNBYGLaG4Bnd3XS92oDWSzIGc9yqYgM2zv125IwJ2F7/uB
         La9T/XaowceLu4THi4tcIqP9rvWtpxJ97raJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pmcQJomp5JehCvqh+rRcMOvGtz7MI+4qoft2IFcth5e3td8Gh7Wef1Z64RN/MF4HgH
         +AOVmergU0NyoPUV227idj4p1dAetBS1KEE1ui6ufL1DiKqD1E27f1SUlylLLf+2ye1c
         +2AX3y1Gwn/1tHfTklJRrQEmmAVzZsBsPamw8=
Received: by 10.90.50.5 with SMTP id x5mr130395agx.106.1233006402324; Mon, 26 
	Jan 2009 13:46:42 -0800 (PST)
In-Reply-To: <20090126204543.GF27604@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107289>

I have not used the bundle stuff, but yes, it seems to be a better fit
for what I am trying to do.

Thanks,

Nathan Panike

On Mon, Jan 26, 2009 at 2:45 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 26, 2009 at 10:27:18AM -0600, Nathan W. Panike wrote:
>
>> I think I have an unusual workflow where my patch makes sense,
>> although it probably does not for the vast majority of git users.  I
>> regularly use 3 machines: S, L, and H.  I keep my work synchronized by
>> using git.  Normally, I fetch from S to L or to H, depending on which
>> machine I am working on at the moment.  I also push from L or H to S.
>> I sporadically lose connectivity to S, so I have a hook in the repo on
>> S to send a backup email to me on mail server M, which has a more
>> reliable connection.  This email also serves as a  reminder when I
>
> Have you considered sending a bundle instead of a patch in the backup
> email? That is the more exact equivalent of a push (i.e., it preserves
> your actual commits, sha1 and all).
>
> -Peff
>
