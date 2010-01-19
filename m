From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Tue, 19 Jan 2010 09:23:38 +0100
Message-ID: <4B556C0A.9020204@isy.liu.se>
References: <4B547EA6.5070203@isy.liu.se> <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com> <4B555BA1.90605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org,
	Jens.Lehmann@web.de
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 09:24:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX9OE-00089d-MI
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 09:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab0ASIXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 03:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391Ab0ASIXP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 03:23:15 -0500
Received: from mailgw1.uni-kl.de ([131.246.120.220]:36985 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab0ASIXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 03:23:15 -0500
Received: from dfki.uni-kl.de (dfki-1002.dfki.uni-kl.de [131.246.195.2])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id o0J8NCTc011457;
	Tue, 19 Jan 2010 09:23:12 +0100
Received: from serv-2100.kl.dfki.de (serv-2100.kl.dfki.de [192.168.21.180])
	by dfki.uni-kl.de (8.13.8+Sun/8.11.4) with ESMTP id o0J8NCji011339;
	Tue, 19 Jan 2010 09:23:12 +0100 (CET)
Received: from [192.168.21.153] (pc-2163.kl.dfki.de [192.168.21.153])
	by serv-2100.kl.dfki.de (8.13.8+Sun/8.13.8) with ESMTP id o0J8NCMZ001910;
	Tue, 19 Jan 2010 09:23:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B555BA1.90605@viscovery.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137442>

Johannes Sixt wrote:
> Jacob Helwig schrieb:
>> If there is no output from git status in the submodule, then git
>> status in the superproject shows the submodule as being clean.
>> However, if there is _any_ output from git status (untracked files,
>> modified files, deleted files, new files), then the superproject shows
>> the submodule as being dirty.
> 
> But isn't it a bug that a submodule is considered dirty just because an
> untracked file appears?

I prefer the old behavior, and find the new one a bit unintuitive and I
suspect it will hit more people than just me once the change ends up on
master.  Unfortunately, the response yesterday pointed in the direction
of this being a wanted feature.  I think the change of behavior should
at least be mentioned in the release note.

/Gustaf
