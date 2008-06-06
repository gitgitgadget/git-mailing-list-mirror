From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-rev: Fix segmentation fault when using --all
Date: Thu, 05 Jun 2008 21:06:32 -0700
Message-ID: <7v4p87xl4n.fsf@gitster.siamese.dyndns.org>
References: <20080605233155.GA21698@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 06:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4TEp-0006nT-W5
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 06:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbYFFEGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 00:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbYFFEGq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 00:06:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYFFEGp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 00:06:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8EA612E2F;
	Fri,  6 Jun 2008 00:06:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 074D02E2E; Fri,  6 Jun 2008 00:06:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F8997D38-337D-11DD-9617-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84018>

Thanks.  Although I am unsure what "name-rev --all" is good for ;-), the
fix looks good.
