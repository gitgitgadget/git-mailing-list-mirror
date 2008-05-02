From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Parent-less branches
Date: Fri, 02 May 2008 14:47:09 -0700
Message-ID: <7vskx0wf8i.fsf@gitster.siamese.dyndns.org>
References: <F26CE1A6-FE85-4AC6-BCE6-B41085A09F0F@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Fri May 02 23:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js36x-0005m3-JX
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 23:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763225AbYEBVrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 17:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759440AbYEBVrX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 17:47:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbYEBVrX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 17:47:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4DCE5E7B;
	Fri,  2 May 2008 17:47:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 29FEA5E78; Fri,  2 May 2008 17:47:17 -0400 (EDT)
In-Reply-To: <F26CE1A6-FE85-4AC6-BCE6-B41085A09F0F@simplicidade.org> (Pedro
 Melo's message of "Fri, 2 May 2008 22:05:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5812F6D4-1891-11DD-873D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81036>

Pedro Melo <melo@simplicidade.org> writes:

> inside an existing repository I want to create a new branch without a
> parent commit. Is there a set of commands to do this?

Typically these commits come about because you created a completely
separate history elsewhere in a separate repository and fetched and/or
pulled from there.

So "a set of commands to do this" would be:

	go away
	git init
        build history as usual
	come back
        git fetch ..from that other repository..
