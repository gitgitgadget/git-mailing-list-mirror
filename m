From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Thu, 5 Nov 2009 21:38:41 +0100
Message-ID: <16cee31f0911051238v71ec4b57s415efb7bb48999d1@mail.gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
	 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
	 <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
	 <4AF20534.2030004@gmail.com>
	 <alpine.LFD.2.00.0911042111270.10340@xanadu.home>
	 <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
	 <alpine.LFD.2.00.0911051422590.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:39:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N696g-0006uf-4x
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834AbZKEUih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 15:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757236AbZKEUih
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:38:37 -0500
Received: from gv-out-0910.google.com ([216.239.58.190]:65335 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758827AbZKEUig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 15:38:36 -0500
Received: by gv-out-0910.google.com with SMTP id r4so130132gve.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AWooFOps4o9oMATZtbpPeF98KuPxVcQ9hdgy7vbIv+8=;
        b=iS+LssOflEKa+CjTvsNkcUReNMzsWdVC9D1C55358DobFTr/HEuKIrjLEklS1Xkwn3
         EIM8+zgcbF2rTGNG0vhMwY1HS9cafddqqCE4h9sBp8y0x3eVd6pH16z8K9IqQP7zw8k/
         ++Jei20ijpbNx3gkuInkDJMgmgrXxLUKr+KF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v9muwUzUCkJOQ7ggsudhie93BVOlckAizEHKOXrwOXZNmXeChTsfpqMO0636GPglT0
         8+0RXzEmBcbAVn5BnU80YcYCGUaKoBF3DNLvg8564X5fEYXsETw/n52zmUglcQobHks0
         nnyLGGZ8BvJcdwH9E3X+t/ssDDLFrhJKPvQNw=
Received: by 10.239.170.36 with SMTP id q36mr319196hbe.153.1257453521175; Thu, 
	05 Nov 2009 12:38:41 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911051422590.10340@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132247>

2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> Why not? =A0At least gcc is quite happy with such a construct. =A0It
> probably makes a copy of the stack before passing it though.

Err... my mind is rotted with all that ugly java, c#, python and ruby,
even c++. I should start taking some medications I suppose... what was
I thinking is that C can't copy-construct a struct. Damn, too much sun
(of java fame)...

That way I rediscovered simple struct construct...man I missed C so muc=
h :)

Anyway, the solution with passing pthread_t as pointer saves some
stack, so it's probably not that bad.

--
Andrzej
