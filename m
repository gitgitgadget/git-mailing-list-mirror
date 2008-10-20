From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix multiple issues in index-pack
Date: Mon, 20 Oct 2008 14:31:54 -0700
Message-ID: <7vskqr2bsl.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0810201609300.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:43:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks2NK-0008VS-RO
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 23:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbYJTVcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbYJTVcH
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 17:32:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbYJTVcG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 17:32:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BBFB771C76;
	Mon, 20 Oct 2008 17:32:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A180371C72; Mon, 20 Oct 2008 17:32:01 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0810201609300.26244@xanadu.home> (Nicolas
 Pitre's message of "Mon, 20 Oct 2008 16:46:19 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A1D5C26-9EEE-11DD-9CE2-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98734>

Nicolas Pitre <nico@cam.org> writes:

> Damn... this one was subtle.  And I'm still wondering how the hell the 
> test suite is able to pass with this.  I'll try to figure out why and 
> come up with better tests.

Thanks; much appreciated.
