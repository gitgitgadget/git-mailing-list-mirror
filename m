From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/6] Teach --id/-d to "git status"
Date: Wed, 5 Aug 2009 20:11:59 +0200
Message-ID: <81b0412b0908051111g4433e12epa540e0a2f07b62b@mail.gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
	 <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYky9-00073g-Ih
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbZHESMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbZHESMA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:12:00 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:41013 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZHESL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:11:59 -0400
Received: by ewy10 with SMTP id 10so192529ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U1jJpS3s/1v9soA5W5621QiThQMTb6uhtPQIgw0KpI0=;
        b=M58Gucdc0ibkQjHYYPq1igdlhoskfQP8Tgvm3+X5lH7yrS83HAqLDhlg1apegvD6os
         s1GxMawWCR/FhHUjAcz/RVExquQmL7w5Mewpwyez0E6/1s4nRXqC8XvmVy3ZC4zYk57S
         KvINXvELOiNdBz3/vmJbVVO0gG60x9epAh8i4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q6hawW0JRK8c8LliwnW/FVixE6yF7Te/a8gW8RvruOsfU/LmOpRL8oQY4Jc6cnBU7S
         clb7HUn0QP2frTPe6P9fhRihT7NxYUe05RM6G/DDcaz1gges1tqO9vefpJDy0Bmkw3PV
         N625TL0TdhY4wQDdU8Vq9kDn1WNglZSAJRu9o=
Received: by 10.210.142.10 with SMTP id p10mr8649804ebd.43.1249495919256; Wed, 
	05 Aug 2009 11:11:59 -0700 (PDT)
In-Reply-To: <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124937>

On Wed, Aug 5, 2009 at 11:51, Nazri Ramliy<ayiehere@gmail.com> wrote:
> This patch adds a unique identifier for each file shown by "git status".
>
> Subsequent operation (add/rm/checkout/commit/reset) may use these ids
> to simplify specifying the files, provided that they are taught about
> the --id option as well.

What is it for?
