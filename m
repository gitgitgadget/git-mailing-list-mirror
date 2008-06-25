From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: how to list all files that will be comitted
Date: Wed, 25 Jun 2008 18:19:13 +0200
Message-ID: <g3tr63$fqn$1@ger.gmane.org>
References: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 18:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXjZ-0005zR-2Y
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYFYQTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 12:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbYFYQTb
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:19:31 -0400
Received: from main.gmane.org ([80.91.229.2]:45520 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbYFYQTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:19:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBXiO-0004lq-RH
	for git@vger.kernel.org; Wed, 25 Jun 2008 16:19:24 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 16:19:24 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 16:19:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86299>

Rhodes, Kate venit, vidit, dixit 25.06.2008 17:31:
> I know ls-files is the tool I need but I haven't been able to figure  
> out what combination of options will give me the files that have been  
> added to the index.

I don't think git ls-files does that, but

git diff --cached --name-only

will.

Cheers,
Michael
