From: Karl Wiberg <kha@treskal.com>
Subject: Re: [PATCH 1/6] stg mail: Refactor __send_message and friends
Date: Sun, 29 Nov 2009 10:13:44 +0100
Message-ID: <4B123B48.4050405@treskal.com>
References: <20091128194056.949.88791.stgit@bob.kio> <20091128195016.949.17089.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 10:13:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEfqv-0007AA-AF
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 10:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbZK2JNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 04:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbZK2JNn
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 04:13:43 -0500
Received: from mail1.space2u.com ([62.20.1.135]:52888 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbZK2JNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 04:13:42 -0500
Received: from october.e.vtech (90-227-77-189-no63.tbcn.telia.com [90.227.77.189])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nAT9Da7D024600;
	Sun, 29 Nov 2009 10:13:37 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20091128195016.949.17089.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134005>

Alex Chiang wrote:

> Instead of passing all the various smtp* args to __send_message
> individually, let's just pass the options list instead.

Looks good.

> +    if (smtppassword and not smtpuser):
> +        raise CmdException, 'SMTP password supplied, username needed'
> +    if (smtpusetls and not smtpuser):
> +        raise CmdException, 'SMTP over TLS requested, username needed'

Python style nit: Use "raise Exception('message')" in new code. (And
yes, I know you just moved these lines around.)

-- 
Karl Wiberg, kha@treskal.com
    subrabbit.wordpress.com
    www.treskal.com/kalle
