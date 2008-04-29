From: Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch --cc and send-mail --s-o-b-cc don't play nice
 together
Date: Tue, 29 Apr 2008 14:39:02 -0700
Message-ID: <7v8wyw7349.fsf@gitster.siamese.dyndns.org>
References: <36ca99e90804290657k88710eer630898d837659f37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ryan Anderson" <ryan@michonline.com>
To: "Bert Wesarg" <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:40:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxYY-0002wh-In
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbYD2VjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYD2VjT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:39:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbYD2VjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:39:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B9562615;
	Tue, 29 Apr 2008 17:39:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 970B92611; Tue, 29 Apr 2008 17:39:11 -0400 (EDT)
In-Reply-To: <36ca99e90804290657k88710eer630898d837659f37@mail.gmail.com>
 (Bert Wesarg's message of "Tue, 29 Apr 2008 15:57:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B80D54E4-1634-11DD-A0F4-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80744>

"Bert Wesarg" <bert.wesarg@googlemail.com> writes:

> the --cc option from format-patch adds a Cc: header to the mail where
> multiple recipients are put into a new line, separated by commas.

I am not sure if --cc ever made sense to be given to format-patch.  It is
not a tool to send e-mails, which send-email is.

> Unfortunately send-mail with the --signed-off-by-cc option can't parse
> these lines.

Isn't --signed-off-by-cc a completely unrelated feature, where it gives
carbon copies to people who signed off the patch?  Why does the option
need to read from existing CC: header of the material the command is told
to send out?
