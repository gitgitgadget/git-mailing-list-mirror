From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Wed, 09 Jul 2008 11:48:38 -0700
Message-ID: <7vvdzeki61.fsf@gitster.siamese.dyndns.org>
References: <20080701150119.GE5852@joyeux> <20080709101330.GA3525@joyeux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 20:50:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGejc-0000Nr-Cn
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 20:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383AbYGISsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 14:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbYGISsq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 14:48:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbYGISsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 14:48:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E4F722A8D1;
	Wed,  9 Jul 2008 14:48:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D23E2A8D0; Wed,  9 Jul 2008 14:48:40 -0400 (EDT)
In-Reply-To: <20080709101330.GA3525@joyeux> (Sylvain Joyeux's message of
 "Wed, 9 Jul 2008 12:13:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A737D956-4DE7-11DD-A000-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87907>

Sylvain Joyeux <sylvain.joyeux@dfki.de> writes:

> * changing the output format of git-submodules is not right either,
>   because it would break existing tools which parses it at the moment.

On other two points I do agree with people who objected, but I do not
think this one is particularly bad.  If 'git submodule status' is similar
in spirit to 'git status', then it is more important to make it useful for
human consumption than to keep the wording of the output set in stone.
