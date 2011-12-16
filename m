From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Branch names with slashes
Date: Fri, 16 Dec 2011 08:02:37 +0100
Message-ID: <4EEAED0D.90006@viscovery.net>
References: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Leonardo Kim <dalinaum@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 08:02:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbRoe-00014I-7m
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 08:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab1LPHCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 02:02:41 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43431 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab1LPHCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 02:02:40 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RbRoT-00019y-Em; Fri, 16 Dec 2011 08:02:37 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 295841660F;
	Fri, 16 Dec 2011 08:02:37 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187263>

Am 12/14/2011 11:17, schrieb Leonardo Kim:
> Branch names can contain slashes, so we can use 'development/foo' as a
> branch name. If I choose 'development' as a branch name, it doesn't
> work. There is a directory named development at '.git/refs/heads'
> directory. So we cannot create a file named development for
> 'refs/heads/development'.
> 
> An error message may occurs like below. Unfortunately, It is not of help to me.
> 'error: 'refs/heads/development/foo' exists; cannot create
> 'refs/heads/development'.
> 
> I think that dealing with a file system and an error message above is
> not sufficient for a novice like me. I hope that it should be
> improved.

Sorry, I don't see anything in the error message that makes a connection
between refs and a file system; it only says "foo/bar exists; cannot
create foo". I really don't see how this can be improved to avoid confusion.

-- Hannes
