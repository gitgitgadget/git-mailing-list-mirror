From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH,RFC] make it easier for people who just want to get rid
 of 'git gc --auto'
Date: Wed, 19 Mar 2008 14:59:14 -0700
Message-ID: <7vzlsu1ikt.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803191703280.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6MO-0002IT-I0
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934397AbYCSV7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760163AbYCSV7Y
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:59:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423AbYCSV7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:59:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B750F1262;
	Wed, 19 Mar 2008 17:59:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 254291261; Wed, 19 Mar 2008 17:59:16 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803191703280.2947@xanadu.home> (Nicolas
 Pitre's message of "Wed, 19 Mar 2008 17:06:11 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77567>

Nicolas Pitre <nico@cam.org> writes:

> +Some git commands may automatically run `git-gc`; see the `--auto` flag
> +below for details. If you know what you're doing and all you want is to
> +disable this behavior permanently without further considerations, just do:

I sense certain amount of distaste on the writer's part in the later part
of this sentence.  Did you have to say "without further considerations" to
hint "you are idiot not to consider downsides?"

Maybe we would want to warn what kind of downsides the user might be
dismissing without thinking, which can come back and haunt him later?
