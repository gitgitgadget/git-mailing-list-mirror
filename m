From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 1/2] http.c: fix compiling with libcurl 7.9.2
Date: Mon, 15 Jun 2009 20:55:08 +0800
Message-ID: <be6fef0d0906150555l11df6dcbs16087554b08cc596@mail.gmail.com>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
	 <7v63eyp10m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Mike Ralphson <mike@abacus.co.uk>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 14:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGBiY-0002zV-7x
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 14:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757740AbZFOMzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 08:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754266AbZFOMzH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 08:55:07 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:39465 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbZFOMzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 08:55:06 -0400
Received: by pxi27 with SMTP id 27so212880pxi.33
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=67TEnD5qMbBXhLgsZjWn4lTg/ouG6qksFm5JdbS94HY=;
        b=LUVnmsuoPe/cSGFYSqw7dO2gDYxwMS5ftneUk120x3k48slRovFNJiSQZQfICJgv+P
         VkRiQ8lUd0sE7CITGvHD1t/kGnNxoa1K0N9DLaKXPsz6AbY76KfZSfEx9hg8SJFazr+J
         1NHk0yQ02lLq0Pq4uJkhy3O28GTgxZdZSQa1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pyqSeZxQM8ILv5qDREDbGAnEwypvtgYXPQOuHE96UgRHiwNIqSHaZS9qLll2xcoswk
         c+B6s51d3YlNe78BOPN2SRdcu5qt7CTekFKIH5fCB/9Mt9te/GmFEEuNoLCL0VWxCBDt
         sGkNOuPaP7jaIirrt4Kvayg3xNS+oK1sZhfTs=
Received: by 10.143.33.21 with SMTP id l21mr2992607wfj.252.1245070508935; Mon, 
	15 Jun 2009 05:55:08 -0700 (PDT)
In-Reply-To: <7v63eyp10m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121604>

Hi,

On Mon, Jun 15, 2009 at 12:35 PM, Junio C Hamano<gitster@pobox.com> wrote:
> In other words, this needs to be queued on top of rc/http-push series, and
> the review process should involve the original author (Cc'ed).
>
> Tay, comments?

Thanks for the heads-up. I don't have anything to add, since Mark's
work doesn't really affect mine (http fetching logic).

-- 
Cheers,
Ray Chuan
