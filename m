From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 02:09:35 -0500
Message-ID: <76718490903022309q43862d34ma99ba191cef3742c@mail.gmail.com>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
	 <1235865822-14625-2-git-send-email-gitster@pobox.com>
	 <1235865822-14625-3-git-send-email-gitster@pobox.com>
	 <20090301031609.GA30384@coredump.intra.peff.net>
	 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
	 <20090301100039.GD4146@coredump.intra.peff.net>
	 <20090301170436.GA14365@spearce.org>
	 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOmd-00064F-N4
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbZCCHJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 02:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbZCCHJi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:09:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:16788 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbZCCHJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 02:09:37 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2667227rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 23:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/VxbiqOJnaZdD5b89ZhhS+Jy8Qx94+SW4b2cuEhMfzo=;
        b=BM0c5u2OdIJAg0Dzo8wDUK5nWhO4T9K1wYl0fQEPVqhYRnFYCnr8nJDIaoROKGbx4b
         1+Ok5crDnwP9blKuVB58xcW4VY2lgC5JQRy8RfjzMLlDpOInNVrPFXFB9A3yQpbJqtR9
         8wLU84jYfM7N8YPcPvnSU+6Gk4ofIF/W2I+VI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oqc8SOj55X7VRtHe6eGnThqzzncvqIHwOG+9OVu93Pe71Ydq4sZCG4MOkMAvy4dJdw
         sTiNXC3Q/FCbqXa6NckllA7agsp8+Bx0N9kspIQBOnEYWeE9wq3ZNmo4PBehPQG6996f
         KvcJE2fo2nV7yRuMmxeFIT8U7lUp5+L4gU+xQ=
Received: by 10.140.141.16 with SMTP id o16mr3356029rvd.138.1236064175540; 
	Mon, 02 Mar 2009 23:09:35 -0800 (PST)
In-Reply-To: <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112008>

On Tue, Mar 3, 2009 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> + =C2=A0 =C2=A0 =C2=A0 if (mkdir(dir, 0777)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("cannot mkdi=
r '%s': %s", dir, strerror(errno));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> + =C2=A0 =C2=A0 =C2=A0 }

How about "cannot create repository; mkdir failed '%s': %s" ...

j.
