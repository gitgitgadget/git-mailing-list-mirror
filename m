From: =?ISO-8859-1?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>
Subject: Re: [RFC] Re: git-svn: make git-svn commit-diff able to work without
 explicit arguments
Date: Wed, 03 Jan 2007 00:09:26 +0100
Message-ID: <459AE626.9040001@gmail.com>
References: <459AA31E.5070705@gmail.com> <7vr6udtbmv.fsf@assigned-by-dhcp.cox.net> <20070102211339.GF17898@hades.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 03 00:09:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1slH-00075H-RW
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 00:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbXABXJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 18:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbXABXJg
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 18:09:36 -0500
Received: from mailfe11.tele2.se ([212.247.155.65]:51679 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964913AbXABXJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 18:09:36 -0500
X-Cloudmark-Score: 0.000000 []
Received: from [83.182.28.216] (HELO [10.0.0.13])
  by mailfe11.swip.net (CommuniGate Pro SMTP 5.0.12)
  with ESMTP id 203458422; Wed, 03 Jan 2007 00:09:34 +0100
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <20070102211339.GF17898@hades.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35836>

Pierre Habouzit wrote:

>   Though an operation that I'd often like to do is to merge two (or
> more) patches as one, and reedit its entry, preferably as a merge of the
> two (or more) old logs.

Actually that's more or less what I wanted to achieve, just that it was 
less general.

Using the solutions that have been proposed in this thread (using 
git-cherry-pick -n and a work branch) looks satisfying for what I want 
to do. Then it's just a matter of cherry-picking the last "work" 
patches, commiting them as a whole in master and then using git-svn 
dcommit the regular way.
