From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug in make install
Date: Wed, 02 Apr 2008 21:57:53 -0700
Message-ID: <7vd4p75ycu.fsf@gitster.siamese.dyndns.org>
References: <JYPQSO$FF146173479D39756CA6CA952130001D@poste.it>
 <alpine.LSU.1.00.0804022116080.4008@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Maggi <marco.maggi-ipsu@poste.it>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 06:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhHXH-0007xt-4J
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 06:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYDCE6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 00:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYDCE6G
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 00:58:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbYDCE6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 00:58:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 23EC624E1;
	Thu,  3 Apr 2008 00:58:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2E21E24E0; Thu,  3 Apr 2008 00:57:55 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0804022116080.4008@racer.site> (Johannes
 Schindelin's message of "Wed, 2 Apr 2008 21:16:43 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78725>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 2 Apr 2008, Marco Maggi wrote:
>
>> Do not bother me asking why I put "." in CDPATH.
>
> We will probably not bother.  But we mention that exporting CDPATH makes 
> absolutely zero sense.

Often people who make this mistake do not know the difference between
setting it as a shell variable and exporting it to the environment, so a
comment to hint that there is a difference may be a helpful and friendly
thing to do.
