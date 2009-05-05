From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: Re: [PATCH v2 2/4] Add format.coverauto boolean
Date: Tue, 5 May 2009 17:23:38 +0200
Message-ID: <20090505152338.GD26208@fsst.voodoo.lan>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org> <1241431142-8444-3-git-send-email-ft@bewatermyfriend.org> <7v8wlc4fqo.fsf@alter.siamese.dyndns.org> <20090505084916.GB26208@fsst.voodoo.lan> <7vvdof25oe.fsf@alter.siamese.dyndns.org> <20090505132923.GC26208@fsst.voodoo.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 17:24:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1MVR-00030I-Jc
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 17:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbZEEPYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 11:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbZEEPX7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 11:23:59 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:34855 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZEEPX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 11:23:58 -0400
Received: from [212.117.84.18] (helo=fsst.voodoo.lan)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M1MUs-0007zH-5K; Tue, 05 May 2009 17:23:54 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M1MUc-0004V4-OW; Tue, 05 May 2009 17:23:38 +0200
Content-Disposition: inline
In-Reply-To: <20090505132923.GC26208@fsst.voodoo.lan>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118302>

Frank Terbeck <ft@bewatermyfriend.org>:
[...]
> }  % git config --global alias.fp format-patch --cover-letter

That may still break backwards compatibility.
To be safe, we could make --cover-letter behave as it always did, and
only make it look at format.coverletter if --cover-letter=auto was
specified.

Regards, Frank
