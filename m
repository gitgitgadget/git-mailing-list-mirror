From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Thoughts on gitk's memory footprint over linux-2.6.git
Date: Fri, 11 Nov 2011 15:19:43 +0100
Message-ID: <4EBD2EFF.1010000@viscovery.net>
References: <CACPiFC+T1EZ1CSakQxsYZhsnHc-ZsN1-=tpoi-NaQSdpU5Yxkg@mail.gmail.com> <CAMP44s1cZc5OZ0L0zG-Wu+QVpu7xv4-JtWTBtPvnjO7sUFeM9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 15:19:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROrxU-0007nJ-3N
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 15:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab1KKOTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 09:19:48 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2679 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752666Ab1KKOTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 09:19:47 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ROrxI-0003oy-52; Fri, 11 Nov 2011 15:19:44 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D88411660F;
	Fri, 11 Nov 2011 15:19:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <CAMP44s1cZc5OZ0L0zG-Wu+QVpu7xv4-JtWTBtPvnjO7sUFeM9w@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185270>

Am 11/11/2011 13:44, schrieb Felipe Contreras:
> On Mon, Sep 26, 2011 at 10:38 PM, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
>> However, I find it extremely annoying over the kernel tree, due to its
>> memory footprint. It is not the only thing I am running, (Chrome
>> Browser, Gnome3, Firefox, many gnome Terminal windows, emacs), and
>> given that I am looking at "just a couple of commits" I don't feel
>> opening a few gitk instances should be problematic... except that it
>> is.
> 
> Sometimes I do this:
>  % gitk master..branch_1 master..branch_2 ...
> 
> But as I visualize more branches, it becomes tedious.
> 
> It would be nice to have --base option, and show only the commits
> <base>..<branch>.

What's wrong with

     gitk master..branch_1 branch_2 branch_3 branch_4 branch_5
or
     gitk --branches --not master

? (I do that all the time.) Recall that 'master..branch_1' is short for
'^master branch_1'. It is sufficient to specify the negative ref, ^master,
only once.

-- Hannes
