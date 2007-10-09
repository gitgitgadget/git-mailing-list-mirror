From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: support absolute paths to tools by git config merge.<tool>path
Date: Tue, 9 Oct 2007 08:42:17 +0200
Message-ID: <9505CF7F-2024-48A8-88B0-0410DB2572B6@zib.de>
References: <11918785613855-git-send-email-prohaska@zib.de> <20071008220025.GZ31659@planck.djpig.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Theodore Ts'o" <tytso@mit.edu>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If8mV-0003Bi-Pd
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 08:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbXJIGlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 02:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbXJIGlD
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 02:41:03 -0400
Received: from mailer.zib.de ([130.73.108.11]:46531 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbXJIGlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 02:41:00 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l996eopa013663;
	Tue, 9 Oct 2007 08:40:50 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1f6fc.pool.einsundeins.de [77.177.246.252])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l996eiU8004602
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Oct 2007 08:40:44 +0200 (MEST)
In-Reply-To: <20071008220025.GZ31659@planck.djpig.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60363>


On Oct 9, 2007, at 12:00 AM, Frank Lichtenheld wrote:

> On Mon, Oct 08, 2007 at 11:22:40PM +0200, Steffen Prohaska wrote:
>> This commit adds a mechanism to provide absolute paths to the
>> commands called by 'git mergetool'. A path can be specified
>> in the configuation variable merge.<toolname>path.
>
> Why not merge.<toolname>.path?
>
> This would it make easy to introduce new variables of the form
> merge.<toolname>.<var> later if needed. I also think it is more
> consistent with names of existing configuration variables.
> (think branch.<name>.<var> or remote.<name>.<var>)

Looks more beautiful on the command line but a bit more complex
in the config file. But I like the idea.

Maybe mergetool.<tool>.path is even a better choice? It clearly
indicate the relationship with mergetool. We could explain:

'The variable merge.tool = <tool> refers to a tool that can
be further specified in mergetool.<tool>.path.'

	Steffen
