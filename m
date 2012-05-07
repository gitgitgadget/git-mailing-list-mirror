From: Daniel Villeneuve <daniel2villeneuve@videotron.ca>
Subject: git -c var=val not taken into account by git config?
Date: Mon, 07 May 2012 19:16:51 -0400
Message-ID: <4FA857E3.5030609@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 01:19:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRXCl-0003Id-DI
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 01:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605Ab2EGXSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 19:18:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49993 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2EGXSy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 19:18:54 -0400
Received: from [192.168.1.100] ([96.23.132.56]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3O00CCYE3HF070@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 07 May 2012 19:18:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120422
 Thunderbird/10.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197325>

Hi,

Testing color configuration via scripting, I tried the following command:

git -c color.diff=always config --get-colorbool diff false

on a repository with color.diff=auto.

I'd expect "true" as output, but got "false".  "git diff" works as 
expected though.  Is this an exception for "git config"?

Using git version 1.7.10.1.
--
Daniel Villeneuve
