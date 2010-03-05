From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: git stash save <message>
Date: Fri, 05 Mar 2010 14:29:26 +0100
Message-ID: <4B910736.7060604@syntevo.com>
References: <4B90F636.2030300@syntevo.com> <4B90FF40.4020607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 05 14:29:21 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnXad-0005XY-D5
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 14:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab0CEN3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 08:29:09 -0500
Received: from syntevo.com ([85.214.39.145]:35449 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab0CEN3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 08:29:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 1FCEA608084
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <4B90FF40.4020607@viscovery.net>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141580>

On 05.03.2010 13:55, Johannes Sixt wrote:
> Does SmartGit call 'git stash save' behind the scenes with the
> user-supplied message? Then it should run
> 
>   git stash save -- "$msg"
> 
> and you don't need to forbid anything.

Thank you very much, this solved the problem.

Tom
