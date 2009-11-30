From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 1/6] stg mail: Refactor __send_message and friends
Date: Mon, 30 Nov 2009 16:58:25 -0700
Message-ID: <20091130235825.GJ12733@ldl.fc.hp.com>
References: <20091128194056.949.88791.stgit@bob.kio> <20091128195016.949.17089.stgit@bob.kio> <4B123B48.4050405@treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 00:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFG8U-0004q6-UP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 00:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZK3X6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 18:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbZK3X6T
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 18:58:19 -0500
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:28609 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbZK3X6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 18:58:19 -0500
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g5t0006.atlanta.hp.com (Postfix) with ESMTP id DB034C116;
	Mon, 30 Nov 2009 23:58:25 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g1t0038.austin.hp.com (Postfix) with ESMTP id 8025130040;
	Mon, 30 Nov 2009 23:58:25 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 5838FCF000D;
	Mon, 30 Nov 2009 16:58:25 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bdXEnRptpOji; Mon, 30 Nov 2009 16:58:25 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id 43128CF0007; Mon, 30 Nov 2009 16:58:25 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <4B123B48.4050405@treskal.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134149>

* Karl Wiberg <kha@treskal.com>:
> Alex Chiang wrote:
>
>> +    if (smtppassword and not smtpuser):
>> +        raise CmdException, 'SMTP password supplied, username needed'
>> +    if (smtpusetls and not smtpuser):
>> +        raise CmdException, 'SMTP over TLS requested, username needed'
>
> Python style nit: Use "raise Exception('message')" in new code. (And
> yes, I know you just moved these lines around.)

Changed, thanks.
