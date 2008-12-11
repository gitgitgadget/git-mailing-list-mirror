From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] submodule: Allow tracking of the newest revision of a
 branch in a submodule
Date: Thu, 11 Dec 2008 11:26:47 -0800
Message-ID: <7voczicy2w.fsf@gitster.siamese.dyndns.org>
References: <1229001361-9301-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: FabianFranz@gmx.de, git@vger.kernel.org, hjemli@gmail.com
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Thu Dec 11 20:28:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LArD8-00056j-0m
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 20:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719AbYLKT1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 14:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759462AbYLKT1A
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 14:27:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759457AbYLKT07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 14:26:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3767C1A16A;
	Thu, 11 Dec 2008 14:26:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3CF8A1A168; Thu,
 11 Dec 2008 14:26:49 -0500 (EST)
In-Reply-To: <1229001361-9301-1-git-send-email-git@fabian-franz.de> (Fabian
 Franz's message of "Thu, 11 Dec 2008 11:16:01 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ACBED054-C7B9-11DD-8DD9-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102813>

Fabian Franz <git@fabian-franz.de> writes:

> So my workflow really is:
>
> git checkout master # done long before
> [...]
> git checkout staging
> # => in submodules/client/
> # Checked out submodules/client/ staging.
> # => in submodules/client/component1/
> # Checked out submodules/client/component/1 staging.
>
> So I would like to have this recursively...

Didn't we add foreach subcommand to the submodule command?
