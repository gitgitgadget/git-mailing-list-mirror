From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG REPORT] "git ls-remote http://git.domain.com/repo.git HEAD"
 doesn't work
Date: Sat, 14 Jun 2008 00:24:36 -0700
Message-ID: <7vprqkh423.fsf@gitster.siamese.dyndns.org>
References: <loom.20080614T065448-251@post.gmane.org>
 <20080614071011.GA29699@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven <svoop@delirium.ch>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Q8x-0007U8-Ds
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbYFNHYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYFNHYy
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:24:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYFNHYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:24:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A94032243;
	Sat, 14 Jun 2008 03:24:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0DB342242; Sat, 14 Jun 2008 03:24:44 -0400 (EDT)
In-Reply-To: <20080614071011.GA29699@glandium.org> (Mike Hommey's message of
 "Sat, 14 Jun 2008 09:10:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F9C4C86E-39E2-11DD-89E2-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84978>

Mike Hommey <mh@glandium.org> writes:

> http://www.kernel.org/pub/scm/git/git.git/info/refs doesn't contain HEAD.
> Shouldn't it ?

Traditionally it _never_ talked about HEAD as it technically is not a ref.
