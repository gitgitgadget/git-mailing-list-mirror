From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: ks/precompute-completion
Date: Fri, 23 Oct 2009 15:09:26 -0500
Message-ID: <fabb9a1e0910231309r41bc8fb6h61898318ed5568b0@mail.gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com> 
	<4AE0DAB3.1030103@gmail.com> <fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com> 
	<fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com> 
	<4AE0E542.8010501@gmail.com> <fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com> 
	<7vd44eaqc5.fsf@alter.siamese.dyndns.org> <fabb9a1e0910231216j2a024ac5mf5b5ccb5322722f8@mail.gmail.com> 
	<7v1vktc1uk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitzilla@gmail.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 22:10:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1QSW-0005g3-NZ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 22:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZJWUJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbZJWUJn
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 16:09:43 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:57582 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbZJWUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 16:09:42 -0400
Received: by ewy4 with SMTP id 4so1984683ewy.37
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=4a82jnTqxH58tb3lu11B6DaghnVcevKZZ+XnsySV550=;
        b=RaB6+1CKPa//0zfnsfMHQPc+Y7rzBpzv8XneoXv8YaEH7bvKiYW7ysZosyBNNxoU5H
         E6twbgr4WsfxhB8YLfJyvMB7pO/Vw0fVbPoVfwhSrVmC1pTf6MSup5n4VKvq2uu2K+Bp
         lz3PfPHRowXgX2PW5W1lVoq7+IKKlqq9qTheE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=INtPYCybmepPJHowU4Tdalzz3uvzEE1HWuH6w87aEez2Jmy/pdNax0ccLCer3HGWNd
         PPVxk4OXIGlWuV+naXQaQXUR1ZGzP8RHAjDTObtZ+U40EY1yBh42niN1AoWwWEfC8Ofb
         yRRWEwcZdQ4ttgfvYpVIPyUHjgNqE4p1vCKWw=
Received: by 10.216.87.147 with SMTP id y19mr3896987wee.12.1256328586094; Fri, 
	23 Oct 2009 13:09:46 -0700 (PDT)
In-Reply-To: <7v1vktc1uk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131124>

Heya,

On Fri, Oct 23, 2009 at 15:05, Junio C Hamano <gitster@pobox.com> wrote:
> "make clean" should remove it, because it is a normal build product,
> if you make your "make all" build completion scripts.

Hmm, I guess that's fair enough, if you 'make clean' you want all
build products to be removed; this problem would be solved by
installing the completion script in the share dir, that way it doens't
matter if 'make clean' removes the one in ~/code/git, as long as the
one in ~/share/git-completion remains.

-- 
Cheers,

Sverre Rabbelier
