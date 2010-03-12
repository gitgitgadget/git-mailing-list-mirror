From: Adam Nielsen <adam.nielsen@uq.edu.au>
Subject: Re: How do you switch branches in a bare repo?
Date: Fri, 12 Mar 2010 17:12:23 +1000
Organization: The University of Queensland
Message-ID: <4B99E957.60905@uq.edu.au>
References: <4B99DEA2.6050104@uq.edu.au> <4B99E5DD.3020005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 12 08:12:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npz2w-0004vW-8h
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 08:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab0CLHM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 02:12:29 -0500
Received: from mailhub3.uq.edu.au ([130.102.148.131]:52473 "EHLO
	mailhub3.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab0CLHM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 02:12:28 -0500
Received: from smtp3.uq.edu.au (smtp3.uq.edu.au [130.102.128.18])
	by mailhub3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o2C7CQGf002276;
	Fri, 12 Mar 2010 17:12:26 +1000
Received: from [192.168.173.208] (rrtd-it1.research.uq.edu.au [192.168.173.208])
	by smtp3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o2C7COCE024137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Mar 2010 17:12:24 +1000
User-Agent: Thunderbird 2.0.0.23 (X11/20091130)
In-Reply-To: <4B99E5DD.3020005@viscovery.net>
X-UQ-FilterTime: 1268377947
X-Scanned-By: MIMEDefang 2.58 on UQ Mailhub on 130.102.148.131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142027>

>> How do you switch between branches in a bare repo?
> 
> You don't have to. This should work:
> 
>    git push -f . newbranch~2:newbranch
> 
> will remove the last two commits at the tip of 'newbranch'.
> 
> Of course, you can do the push from any other repository as long as you
> are allowed to do non-fast-forward pushes into the bare repository.

Thanks for the suggestion!  Unfortunately it looks like I'm not allowed 
to do non-fast-forward pushes into my own repository because I keep 
getting this error:

error: denying non-fast-forward refs/heads/newbranch (you should pull first)
  ! [remote rejected] newbranch~2 -> newbranch (non-fast-forward)

I tried using a + in front of the branch name as recommended by the 
manpage but it didn't change anything :-(

Any further suggestions?

Thanks again,
Adam.
