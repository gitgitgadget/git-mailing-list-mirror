From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 18:00:55 +0000
Message-ID: <45D34E57.5050004@webdrake.net>
References: <vpq64a4bzp1.fsf@olympe.imag.fr> <20070214142731.GA1478@moooo.ath.cx> <45D33485.5020906@webdrake.net> <20070214175219.GA7082@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Joseph Wakeling <joseph.wakeling@webdrake.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 19:01:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHORm-0001G4-Mv
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbXBNSBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbXBNSBF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:01:05 -0500
Received: from alf.nbi.dk ([130.225.212.55]:1162 "EHLO alf.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932409AbXBNSBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:01:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by alf.nbi.dk (8.9.3/8.9.3) with ESMTP id TAA29510;
	Wed, 14 Feb 2007 19:00:55 +0100 (MET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <20070214175219.GA7082@moooo.ath.cx>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39709>

Matthias Lederhofer wrote:
> Joseph Wakeling <joseph.wakeling@webdrake.net> wrote:
>> I remember coming across the same issue as Matthieu and never got round
>> to solving it.  In my case the desire is to upload the code onto a
>> remote machine---in particular a cluster where I run simulations.  I
>> don't particularly need that remote code to be in a repo or otherwise,
>> since it's only there to be run, not edited.
> 
> git archive --format=tar HEAD | ssh remote 'cd /some/where;tar xvf -'
> 
> You could put this in a shell script which takes the remote hostname,
> path and optionally the revision to send..

Aaahhh, that looks quite an elegant solution.  Thank you very much!
