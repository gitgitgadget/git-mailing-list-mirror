From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig PATCH 0/1] Make height of split view configurable
Date: Wed, 25 Feb 2009 23:17:25 +0100
Message-ID: <2c6b72b30902251417s2f166910w4a47a2d1a43aef93@mail.gmail.com>
References: <cover.1235338009.git.tilo@tilo-schwarz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: tilo@tilo-schwarz.de
X-From: git-owner@vger.kernel.org Wed Feb 25 23:19:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcS5i-0006nW-OW
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 23:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762962AbZBYWRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 17:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762953AbZBYWRa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 17:17:30 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:63075 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762881AbZBYWR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 17:17:29 -0500
Received: by fxm24 with SMTP id 24so219812fxm.37
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 14:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Yfkss43K4ek+OLmPKAIyjNKoMHNnMgZ9Ji2yPkXFxH8=;
        b=j66t3b0n2cxCatviT+h4iFbBcjOrTh8wCHXsFzql/WsKP6rshfbbHeDO4mAYQVTPc8
         DvZyrf8XxsjyeJe0ORqBS/T4CVhmDevV+KW7SyDpDRR4vZcVVks/Q/2TSTu041ORgsPH
         zluCobPI4OUe+AAOSMqWwn6P9DUUnFbMJJ8kU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sNT5q/SpwAhyFdSRPpaC05fWprnlkCtHQOuYKUT9YVV8BrS71nznLc7OAnATWb5YU7
         ZmU+TusG/brLSLL3jbOw6uctVAVePjXMeufBeYzyTI3Fal1QB6AzX9uhlgvJepx9Y+4v
         +Itx4KAGnkYb2ML1hY9ftg3Y8gQBHy5qfe8xk=
Received: by 10.181.197.6 with SMTP id z6mr182921bkp.213.1235600246064; Wed, 
	25 Feb 2009 14:17:26 -0800 (PST)
In-Reply-To: <cover.1235338009.git.tilo@tilo-schwarz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111505>

On Mon, Feb 23, 2009 at 23:24,  <tilo@tilo-schwarz.de> wrote:
> Rationale: On a large display with many rows it would be nice to be
> able to configure the heights of the views in the split view. For
> example, I like to have the lower diff view be 90% of the total
> view height.
>
> As it is, the patch lets the height of the lower view be configurable.
> Is it may be better to configure the height of the upper view?

I don't know, the way you have done it seems reasonable.

> Any input on variable nameing, code style etc. of course welcome.

Very, very clean and nicely done with the reusing of the parse/apply
step code. Thanks.

-- 
Jonas Fonseca
