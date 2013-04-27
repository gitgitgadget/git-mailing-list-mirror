From: John Keeping <john@keeping.me.uk>
Subject: Re: [ANNOUNCE] Git v1.8.3-rc0
Date: Sat, 27 Apr 2013 10:18:33 +0100
Message-ID: <20130427091833.GB472@serenity.lan>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 11:18:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW1HJ-0001N4-KT
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 11:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab3D0JSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 05:18:41 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:55435 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab3D0JSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 05:18:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 80E4522F5A;
	Sat, 27 Apr 2013 10:18:39 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scM-j3BapF8U; Sat, 27 Apr 2013 10:18:39 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 4B17C22F7A;
	Sat, 27 Apr 2013 10:18:35 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222624>

On Fri, Apr 26, 2013 at 05:22:22PM -0700, Junio C Hamano wrote:
>  * "git difftool" allows the user to write into the temporary files
>    being shown; if the user makes changes to the working tree at the
>    same time, one of the changes has to be lost in such a case, but it
>    tells the user what happened and refrains from overwriting the copy
>    in the working tree.

This feels slightly misleading to me, perhaps something like this would
be clearer?

   "git difftool" allows the user to write into the temporary files
   being shown; if the user makes changes to the working tree at the
   same time, it now refrains from overwriting the copy in the working
   tree and leaves the temporary file so that changes can be merged
   manually.
