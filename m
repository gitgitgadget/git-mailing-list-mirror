From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/11] gitweb: git_is_head_detached() function
Date: Fri, 14 Nov 2008 09:44:40 -0800
Message-ID: <7vk5b69p87.fsf@gitster.siamese.dyndns.org>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
 <7vk5b6dd3t.fsf@gitster.siamese.dyndns.org>
 <cb7bb73a0811140052h1b7aac6cp6b0b376fa59548a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 18:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L12lG-00081o-2n
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 18:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYKNRp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 12:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbYKNRp6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 12:45:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbYKNRp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 12:45:57 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C638D16ADA;
	Fri, 14 Nov 2008 12:45:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7C16A16A8D; Fri, 14 Nov 2008 12:44:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16B607E4-B274-11DD-A480-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100992>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

> I have been thinking about making this detached HEAD thing an
> additional option, but it _really_ seemed like overkill.

I agree that it does not make much sense to make this feature an option.
Detaching the HEAD in the repository itself is an enough clue from the
user to the code that the user wants to trigger the feature.

Thanks.
