From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/2] help.c: Add support for htmldir relative to git_exec_path()
Date: Fri, 11 Jul 2008 09:27:56 +0200
Message-ID: <4668B2FF-2B2B-4221-8151-F0AEA681983C@zib.de>
References: <394A4A6F-3D31-4E38-A312-B49DE54FBBDD@zib.de> <1215162566-16062-1-git-send-email-prohaska@zib.de> <7vk5g2uhi9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807041334010.9925@racer>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 11 09:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHD40-0002vW-SU
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 09:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbYGKH2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 03:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbYGKH2M
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 03:28:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:49477 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbYGKH2L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 03:28:11 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6B7RXZm014403;
	Fri, 11 Jul 2008 09:27:38 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9309a.pool.einsundeins.de [77.185.48.154])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6B7RT7k029714
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jul 2008 09:27:33 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807041334010.9925@racer>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88088>


On Jul 4, 2008, at 2:35 PM, Johannes Schindelin wrote:

> On Fri, 4 Jul 2008, Junio C Hamano wrote:
>
>> Could you check if there are copy-and-pasted duplicated code you can
>> factor out before continuing this direction?
>
> Note also that Hannes tried very hard to get rid of those ugly "#ifdef
> __MINGW32__"s by declaring/overriding functions in git-compat-util.h.
>
> I think that is such a good practice that we should not stop here.

I'll send three patches that address Junio's and Dscho's comments:

  [PATCH 1/3] Move code interpreting path relative to exec-dir to new  
function system_path()
  [PATCH 2/3] help.c: Add support for htmldir relative to  
git_exec_path()
  [PATCH 3/3] help (Windows): Display HTML in default browser using  
Windows' shell API


Hannes,
the patches I'll send probably conflict with your planned work on
GIT_EXEC_PATH that has been discussed on the msysgit list.  I think
you could built on my series and modify system_path().

	Steffen
