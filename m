From: Jakub Narebski <jnareb@gmail.com>
Subject: Commit annotations (was:: Octopus merge: unique (?) to git, but is it useful?)
Date: Tue, 3 Jun 2008 22:27:02 +0200
Message-ID: <200806032227.02951.jnareb@gmail.com>
References: <200806030314.03252.jnareb@gmail.com> <200806030932.03051.jnareb@gmail.com> <alpine.LFD.1.10.0806031244290.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 22:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3d6x-000128-60
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYFCU1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbYFCU1J
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:27:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:47451 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYFCU1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:27:07 -0400
Received: by nf-out-0910.google.com with SMTP id d3so667043nfc.21
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=EpT42bYfON3EvCylS+XOVbNHAOwMiUoaI1iLPUvtI6A=;
        b=f1ImqzAwYowK6eU1w1OXeIN5avhU7RCaXTzYGB41jsyA1xyiFvZ0ci3lrn0gzA65erTyXi4qpeFyflALaO/htvlFkcvVzJ3Akenu5lDz6kJeB5HV2RCD+y8L3XZ78RJm7XN51ooXYPGsrgE2f9OeudUYynBUeTTSuCmuFAg8/cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rfCf7PSXG+C5Y/PtMtHqihfxAyttzbmbfcRw7Bz1sBaT1hZyrlCxPXNIgB0eOOOq/kV40ly3m9RH9Cmwj5TPrFt5W+FztDq1K96J1qkVVSJlyadSgSwyQ8DXbcyS8F121x5aP4VXnXg5yraN/jV+HBieWESxCjpBxHOVErbofXk=
Received: by 10.210.102.16 with SMTP id z16mr34142ebb.22.1212524823878;
        Tue, 03 Jun 2008 13:27:03 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id c14sm518355nfi.16.2008.06.03.13.27.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 13:27:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0806031244290.3473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83703>

Linus Torvalds wrote:

> One of the things I could imagine using git for is to have "annotation 
> branches" for things like code review etc. They'd be a real branch in 
> their own right and with their own history, but at the same time they 
> could well want to point back to the "code branch" that they annotate by 
> considering that another parent in a "non-data merge" (and yes, you'd 
> obviously have to use a special merge strategy for things like that, but 
> you'd likely integrate it in some "annotation tool chain" rather than 
> anything else).

By the way, what is status of git-notes / commit annotations?  Did it got
abandoned, on hiatus, or what?

-- 
Jakub Narebski
Poland
