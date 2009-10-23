From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: ks/precompute-completion
Date: Fri, 23 Oct 2009 15:22:54 -0500
Message-ID: <fabb9a1e0910231322y1355ca8ck209bcd64bd29dec6@mail.gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE0DAB3.1030103@gmail.com> 
	<fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com> 
	<fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com> 
	<4AE0E542.8010501@gmail.com> <fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com> 
	<7vd44eaqc5.fsf@alter.siamese.dyndns.org> <fabb9a1e0910231216j2a024ac5mf5b5ccb5322722f8@mail.gmail.com> 
	<7v1vktc1uk.fsf@alter.siamese.dyndns.org> <m3d44deu93.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 22:25:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1QhC-00036Z-Pc
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 22:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbZJWUXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 16:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbZJWUXL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 16:23:11 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:58661 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZJWUXL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 16:23:11 -0400
Received: by ewy4 with SMTP id 4so1994937ewy.37
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=oKZCB86c4py1F7DfVAXFoVNa6Ghf9tO5Yya3HM698q0=;
        b=Hqxyh/W4kJIMJOULAmAUkQ/83yP6FsHwtUXNynzJnS33RCYI8Jug5ALJLQS7UQw2V9
         TY53TXNuK9RCitvPcb8np2QAAI6g39Gv4zb6tSnVIRwfI+F2aMNbLXLTto0SXkGoHwL0
         WAI4HJmga+kHBaGYq+6vXyhw0/o7Zp9KbKRFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OciOgUvjRlsKV6cPp2hNyd7eAcX6jzeT38WbnkfkXMLFKNmATQ7z3/poFJbKOAPFOX
         ZwHbUebN7WhZpOEe7NWVw2U7Cpf9NX8GShB00ULczDiL18y0O1D7H8lzG361cwbz/jlg
         m+m4u5Q+EAu7NmyMNfdYEe3Ru8cZ/82w6/7Lo=
Received: by 10.216.87.79 with SMTP id x57mr3938675wee.83.1256329394088; Fri, 
	23 Oct 2009 13:23:14 -0700 (PDT)
In-Reply-To: <m3d44deu93.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131128>

Heya,

On Fri, Oct 23, 2009 at 15:20, Jakub Narebski <jnareb@gmail.com> wrote:
> (and not make this target part of "make all")

But that I can already do through 'make contrib/completion/Makefile',
what I want is to not have to worry about doing that whenever I update
my git install (that is, the same way as it was before it became
pre-computed).

-- 
Cheers,

Sverre Rabbelier
