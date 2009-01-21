From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Added giteditor script to show diff while editing commit
 message.
Date: Wed, 21 Jan 2009 16:07:03 -0500
Message-ID: <49778E77.6010906@tedpavlic.com>
References: <1232570841-25641-1-git-send-email-ted@tedpavlic.com> <0E82F261-2D96-4204-9906-C5E8D47E9A5D@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:09:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkJN-00050I-JJ
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbZAUVHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbZAUVHI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:07:08 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:56138 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752483AbZAUVHH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 16:07:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 738DA80D8051;
	Wed, 21 Jan 2009 16:01:10 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gLKd22gnY+BA; Wed, 21 Jan 2009 16:01:10 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 5C83E80D8005;
	Wed, 21 Jan 2009 16:01:10 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <0E82F261-2D96-4204-9906-C5E8D47E9A5D@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106670>

>> This script also detects when "stg edit" is being called and uses "stg
>> show" instead.
> You do know about "git commit -v", right? (Although that displays
> commit message and diff in a single buffer, not two separate ones like
> your script does.)

Actually, I didn't. I was looking for something like hgeditor for git, 
and I found something on vim.org that almost hit the mark but no mention 
of "commit -v".

That being said, I like having the diff up in a separate window. Plus, 
"git commit -v" doesn't help me when I want to "stg edit".

Thanks --
Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
