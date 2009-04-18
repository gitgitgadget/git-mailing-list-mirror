From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Fri, 17 Apr 2009 18:24:36 -0700
Message-ID: <7vab6e21pn.fsf@gitster.siamese.dyndns.org>
References: <1239916256-10878-1-git-send-email-mh@glandium.org>
 <7v63h24znd.fsf@gitster.siamese.dyndns.org> <20090417234859.GY898@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Sat Apr 18 03:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuzJw-00012f-OP
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 03:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbZDRBYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 21:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbZDRBYn
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 21:24:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbZDRBYn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 21:24:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BD8AAB314;
	Fri, 17 Apr 2009 21:24:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2DBFBAB312; Fri,
 17 Apr 2009 21:24:37 -0400 (EDT)
In-Reply-To: <20090417234859.GY898@eagain.net> (Tommi Virtanen's message of
 "Fri, 17 Apr 2009 16:48:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B17C942A-2BB7-11DE-AA34-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116808>

Tommi Virtanen <tv@eagain.net> writes:

> On Fri, Apr 17, 2009 at 04:40:54PM -0700, Junio C Hamano wrote:
>> How does this interact with a typical gitosis installation?  I think it
>> extracts bits from the ORIGINAL_COMMAND and formulates a sanitized command
>> line and then passes it to git-shell but I do not think it removes the
>> variable from the environment.
>
> Yup, not sanitizing. I could make that change easily, if you want, but
> there's plenty of installations out there already.
>
> I'd say add a git-shell flag that enables any magic behavior, don't
> just magically work differently based on that environment variable.

Good.  I see Mike too already realized that the patch is unacceptable in
the current form.
