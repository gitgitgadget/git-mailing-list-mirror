From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] instaweb: if no httpd is specified and lighttpd doesn't
 exist, fall back on apache2.
Date: Sun, 11 May 2008 10:46:17 -0700
Message-ID: <7vlk2g4tue.fsf@gitster.siamese.dyndns.org>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com>
 <ee77f5c20805110458s6f1e4908k38be50753ba38d09@mail.gmail.com>
 <5C50F5DC-CAE4-4BF2-BCAA-8CFC8CC43C59@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Symonds" <dsymonds@gmail.com>, git@vger.kernel.org
To: nathan spindel <nathans@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 19:47:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvFdx-0002Ti-NR
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757622AbYEKRqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbYEKRqd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:46:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572AbYEKRqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:46:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 20C43100F;
	Sun, 11 May 2008 13:46:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5DC02100D; Sun, 11 May 2008 13:46:24 -0400 (EDT)
In-Reply-To: <5C50F5DC-CAE4-4BF2-BCAA-8CFC8CC43C59@gmail.com> (nathan
 spindel's message of "Sun, 11 May 2008 10:03:34 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F53D8C4-1F82-11DD-B743-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81803>

nathan spindel <nathans@gmail.com> writes:

> I am apathetic about which web servers are preferred, I would just
> like to see git-instaweb work well on Mac OS X.  Kevin Ballard's
> suggestion was to fall back on apache2.
>
> We could also modify the default to use [lighttpd, webrick, apache2]
> in that order (whichever is available). Would the community prefer
> that approach?

I think apache is the most well known and widely used among the three, and
find Kevin's suggestion sensible.
