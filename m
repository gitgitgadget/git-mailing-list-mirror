From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Provide git_config with a callback-data parameter
Date: Wed, 14 May 2008 18:52:55 -0700
Message-ID: <7vy76cib9k.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805141844580.30431@racer>
 <alpine.DEB.1.00.0805141846370.30431@racer>
 <7vk5hwn0tp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805150156230.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 03:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwSfT-0004c8-Vi
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 03:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbYEOBxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 21:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYEOBxG
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 21:53:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYEOBxE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 21:53:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2065351A9;
	Wed, 14 May 2008 21:53:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 83E0A51A6; Wed, 14 May 2008 21:53:00 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805150156230.30431@racer> (Johannes
 Schindelin's message of "Thu, 15 May 2008 02:02:45 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A78BCA08-2221-11DD-95C1-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82167>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Great, as this has also been a pet-peeve of mine for quite some time.
>> 
>> Except the patch has quite a many rejects X-<.
>
> Did you try to apply it to "next"?

The rejects are Ok.  As long as function signature change of git_config()
is there, any misconversion will be caught by the compiler so I can manage
with relatively high confidence.

I need manual inspection on the other patch, as s/path.list/string.list/
could oversubstitute without breaking compilation.
