From: Junio C Hamano <gitster@pobox.com>
Subject: Re: question about COMMIT_EDITMSG crlf
Date: Tue, 13 Jan 2009 23:04:42 -0800
Message-ID: <7vr6365px1.fsf@gitster.siamese.dyndns.org>
References: <1976ea660901132117l7947157fw2922465a9b3945dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Frank Li" <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 08:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMzpN-0000Tb-PA
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 08:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbZANHEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 02:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbZANHEt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 02:04:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbZANHEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 02:04:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1193090843;
	Wed, 14 Jan 2009 02:04:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4A81490842; Wed,
 14 Jan 2009 02:04:45 -0500 (EST)
In-Reply-To: <1976ea660901132117l7947157fw2922465a9b3945dc@mail.gmail.com>
 (Frank Li's message of "Wed, 14 Jan 2009 13:17:19 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A15A0CFA-E209-11DD-AE6C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105593>

"Frank Li" <lznuaa@gmail.com> writes:

> I want to use notepad replace default vim at commit message editor.
> git commit will create COMMIT_EDITMSG at .git directory. This file is
> unix text mode.
> Is there any config change it to windows text mode?

Nothing I can think of, other than using customized commit templates,
which I suspect is a bit overkill and at the same time misses the point
for this use case.
