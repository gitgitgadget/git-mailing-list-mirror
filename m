From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 20:26:59 +0100
Message-ID: <fabb9a1e1002161126m2db5fe4i1572a9959665977f@mail.gmail.com>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> 
	<7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org> 
	<20100216180209.GA1532@book.hvoigt.net> <7vocjpng1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 20:27:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhT4x-0002Tn-IV
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026Ab0BPT1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:27:21 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:33572 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871Ab0BPT1U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:27:20 -0500
Received: by pzk17 with SMTP id 17so5382655pzk.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=0g+aRypuiro9erLBdu0P+tcb/wJFzjwQvgtgw5H4KSs=;
        b=c2tOlIYwkfj925Pj3WprCN+rdJJ7u1yggeoFglooSdMPOJYGe/VgvdJAICBpXNus/D
         ekyMBvtp3Yu4JGMID7d4aFnk2FHvlx9LVxKa+T3RazIoTdXHXSA6TewcY4ebTF+RVY4d
         oiFM+iX7AQBLaH+6QKGUyLf2k+VK3gpAr/vEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GoFuspwZthkvBUL02esELgrn6b8ywmLO96gNeMEvTv8ErRFodt01rcNfUbiaJfWcW+
         qUVVyKd1uKUj++M2QFCcATf/vyD6cS1cXWhZ4P7FVF9dH5RWDnXv71UFhWFCNRm1ZkQ5
         VZKI7qdEV0ND60AGJRr+nDvnmFXLoZVHW6A4o=
Received: by 10.142.66.40 with SMTP id o40mr4592235wfa.262.1266348439218; Tue, 
	16 Feb 2010 11:27:19 -0800 (PST)
In-Reply-To: <7vocjpng1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140136>

Heya,

On Tue, Feb 16, 2010 at 20:20, Junio C Hamano <gitster@pobox.com> wrote:
> Don't they teach this in schools anymore?

Have they ever? And no, they don't. At least in the Netherlands (and I
suspect it to be the same in other European countries, and perhaps
even in the US) don't spend a whole lot of time teaching C. At my uni
they start out with Java, and stick with that most of the time. There
are only brief (and often optional) ventures into other languages.

-- 
Cheers,

Sverre Rabbelier
