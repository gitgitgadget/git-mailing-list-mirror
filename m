From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Wed, 21 Jan 2009 12:54:48 -0800
Message-ID: <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 21:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPk7X-0008TD-2u
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 21:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbZAUUy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 15:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbZAUUyz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 15:54:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbZAUUyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 15:54:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 65C6F92AB2;
	Wed, 21 Jan 2009 15:54:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6156E92AB0; Wed,
 21 Jan 2009 15:54:50 -0500 (EST)
In-Reply-To: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Wed, 21 Jan 2009 20:09:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C08AC32C-E7FD-11DD-8924-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106667>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is shorter, avoids the burder to think about the format of the
> configuration file, and git config is already used in other places in
> the manual.

I am moderately against changing this part to use "git config".

We traditionally introduced how to set configuration variables first by
editing it in an editor, and this was quite deliberate, in order to show
how the configuration file looks like, to demonstrate that there is no
deep magic in the file format, and to explain that it is perfectly Ok to
edit it without using "git config" command.

I actually wish this section appeared a lot earlier in the document, but
that is a separate issue.
