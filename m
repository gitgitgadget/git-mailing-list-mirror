From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/6] Teach --id/-d to "git status"
Date: Wed, 5 Aug 2009 11:35:53 -0700
Message-ID: <fabb9a1e0908051135g1f34de4ds64800aac93f2f4ac@mail.gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com> 
	<1249465906-3940-2-git-send-email-ayiehere@gmail.com> <81b0412b0908051111g4433e12epa540e0a2f07b62b@mail.gmail.com> 
	<fabb9a1e0908051125m3eecb065m5fb4ea2b55f69b91@mail.gmail.com> 
	<20090805183313.GB13166@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:36:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlLa-0001hq-7p
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbZHESgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbZHESgO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:36:14 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:41291 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbZHESgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:36:13 -0400
Received: by ewy10 with SMTP id 10so209595ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1maZZNZJGXwI9hwWWBXkxT9ZNEt8Q4xSWqW8Kr2xXzg=;
        b=BDRS09yEVChhRo5yAmB63/FF+xejgM+duWoAMqulKrh+lWmJYOccNgmEYZvi/9b8RD
         BDPZNZUk91aliPcH5CQOGiyhr2owbnkLyxmY1wXp+p3A7m6oAh0vazpqIdXz0dS4aUBI
         I2+P/KSbbit0CyDAZxhpFTw81FyyiXCw8DKKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WZ0UufU/3ZS0ja6t5zBbYovLns0rUmvXOAheE8nUWwrbdWEjHwYiFS+n0TjIiwcdX2
         n1mbbA+HDuHNBykYkCcGnsSWhYx2cwfhpq3GdZLll0zhB9RngxjU82tINwRx5VI78b24
         nKauGqo+M/9iYEmNIo3eZhDhsAUhSKKB/OeE0=
Received: by 10.216.20.67 with SMTP id o45mr1924411weo.106.1249497373452; Wed, 
	05 Aug 2009 11:36:13 -0700 (PDT)
In-Reply-To: <20090805183313.GB13166@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124949>

Heya,

On Wed, Aug 5, 2009 at 11:33, Alex Riesen<raa.lkml@gmail.com> wrote:
> Complicated solution to a non-existing problem.

That's harsh; obviously it is an existing problem for Nazri, or they
wouldn't have spent the time writing these patches. So at worst it's a
complicated solution for an _already solved_ problem (tig, git add -i,
etc), but definitely not non-existing ;).

-- 
Cheers,

Sverre Rabbelier
