From: Moe <moe@signalbeam.net>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Sat, 19 Dec 2009 12:38:59 +0100
Message-ID: <4B2CBB53.5000804@signalbeam.net>
References: <4B2C0828.4010505@signalbeam.net> <20091219013246.GD25474@genesis.frugalware.org> <7vhbrnodd9.fsf@alter.siamese.dyndns.org> <4B2C5A1A.8000201@signalbeam.net> <7vzl5fik3o.fsf@alter.siamese.dyndns.org> <4B2C7EC3.6070501@signalbeam.net> <alpine.DEB.1.00.0912191150450.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 19 12:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLxeT-00040l-R0
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 12:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbZLSLjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 06:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbZLSLjG
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 06:39:06 -0500
Received: from s2.mbox.bz ([85.214.91.204]:42566 "EHLO s2.mbox.bz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbZLSLjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 06:39:04 -0500
Received: from mini.local (unknown [92.206.21.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by s2.mbox.bz (Postfix) with ESMTPSA id BFCEBE04B6C;
	Sat, 19 Dec 2009 12:39:00 +0100 (CET)
User-Agent: Postbox 1.1.0 (Macintosh/20091201)
In-Reply-To: <alpine.DEB.1.00.0912191150450.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135474>

Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 19 Dec 2009, Moe wrote:
> 
>> What we do is, we put our entire runtime environment [for a web 
>> application] under a dedicated user and under version control. This is a 
>> very comfortable way to maintain an identical environment across the 
>> board, we even deploy this way to our production servers by the means of 
>> a git pull on a dedicated branch.
> 
> Just ignoring the fact that you version control a version controlled 
> directory (including the repository), which is inefficient, and even 
> further ignoring the fact that you open the door for concurrent -- 
> incompatible -- modifications, if all you want to do is:

Neither is true.

>> In practice our developers will su or ssh to this user to get working 
>> and generally they need only a very small set of divertions from the 
>> common configuration - such as their personal git identity and their 
>> preferred editor settings.
> 
> ... then I suggest reading up on GIT_EDITOR, GIT_AUTHOR_IDENT and 
> GIT_COMMITTER_IDENT, and leaving the $HOME/.gitconfig alone.

Thanks, that solved my problem.
Seems I started by asking the wrong question.
