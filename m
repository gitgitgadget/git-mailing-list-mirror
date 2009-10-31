From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Sat, 31 Oct 2009 21:12:46 +0100
Message-ID: <4AEC9A3E.7030601@kdbg.org>
References: <d411cc4a0910291035m45ba0a8egd8a991acfbf6d5a7@mail.gmail.com> <20091031020634.GL10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 21:13:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4KJo-0003n2-0W
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 21:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933218AbZJaUMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 16:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933214AbZJaUMs
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 16:12:48 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56440 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933202AbZJaUMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 16:12:48 -0400
Received: from [77.116.114.175] (77.116.114.175.wireless.dyn.drei.com [77.116.114.175])
	by bsmtp.bon.at (Postfix) with ESMTP id E8CD52C4002;
	Sat, 31 Oct 2009 21:12:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091031020634.GL10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131853>

Shawn O. Pearce schrieb:
> Scott Chacon <schacon@gmail.com> wrote:
>> +Currently only 'host' is allowed in the extra information.  It's
> 
> No.  We should make this a MUST.  As in:
> 
> 	Only host-parameter is allowed in the git-proto-request.
> 	Clients MUST NOT attempt to send additional parameters.
> 
> Sending another header can cause older git-daemons to lock up.

I think you are making a wrong case here: Older git-daemons that lock up 
are security holes because they allow DoS attacks, and any decent admin 
will want to upgrade to a fixed git-daemon anyway.

Fixed git-daemons can allow extra information in addition to 'host'. I 
know you argued otherwise when you submitted the fix to git-daemon, but I 
think you were wrong already back then.

-- Hannes
