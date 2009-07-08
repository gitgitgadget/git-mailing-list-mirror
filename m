From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Wed, 08 Jul 2009 08:38:23 +0200
Message-ID: <4A543EDF.5090302@viscovery.net>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 08:38:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOQnd-0007HA-57
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 08:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339AbZGHGi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 02:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbZGHGi1
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 02:38:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53263 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbZGHGi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 02:38:27 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOQnP-0008Vh-Qh; Wed, 08 Jul 2009 08:38:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 82CA04E4; Wed,  8 Jul 2009 08:38:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122893>

Junio C Hamano schrieb:
> It has been relatively quiet for the past few weeks.  The 'next' branch is
> getting quite thin, and it would be a good time to declare -rc0.  I'll do
> so by my Wednesday.
...
> * js/run-command-updates (Sat Jul 4 21:26:43 2009 +0200) 7 commits
>  - receive-pack: remove unnecessary run_status report
>  - run_command: report failure to execute the program, but optionally
>    don't
>  - run_command: encode deadly signal number in the return value
>  - run_command: report system call errors instead of returning error
>    codes
>  - run_command: return exit code as positive value
>  - MinGW: simplify waitpid() emulation macros
>  - MinGW: truncate exit()'s argument to lowest 8 bits

Please include the first one of this series (truncate exit code) in -rc0;
it fixes a bug in git-bisect on Windows.

Thanks,
-- Hannes
