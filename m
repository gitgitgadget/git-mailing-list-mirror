From: Petr Baudis <pasky@suse.cz>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a'
 when no changes were added)
Date: Sat, 24 Apr 2010 20:54:33 +0200
Message-ID: <20100424185433.GN3563@machine.or.cz>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
 <20100424164247.GM3563@machine.or.cz>
 <alpine.LFD.2.00.1004241430300.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Apr 24 20:54:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5kVB-00066Q-Ea
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 20:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab0DXSyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 14:54:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42925 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab0DXSyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 14:54:37 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 78CFB862095; Sat, 24 Apr 2010 20:54:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004241430300.7232@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145695>

On Sat, Apr 24, 2010 at 02:35:17PM -0400, Nicolas Pitre wrote:
> In that case the deficiency is in the fact that no reflog preserves the 
> intermediate state of the index, not the fact that you might be allowed 
> to do it.  Strictly speaking there is no intermediate ref to log, but a 
> synthetic commit could be created for this case just like a stash but 
> stored in the current branch's reflog.

Possibly, but I don't see how is this better than the check - it is less
user friendly, most importantly because user that has not seen this
twice has no idea that anything *was* saved to a reflog.

Are there valid user scenarios where you customize your index, then want
to override that using -a without thinking twice?

-- 
				Petr "Pasky" Baudis
When I feel like exercising, I just lie down until the feeling
goes away.  -- xed_over
