From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bring local clone's origin URL in line with that of a
 remote clone
Date: Tue, 02 Sep 2008 00:23:28 -0700
Message-ID: <7vod37m2of.fsf@gitster.siamese.dyndns.org>
References: <200808271400.54302.johan@herland.net>
 <200808310123.48018.johan@herland.net>
 <7vabeuf4oj.fsf@gitster.siamese.dyndns.org>
 <200809012107.34020.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:24:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQFl-00066h-Lz
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYIBHXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbYIBHXf
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:23:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYIBHXf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:23:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 01F29598C7;
	Tue,  2 Sep 2008 03:23:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6CFEE598C4; Tue,  2 Sep 2008 03:23:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D1B9160-78C0-11DD-ABB6-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94656>

Johan Herland <johan@herland.net> writes:

> ... I expect this one issue is also the first that most other
> people would bump into when working locally with relative submodule URLs.

By the way, I find your suggestion to set the canonical URL for the
toplevel repository that relative ones should base on quite reasonable.

The patch looked good.  Thanks.
