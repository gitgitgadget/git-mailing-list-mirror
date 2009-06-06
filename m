From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 12/23] transport.c::get_refs_via_curl(): do not leak 
	refs_url
Date: Sat, 6 Jun 2009 09:04:35 +0800
Message-ID: <be6fef0d0906051804k4d574d39v37dedf46896cb570@mail.gmail.com>
References: <20090606000451.262b7711.rctay89@gmail.com>
	 <m3my8m5ryh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:04:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkKw-0005DP-Nx
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbZFFBEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 21:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbZFFBEe
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:04:34 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:49244 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZFFBEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 21:04:33 -0400
Received: by wf-out-1314.google.com with SMTP id 26so824809wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UYXOe9wnbftCT/BrhfUsyxPxLDxYCNtF2QF5Kq4Rvb4=;
        b=l+45ieGfluszvpK2OqtH8SIUCW+VdNUavUT547ma2ynf23OZ3f/3lWuKQ2jWeA7oIw
         7ie+hbI+PUtSJKBnx2BPa7LVIhTuiKqkrDQaPqYu0jzF1ZXSH4e2xBF1IjbCqwpE8Ks9
         wYwhgKR6h9qzgnrckKs/4oqnK/2MsY7ZegRwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=smfyZkB8np3PMibDXvok/MkCVEfFV4y9eT6/6v8o3V27JScYj8Nv1vZ/YjN1I1bcDq
         U72dxxKXJuOPuShmTtIluKlnUFefM14TvbSwHiQp5bosdJrWeFsddbZgrieHqsjeemdT
         zmcQPMQJYcWETzmDW3jFTP8ETVN7L6vts99mU=
Received: by 10.142.246.20 with SMTP id t20mr1598051wfh.291.1244250275146; 
	Fri, 05 Jun 2009 18:04:35 -0700 (PDT)
In-Reply-To: <m3my8m5ryh.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120855>

Hi,

On Sat, Jun 6, 2009 at 4:46 AM, Jakub Narebski<jnareb@gmail.com> wrote:
>> From: Mike Hommey <mh@glandium.org>
>> Subject: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
>
> So what is the title of this patch? "transport.c::get_refs_via_curl():
> do not leak refs_url" or "Some cleanup in get_refs_via_curl()"?

See my reply to patch #19.

> Perhaps it should be "transport.c: Do not leak refs_url in
> get_refs_via_curl()"...?

I think it's a matter of preference. I'll put them side-by-side to
demonstrate this better:

transport.c: Do not leak refs_url in get_refs_via_curl()
transport.c::get_refs_via_curl(): do not leak refs_url

There isn't any important difference between the two other than form.

-- 
Cheers,
Ray Chuan
