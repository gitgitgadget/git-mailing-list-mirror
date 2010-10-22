From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Fri, 22 Oct 2010 10:50:17 -0400
Message-ID: <4CC1A4A9.3040703@xiplink.com>
References: <4CC05E4B.1010106@xiplink.com>	<4CC06439.8040003@xiplink.com>	<20101021191045.GC11759@burratino> <20101021210842.6545a661@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 16:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9IxH-0005ZL-FW
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 16:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab0JVOuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 10:50:46 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:58478 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab0JVOup (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 10:50:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp44.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 9E4191284EF;
	Fri, 22 Oct 2010 10:50:44 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp44.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 444691284A3;
	Fri, 22 Oct 2010 10:50:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100922 Thunderbird/3.1.4
In-Reply-To: <20101021210842.6545a661@montecarlo.grandprix.int>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159693>

On 10-10-21 09:08 PM, Peter van der Does wrote:
> 
> In the case of Marc's problem, it would be helpful to see what the
> result is in Bash 3.

Bash v3 seems to work fine:

$ echo $BASH_VERSION
3.2.0(1)-release

$ git branch -a
  bar
  baz
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/battle
  remotes/origin/battle.hardened
  remotes/origin/master

$ git tag
bassinet

$ git push origin HEAD:<tab><tab>
battle            battle.hardened   HEAD              master

$ git push origin HEAD:ba<tab>
  git push origin HEAD:battle<tab><tab>
battle            battle.hardened

		M.
