From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v4 0/7] git send-email suppress-cc=self fixes
Date: Mon, 10 Jun 2013 08:29:31 +0100
Message-ID: <20130610072931.GH22905@serenity.lan>
References: <1370455737-29986-1-git-send-email-mst@redhat.com>
 <7v8v2o1ho7.fsf@alter.siamese.dyndns.org>
 <20130605201423.GB31143@redhat.com>
 <7vy5ain9yg.fsf@alter.siamese.dyndns.org>
 <20130610065324.GA26501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlwXu-0002if-Vh
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab3FJH3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 03:29:39 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52053 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab3FJH3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:29:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 77ADB606501;
	Mon, 10 Jun 2013 08:29:38 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gl9JC7ZsWnKY; Mon, 10 Jun 2013 08:29:38 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C51BD6064F3;
	Mon, 10 Jun 2013 08:29:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130610065324.GA26501@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227248>

On Mon, Jun 10, 2013 at 09:53:24AM +0300, Michael S. Tsirkin wrote:
> I vaguely remember there was some way to say
> "head of the remote I am tracking" - but I could not find it.
> Where are all the tricks like foo^{} documented?

gitrevisions(7) is what you're looking for here.

In this case I think you want '@{upstream}' or its short form '@{u}'.

> I tried fgrep '{}' Documentation/*txt and it only returned
> git-show-ref.txt which isn't really informative ...

'{' and '}' need to be escaped in AsciiDoc so you have to grep for
'\\{\\}'.
