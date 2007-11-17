From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t9101 test failure caused by Subversion "auto-props"
Date: Fri, 16 Nov 2007 16:19:19 -0800
Message-ID: <7vy7cxwwoo.fsf@gitster.siamese.dyndns.org>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com>
	<BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com>
	<041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com>
	<1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr>
	<73246E38-9C22-4279-A53E-678434238E5C@wincent.com>
	<20071116124850.GA14473@atjola.homenet>
	<2F7DFDC9-D4E2-42D0-9E48-E51E7905FF42@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?VsOkaW7DtiBKw6RydmVsw6Q=?= <v@pp.inet.fi>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 01:19:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItBPV-0003vJ-F8
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 01:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761740AbXKQAT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 19:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760772AbXKQAT3
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 19:19:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43309 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760616AbXKQAT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 19:19:28 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 51E222F0;
	Fri, 16 Nov 2007 19:19:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 46B3D95967;
	Fri, 16 Nov 2007 19:19:43 -0500 (EST)
In-Reply-To: <2F7DFDC9-D4E2-42D0-9E48-E51E7905FF42@wincent.com> (Wincent
	Colaiuta's message of "Fri, 16 Nov 2007 14:25:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65256>

Wincent Colaiuta <win@wincent.com> writes:

> If a user has an "auto-prop" in his/her ~/.subversion/config file for
> automatically setting the svn:keyword Id property on all ".c" files
> (a reasonably common configuration in the Subversion world) then one
> of the "svn propset" operations in the very first test would become a
> no-op, which in turn would make the next commit a no-op.

Thanks for diagnosing and fixing.

I presume this fix also applies to both 'maint' and 'master',
right?
