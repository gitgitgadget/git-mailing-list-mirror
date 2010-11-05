From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Fri, 05 Nov 2010 08:33:47 +0100
Message-ID: <4CD3B35B.3010404@viscovery.net>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino> <20101104205307.GA8911@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, kevin@sb.org,
	git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Fri Nov 05 08:33:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEGoA-0005Bl-SV
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 08:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab0KEHdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 03:33:53 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24795 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab0KEHdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 03:33:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PEGnz-0002Cm-Rl; Fri, 05 Nov 2010 08:33:48 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 882B91660F;
	Fri,  5 Nov 2010 08:33:47 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101104205307.GA8911@home.lan>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160801>

Am 11/4/2010 21:53, schrieb Yann Dirson:
> #  e, edit = use commit (if specified) but pause to amend/examine/test

That's fine. But how would you determine the "if specified"? In
particular, I like to replace the commit subject by instructions that
remember me what I intended to do after rebase stopped, and I would like
to do that in either of these two forms:

e merge foo-topic!

or

e - merge foo-topic!

-- Hannes
