From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 14:55:58 +0200
Message-ID: <4E96DFDE.4060707@ira.uka.de>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org> <loom.20111013T141239-151@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:14:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REL70-0007bz-Fd
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab1JMNOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:14:09 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:47386 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755146Ab1JMNOI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 09:14:08 -0400
X-Greylist: delayed 1110 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Oct 2011 09:14:08 EDT
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1REKoq-00006U-Lh; Thu, 13 Oct 2011 14:55:36 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1REKoq-0005WG-6M; Thu, 13 Oct 2011 14:55:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.22) Gecko/20110907 SUSE/3.1.14 Thunderbird/3.1.14
In-Reply-To: <loom.20111013T141239-151@post.gmane.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1318510537.013182000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1318511647.010865000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183479>

On 13.10.2011 14:42, arQon wrote:
>> git co -b foo
>   Switched to a new branch 'foo'
>> notepad file1
> (edit stuff)
>> git st
>   # On branch foo
>   # Changes not staged for commit:
>   #       modified:   file1.txt
>
>> git co master
>   M       file1.txt
>
> Maybe I'm just missing something obvious, but at the time that last "git
> co master" was issued:
>
> The file is locally modified.
> The file is different on the current branch (foo) than on the branch to which
> I am switching (master).

Wrong. On branch foo as well as on master the same old file1.txt is 
committed. You never staged nor committed the new file1.txt anywhere.

> The command fails to refuse to switch branches.
