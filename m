From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sort_in_topological_order(): avoid setting a commit 
 flag
Date: Wed, 23 Jul 2008 15:07:15 -0700
Message-ID: <7vd4l4b6gc.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807230148130.8986@racer>
 <alpine.DEB.1.00.0807230150480.8986@racer>
 <7v7ibdifbp.fsf@gitster.siamese.dyndns.org>
 <20080723214942.GZ10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:08:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmVW-0004tO-Kt
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 00:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbYGWWH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbYGWWH0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 18:07:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbYGWWHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 18:07:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E376D38011;
	Wed, 23 Jul 2008 18:07:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA82F3800C; Wed, 23 Jul 2008 18:07:17 -0400 (EDT)
In-Reply-To: <20080723214942.GZ10151@machine.or.cz> (Petr Baudis's message of
 "Wed, 23 Jul 2008 23:49:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B9DE55FE-5903-11DD-AA95-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89791>

Petr Baudis <pasky@suse.cz> writes:

> On Tue, Jul 22, 2008 at 06:01:30PM -0700, Junio C Hamano wrote:
>> Do people still actively use show-branch as a G/CUI, especially after that
>> "log --graph" thing was introduced?
>
> To me, show-branch is just more convenient to use; I can see more easily
> which patches are with which branches, which is useful especially for my
> new sick-twisted use of feature branches for individual patches, thus
> having a lot of interdependencies.

Heh, I still recall hearing from many people that its output is hard to
decipher and UI is unintuitive.  What changed their mind, I have to
wonder...
