From: Neil Roberts <bpeeluk@yahoo.co.uk>
Subject: Re: [PATCH] builtin-mailinfo.c: Trim only first pair of square brackets in subject
Date: Tue, 22 Sep 2009 11:39:33 +0100
Message-ID: <87hbuv5km2.fsf@janet.wally>
References: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
	<1246310220-16909-1-git-send-email-rleigh@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 12:41:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq2ny-0008LZ-MQ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 12:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbZIVKjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2009 06:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZIVKjb
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 06:39:31 -0400
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:11013 "EHLO
	smtpout.karoo.kcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbZIVKja convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2009 06:39:30 -0400
X-IronPort-AV: E=Sophos;i="4.44,431,1249254000"; 
   d="scan'208";a="134212479"
Received: from unknown (HELO localhost) ([91.84.60.59])
  by smtpout.karoo.kcom.com with ESMTP; 22 Sep 2009 11:39:33 +0100
In-Reply-To: <1246310220-16909-1-git-send-email-rleigh@debian.org> (Roger
	Leigh's message of "Mon, 29 Jun 2009 22:17:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128930>

Roger Leigh <rleigh@debian.org> writes:

> Use a regular expression to match text after "Re:" or any text in the
> first pair of square brackets such as "[PATCH n/m]".  This replaces
> the complex hairy string munging with a simple single pattern match.

Is this patch going to get applied? We like to use the '[topic]' format
in Clutter=C2=B9 because it looks so much nicer than 'topic:' and it wo=
uld be
really nice not to have to manually fix the commit when a contributor
sends a patch in the same format.

- Neil

[1] http://git.clutter-project.org/cgit.cgi?url=3Dclutter/log/
