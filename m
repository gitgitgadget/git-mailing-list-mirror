From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] git-svn: use "no warnings 'once'" to disable false-positives
Date: Tue, 16 Oct 2007 20:50:25 +0400
Message-ID: <20071016165025.GT984@void.codelabs.ru>
References: <20071015071912.GG984@void.codelabs.ru> <20071016074318.GA32348@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihpcx-0005OO-0Z
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759700AbXJPQuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759533AbXJPQuc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:50:32 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:58406 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759381AbXJPQub (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:50:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=cTFwFbRlhXoh2GEBIn4Feo07OccsApgw6npQa9YhU+jUbodEI7j56hbIG4hYdfso5XptSF9zvcqIJ4+LNUfSxzFAgC+Nu43PqGvkgLmCvYU5L31fYKMP7ES0KCThQgzkn9Eo592D7aUB1cE4/eQviSGtszg+fbKBKuFk5yYhAV4=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1Ihpcj-000Gmn-W0; Tue, 16 Oct 2007 20:50:30 +0400
Content-Disposition: inline
In-Reply-To: <20071016074318.GA32348@soma>
X-Spam-Status: No, score=-1.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61208>

Eric, good day.

Tue, Oct 16, 2007 at 12:43:18AM -0700, Eric Wong wrote:
> Thanks, minor nit regarding fixed in the patch below.
> 
> 	"{ no warnings 'once';"
> 
> on the same line as the "{"

Yes, I did this intentionally to signify that this block is used
just for the pragma.  But I felt that it is against the style, so
you're right.

Thank you!
-- 
Eygene
