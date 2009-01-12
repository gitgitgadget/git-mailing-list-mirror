From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable
	errors.
Date: Mon, 12 Jan 2009 13:32:13 -0800
Message-ID: <20090112213213.GM10179@spearce.org>
References: <496BA0E4.2040607@tedpavlic.com> <200901121435.35547.bss@iguanasuicide.net> <496BB204.2040109@tedpavlic.com> <496BB442.90107@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUPu-0001UO-Jy
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbZALVcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZALVcO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:32:14 -0500
Received: from george.spearce.org ([209.20.77.23]:38474 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbZALVcO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:32:14 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 94C9F38210; Mon, 12 Jan 2009 21:32:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496BB442.90107@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105388>

Ted Pavlic <ted@tedpavlic.com> wrote:
>> (note: for some reason Mercurial's bash completion script does not have
>> this problem; they use $1 directly without bash complaining)
>
> It appears like they use
>
> 	complete -o bashdefault
>
> whereas Git's uses
>
> 	complete -o default
>
> I think that's the difference.

If that's all we need to do, that's a simple 1 line change... which
I like.

-- 
Shawn.
