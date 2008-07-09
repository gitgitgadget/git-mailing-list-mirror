From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Wed, 09 Jul 2008 11:28:43 -0700
Message-ID: <7vzloqkj38.fsf@gitster.siamese.dyndns.org>
References: <1215555496-21335-2-git-send-email-robertshearman@gmail.com>
 <7vbq18q7yk.fsf@gitster.siamese.dyndns.org>
 <1096648c0807090502x772fdaa4o59bf9932dc364de5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rob Shearman" <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 20:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGeQM-0008G9-UQ
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 20:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYGIS2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 14:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbYGIS2z
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 14:28:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbYGIS2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 14:28:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A70F2A354;
	Wed,  9 Jul 2008 14:28:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A7C3D2A351; Wed,  9 Jul 2008 14:28:50 -0400 (EDT)
In-Reply-To: <1096648c0807090502x772fdaa4o59bf9932dc364de5@mail.gmail.com>
 (Rob Shearman's message of "Wed, 9 Jul 2008 13:02:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E21AC342-4DE4-11DD-94AD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87904>

"Rob Shearman" <robertshearman@gmail.com> writes:

> 2008/7/9 Junio C Hamano <gitster@pobox.com>:
> ...
>> Don't we also want to keep a vanilla configuration in the example, or is
>> imaps the norm and unencrypted imap is exception these days?
>
> Good point. I'll fix the documentation to use imap:// instead of
> imaps:// and not change the port number. However, I'm not sure the
> examples should be telling the user what they should do, but rather
> what they can do.

My comment was purely about losing the basic example by replacing it with
something more advanced.  Nobody prevents you from having _more_ examples.
"You can do this, you can do that, also here is an example of how to use
SSL".
