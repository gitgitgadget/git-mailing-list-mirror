From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 0/6] gitweb: feed metadata enhancements
Date: Wed, 28 Jan 2009 22:57:33 +0100
Message-ID: <cb7bb73a0901281357w52aa275i1a734b171396dd58@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vskn3m9l1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:59:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSIR9-0004tm-0Y
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 22:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbZA1V5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbZA1V5f
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 16:57:35 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:38671 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZA1V5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 16:57:35 -0500
Received: by ewy14 with SMTP id 14so3605100ewy.13
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 13:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=59nYY/F1rFy/cQeE9f9lBhpK4bRSpDHBjA5yK6rGypU=;
        b=rlyg0R1bKxWm/KzLG5jyzahDMyPlz1gz2DU/ZWEWW3eFSnzLbvFxNC2Yrdmy+8CHH5
         b4OhmyP4owKI96akUql77qycP9bkNH87lDwX06GljYkrBlrCV5aC9zBSD4r+J3n7Z4k6
         gdcrltR8P+M8tmUnidyDn15CZNYEv3NJ0iiqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m9fOcCirBQ9pkQ4rB3CszyTIilPEcRumnS2FVwhuNCKXWcQFC4qbXs6g2y+W2vQeny
         jULhy1+pN+nm+b/sXl8xpBtNhamDX2oPcX4fTxt/EaGYfNgng7iuf5o75juvA+zEzEeE
         Z8GfWx9rB3Pf+fj7NshPH6AsBM2ATT9W/arK0=
Received: by 10.66.219.15 with SMTP id r15mr818098ugg.16.1233179853670; Wed, 
	28 Jan 2009 13:57:33 -0800 (PST)
In-Reply-To: <7vskn3m9l1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107584>

On Wed, Jan 28, 2009 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This is independent from your other topic on PATH_INFO, right?  I am aware
> that other one is being polished between you and Jakub, but is anobody
> doing anything on this one, or is it already polished enough?

Yes it's a totally independent topic. For what it's worth, this series
is running on ruby-rbot.org gitweb and it fixed a bunch of rss polling
related issues we were having with the bot we use to watch it.


-- 
Giuseppe "Oblomov" Bilotta
