From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] instaweb: added support Ruby's WEBrick server
Date: Wed, 19 Sep 2007 10:41:43 +1000
Message-ID: <ee77f5c20709181741jbb2d727t59f561eeaaa075d@mail.gmail.com>
References: <20070918121634.E8EFF814635@cyrano>
	 <7vodfztviv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "mike dalessio" <mike@csa.net>, git@vger.kernel.org,
	normalperson@yhbt.net
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXndZ-0001mG-8J
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXISAlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbXISAlp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:41:45 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:4466 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbXISAlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:41:45 -0400
Received: by rv-out-0910.google.com with SMTP id k20so35782rvb
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 17:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UgoqUTv1EFzicPhnP3N8VzmkAvK+l/awLK3OrcFOVhg=;
        b=e3M0F2eQlcM+8bmz1Cx6qQ7MSZlEd+BRoIZoxubEiFtuWd/SDZlPW+EsIAlaLZ37BtFKU8rINf0w2BYMe2tDthujlkTBzjU5r0t6ii3exClHqhc0EfIn3iEnC1HHCWupDQJcz7Bf4YOo230NwHMi9Zs7SAPkB4gBsqYuLQEzOUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qpe94NKh9EwLbi1PNomgWbzUCo7LkHzjD/kLxamwjMtHc4bDRvJwtldZvC4Ehcd+Sdsq6hvWvLoof0NOrMiZtg4mPxlsRN9oPExS31Xmi1p80IuE2EZAnR3xLvEC48yEiYcwzjKy1zkKZVRIPC6xSrMz/rvzysVx+BE3a4IlYqg=
Received: by 10.141.202.12 with SMTP id e12mr23120rvq.1190162503385;
        Tue, 18 Sep 2007 17:41:43 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Tue, 18 Sep 2007 17:41:43 -0700 (PDT)
In-Reply-To: <7vodfztviv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58669>

On 19/09/2007, Junio C Hamano <gitster@pobox.com> wrote:

>  - I do not like extra whitespace between she-bang #! and the
>    path.  Looks very ugly.

At least according to the Autoconf manual, there are some UNIXes that
require a space after the shebang. Not that I've seen such a system.
Personally, I find it easier to read with the space.


Dave.
