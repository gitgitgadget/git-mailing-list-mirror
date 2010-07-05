From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: *Non*-interactive squash a range ?
Date: Mon, 05 Jul 2010 08:27:23 +0200
Message-ID: <4C317B4B.3070100@viscovery.net>
References: <AANLkTimTx2dVlK9KKi1nZpOadwDcfyzhE8nffCyK1Sqm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David <bouncingcats@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 08:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVf9P-0005Pk-QZ
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 08:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab0GEG10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 02:27:26 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63013 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab0GEG1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 02:27:25 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OVf9I-0006jh-K8; Mon, 05 Jul 2010 08:27:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7F7681660F;
	Mon,  5 Jul 2010 08:27:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <AANLkTimTx2dVlK9KKi1nZpOadwDcfyzhE8nffCyK1Sqm@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150245>

Am 7/3/2010 15:38, schrieb David:
> I tried this which seems to work:
>  $ git checkout uglybranch
>  $ git checkout -b cleanbranch
>  $ git reset --mixed E          # worktree same as uglybranch
>  $ git add .                    # adds any untracked files
>  $ git commit -a                # -a detects any removed files
> 
> So I'm thinking of using that method in a script. Have I overlooked
> anything? Is there a better way?

Use 'reset --soft' instead of 'reset --mixed' followed by 'add .'.

-- Hannes
