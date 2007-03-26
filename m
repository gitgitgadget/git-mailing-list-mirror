From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 10:16:14 -0700
Message-ID: <1174929374.5662.15.camel@localhost>
References: <1174825838.12540.5.camel@localhost>
	 <vpqvegpe4e1.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsoG-0006Jd-1G
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbXCZRQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbXCZRQd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:16:33 -0400
Received: from smtp-8.smtp.ucla.edu ([169.232.47.138]:58381 "EHLO
	smtp-8.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbXCZRQc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:16:32 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.146])
	by smtp-8.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2QHGHJU000785;
	Mon, 26 Mar 2007 10:16:17 -0700
Received: from [192.168.1.7] (adsl-75-26-189-145.dsl.scrm01.sbcglobal.net [75.26.189.145])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2QHGGo4006678
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Mon, 26 Mar 2007 10:16:16 -0700
In-Reply-To: <vpqvegpe4e1.fsf@olympe.imag.fr>
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.47.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43166>

On Sun, 2007-03-25 at 17:20 +0200, Matthieu Moy wrote:
> I think it's a pitty to restrict yourself to _local_ filesystem. There
> are tons of cases where you have a fast, non-NFS, access to a machine
> and would like to host your repository there.
> 
> That said, I suppose removing this restriction moves the solution from
> the category "quick and efficient hack" to something much harder.

For now, this is really meant for quick and easy access to multiple
branches of your own repo at the same time.


> 
> Stupid question: why .gitlink, and not .git/link or so? This file is
> not versionned, I don't think it should be in the working tree.
> 

There is no .git dir for these.  The .gitlink refers back to the main
repository's .git/external/$submodule, which is a full .git dir with
index+HEAD and symlinks back to the .git of the main repo for everything
else.

-Eric
