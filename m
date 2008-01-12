From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 11:13:33 -0800
Message-ID: <7v8x2uuaaq.fsf@gitster.siamese.dyndns.org>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
	<4788CDAC.5030409@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:14:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDlo9-0000Ou-Ow
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 20:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbYALTNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756352AbYALTNu
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 14:13:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbYALTNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 14:13:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5772853C7;
	Sat, 12 Jan 2008 14:13:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EC5CB53C5;
	Sat, 12 Jan 2008 14:13:44 -0500 (EST)
In-Reply-To: <4788CDAC.5030409@intelinet.com.br> (Roger C. Soares's message of
	"Sat, 12 Jan 2008 12:24:44 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70348>

"Roger C. Soares" <rogersoares@intelinet.com.br> writes:

> To start, I already had git installed from EPEL.
> Downloaded perl-Error from
> http://dag.wieers.com/rpm/packages/perl-Error/ to satisfy
> dependencies. There was another dependacy for git-arch I think, but as
> I don't need it I just deleted this one.
> When trying to install perl-Error it conflicted with perl-Git from
> EPEL. I think they included perl-Error files inside their perl-Git rpm.
> So, after uninstalling all git rpms from EPEL, installing perl-Error
> from dag.wieers, the rc3 git rpms installed successfully.

Thanks for your report.

I do not know what EPEL is (sorry, I do not live in RPM land),
but I think a package perl-Git that includes perl-Error is
misbuilt.  We are not the official source of where the users
should get perl-Error from.
