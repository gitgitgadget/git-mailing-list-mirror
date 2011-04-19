From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH] git add: notice removal of tracked paths by default
Date: Tue, 19 Apr 2011 23:47:06 +0200
Message-ID: <BANLkTimKL2bbmOdh35FDZwf2uAzO=nJkFQ@mail.gmail.com>
References: <7v1v0y59tv.fsf@alter.siamese.dyndns.org> <BANLkTin4iVLzga6gFAh+x8nRTKuVTTFPqA@mail.gmail.com>
 <7voc41537g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:47:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCIm0-0004xX-JI
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 23:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab1DSVrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 17:47:47 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63481 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab1DSVrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 17:47:47 -0400
Received: by qwk3 with SMTP id 3so71900qwk.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 14:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IhaHOPE0TbIhmrWj81GKfVIuUY3I4ZPwZDxzAUf84nY=;
        b=Tc9x+PKnkOVno3A/ni3KI/cSJ8ffaRY+0mgOBhoue/Rp1/XNX01RaOlXOLZNS93VMy
         1sj0U4KhS26ow+O7VbngZBGRO4V2Qs9c5KBH+BzplvG3KkAeSPXD0WmsGY4gXEjalEif
         VDLINVp14MsXuEQck/S0NLeMmx0eM8XspqayM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U1sI8rL+MybEOC2F5ct/WhCOeZw3rxFo9bgZ60sAJfQ6dHKiU7nNHiccV9CGS+dVzn
         4VcMLO+W6zKOPvRsyQnS9uBA40wdDPo5AhwO+lvkMK7BG0Sosym1sDnzHCgk9s+A5ZM9
         Jy5ZdIoaoIzreKZHuHuvEVuYPAYBxcT0fMMPg=
Received: by 10.229.77.162 with SMTP id g34mr3919177qck.70.1303249666287; Tue,
 19 Apr 2011 14:47:46 -0700 (PDT)
Received: by 10.229.49.198 with HTTP; Tue, 19 Apr 2011 14:47:06 -0700 (PDT)
In-Reply-To: <7voc41537g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171819>

Heya,

On Tue, Apr 19, 2011 at 23:41, Junio C Hamano <gitster@pobox.com> wrote:
> But as I said, I do not have a strong opinion for this change, other than
> "if we need this optional, then it is not worth doing this".

Your argument makes sense, and I personally haven't run into a case
where I _wouldn't_ want the suggested behavior, and I have run into
cases several times where I _would've_ wanted the suggested behavior.
So consider this a +1 for me on the idea.

-- 
Cheers,

Sverre Rabbelier
