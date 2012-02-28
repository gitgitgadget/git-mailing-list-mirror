From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git (commit|tag) atomicity
Date: Tue, 28 Feb 2012 17:46:44 +0100
Message-ID: <4F4D04F4.80905@ira.uka.de>
References: <CADWOt=j8gJvr88eNAfoYq_qGQvG6M_k-9MCuof_DRrH0sHRVCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Jagger <jon@jaggersoft.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 17:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2QC0-0001dx-28
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 17:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab2B1QqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 11:46:18 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34888 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752846Ab2B1QqS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 11:46:18 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S2QBd-0003H3-D8; Tue, 28 Feb 2012 17:46:16 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S2QBd-0000Dn-8L; Tue, 28 Feb 2012 17:46:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CADWOt=j8gJvr88eNAfoYq_qGQvG6M_k-9MCuof_DRrH0sHRVCA@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1330447577.029117000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191743>

On 28.02.2012 16:40, Jon Jagger wrote:
> Hi,
> I don't know a lot about git - I use it as a tool behind
> http://cyber-dojo.com
> which is an online coding dojo server.
> I have a quick question...
> If I do a
>     git commit ....
> in one thread and a
>     git tag | sort -g
> in another thread is the output of the git tag guaranteed to be atomic?

Can a "git commit" add or remove tags? AFAIK it can't and so the two 
commands don't conflict in any way.
