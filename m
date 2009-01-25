From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sun, 25 Jan 2009 12:34:57 -0800
Message-ID: <7vvds3dszy.fsf@gitster.siamese.dyndns.org>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
 <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
 <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
 <831vuvfh7t.fsf@kalahari.s2.org>
 <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
 <83wscndv57.fsf@kalahari.s2.org>
 <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com>
 <alpine.DEB.1.00.0901241438370.13232@racer>
 <94a0d4530901240604o5ae0d321h17dc6aabeefe9d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:36:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBib-000137-0H
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbZAYUfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZAYUfH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:35:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbZAYUfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:35:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B90D39325E;
	Sun, 25 Jan 2009 15:35:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3CD049325D; Sun,
 25 Jan 2009 15:34:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5B2A608-EB1F-11DD-87F6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107093>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's much easier for everyone to just use git config --global than
> explain how create and edit the .gitconfig file. If this is explained
> it shouldn't be in the "Telling git your name" section.

I think it is Ok to have, and it probably is helpful to have, a document
that accompanies the generic manual, "Platform supplement", to explain
things like "On this platform, what is referred to as $HOME in the generic
manual is implemented as %HOMEDRIVE%%HOMEPATH%", to cover peculiarities of
each platform.

But I think it is going backwards to butcher the description in the main
manual in order to make the platform supplement shorter.  Even Windows is
not a good enough reason to break the logical ordering of how things
should be best taught to the readers of the manual, which is not specific
to a platform.
