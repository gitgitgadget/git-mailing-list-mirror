From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Tue, 19 Jan 2010 08:13:37 +0100
Message-ID: <4B555BA1.90605@viscovery.net>
References: <4B547EA6.5070203@isy.liu.se> <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org,
	Jens.Lehmann@web.de
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 08:13:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX8HZ-0004O0-Cm
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 08:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab0ASHNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 02:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138Ab0ASHNk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 02:13:40 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28375 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754059Ab0ASHNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 02:13:40 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NX8HS-0004YI-8O; Tue, 19 Jan 2010 08:13:38 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0168E1660F;
	Tue, 19 Jan 2010 08:13:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137437>

Jacob Helwig schrieb:
> If there is no output from git status in the submodule, then git
> status in the superproject shows the submodule as being clean.
> However, if there is _any_ output from git status (untracked files,
> modified files, deleted files, new files), then the superproject shows
> the submodule as being dirty.

But isn't it a bug that a submodule is considered dirty just because an
untracked file appears?

-- Hannes
