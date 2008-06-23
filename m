From: Junio C Hamano <gitster@pobox.com>
Subject: Re: core.autocrlf and merge conflict output
Date: Sun, 22 Jun 2008 17:45:35 -0700
Message-ID: <7vy74xj7ww.fsf@gitster.siamese.dyndns.org>
References: <g3miho$se5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 02:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAaCe-000149-Dz
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 02:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYFWApo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 20:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbYFWApo
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 20:45:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbYFWApo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 20:45:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 435951F26E;
	Sun, 22 Jun 2008 20:45:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 67A141F26C; Sun, 22 Jun 2008 20:45:38 -0400 (EDT)
In-Reply-To: <g3miho$se5$1@ger.gmane.org> (Edward Z. Yang's message of "Sun,
 22 Jun 2008 18:08:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4859576-40BD-11DD-8BD7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85820>

"Edward Z. Yang" <edwardzyang@thewritingpot.com> writes:

> Apparently, the conflict information Git writes to the working copy
> during merge doesn't respect core.autocrlf,...

Is this an old news before 249c61a (merge-recursive: respect core.autocrlf
when writing out the result, 2008-06-09) happened?
