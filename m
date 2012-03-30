From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Is the "text" attribute meant *only* to specify end-of-line normalization
 behavior, or does it have broader implications?
Date: Fri, 30 Mar 2012 08:42:04 +0200
Message-ID: <4F7555BC.1000804@viscovery.net>
References: <CANSc5vG0o_eAn7X39XhCzUoN4ab52pGCP+PvzOQCyTV31R8LGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Harris <ryguasu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 08:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDVXL-0007TE-NZ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 08:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab2C3GmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 02:42:11 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39644 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab2C3GmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 02:42:08 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SDVXD-0007DT-At; Fri, 30 Mar 2012 08:42:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 97FE21660F;
	Fri, 30 Mar 2012 08:42:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <CANSc5vG0o_eAn7X39XhCzUoN4ab52pGCP+PvzOQCyTV31R8LGg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194331>

Am 3/30/2012 4:19, schrieb Chris Harris:
> I'm starting a new repository for a Windows-only project where I don't
> think I want git to do any end-of-line normalization on my text files.
> (I'm totally happy to have CRLFs both in the repo and in all the
> working copies.)

The question is rather: Are you happy if someone commits a file that does
*not* have CRLF, but only LF?

Because if you don't care, you are better off setting no attributes and no
core.autocrlf and no core.eol at all. The git will take the file
unmodified. If someone's editor changes the eol style of a file, it will
be noticed because the diff will show that the entire file has changed.
Your team mates should better have enough discipline not to ignore such a
hint that something's gone awry, of course.

> Unless you think that end-of-line normalization is
> always vital, let's try to presume I've made the right choice about
> this.

It's your code, you are to judge what is best for you. IOW, I don't think
that eol normalization is "always vital", and you are right. :-)

(I didn't answer the question in the subject of your message, and I can't;
I don't use the text attribute nor eol normalization, even though I work
on Windows quite a lot.)

-- Hannes
