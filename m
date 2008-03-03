From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: Initialize PATH to include exec-dir.
Date: Sun, 02 Mar 2008 20:58:02 -0800
Message-ID: <7vtzjojtet.fsf@gitster.siamese.dyndns.org>
References: <20080303040843.GA27185@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: srp@srparish.net, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 05:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW2lQ-0002MB-Jp
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 05:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbYCCE6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 23:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbYCCE6P
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 23:58:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbYCCE6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 23:58:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CCFC9198C;
	Sun,  2 Mar 2008 23:58:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3A47C198A; Sun,  2 Mar 2008 23:58:06 -0500 (EST)
In-Reply-To: <20080303040843.GA27185@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Mon, 3 Mar 2008 05:08:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75882>

I think this is a sensible companion patch to the earlier 04b3305
(upload-pack: Initialize the exec-path.).  We should have done this back
then.

Thanks.
