From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git submodule update --merge
Date: Mon, 25 May 2009 15:04:19 -0400
Message-ID: <32541b130905251204q20b5600fr4486390cc9157f66@mail.gmail.com>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302> 
	<200905191526.40471.johan@herland.net> <200905251359.37619.johan@herland.net> 
	<7vmy91vxqc.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905252053070.4288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 25 21:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fTg-0007JN-13
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbZEYTEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 15:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZEYTEi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:04:38 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:44587 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbZEYTEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 15:04:38 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1947932ywb.1
        for <git@vger.kernel.org>; Mon, 25 May 2009 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oH5Y3TIuQI567hQXt7d74nA8WyKZECErA2I2kISNdNM=;
        b=o6fLs4/FWAB9N9UqYJrheN8UVYiVp8Jg2PVoasx8+6ZwyZpK+SatuQiGQ8IrYj2Ij2
         J9CZ3wqgfZ6iI2Cox6oNlKTTDS+yumyEORt/lAaihNwO0F61ZMfNpfS5Cc41ZuZDzdjl
         etpnR/nK45VvRUDUFSCZfmXX7LjPz/2umnL+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Cxg4v7jWlZpGGidQFdS8rp5s19Lwoz2mgavwo+7DhSmtL6rq7K9sA1TpgKU51Tx/IJ
         4+yj8DgoSbEjVmNMKBfHE2ifacGdKj+r9pxVhHWvdSEtR49JM7qdCr07fYLnyZ9OfFND
         s++Jm9lofA1GsdFSwYHYjuLUxLrLVp27f2kK4=
Received: by 10.151.134.2 with SMTP id l2mr14895494ybn.105.1243278279078; Mon, 
	25 May 2009 12:04:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905252053070.4288@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119951>

On Mon, May 25, 2009 at 2:57 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Because in the project I use submodules most heavily, there is one
> recurring theme: you cannot push to the submodules. =A0And by "you" I=
 mean
> "a regular user".
>
> So virtually all you do in these submodules cannot be pushed at all. =
=A0It
> has to be submitted to the respective submodule maintainer.
>
> And guess what happens in such a case when you set that tentative "up=
date"
> variable to "merge"?
>
> Exactly.
>
> FWIW I consider any scenario where the average users have push access=
 to
> the submodule a toy scenario.

I have the same problem.  Out of curiosity, how do you handle the case
where you really need to make a change to the submodule and let your
team members see that change, even though the submodule's upstream is
slow and/or doesn't accept the patch?

In that situation, we've had to make local shared mirrors of all the
submodules and point .gitmodules at that.  But that would be your
"toy" scenario - our local users have push access to the submodule.

Thanks,

Avery
