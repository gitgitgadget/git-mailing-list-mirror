From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: rebase flattens history when it shouldn't?
Date: Wed, 06 Aug 2014 17:09:33 +0200
Message-ID: <53E2452D.6000109@ira.uka.de>
References: <87k374xkpq.fsf@osv.gnss.ru> <20140723175218.GB12427@google.com> <8738drj2fc.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:24:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF34o-00042b-6H
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbaHFPY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:24:26 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37528 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750945AbaHFPY0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 11:24:26 -0400
X-Greylist: delayed 970 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Aug 2014 11:24:25 EDT
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1XF2oy-0005VN-5Q; Wed, 06 Aug 2014 17:08:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <8738drj2fc.fsf@osv.gnss.ru>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1407337688.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1407338658.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254865>

On 23.07.2014 21:33, Sergei Organov wrote:
> What actually bothers me is the unfortunate consequence that "git pull"
> is not always a no-op when nothing was changed at the origin since the
> last "git pull". THIS is really surprising and probably should better be
> fixed. Requiring -f is just one (obvious) way to fix this.

That would invalidate the simple rule that "git pull" is equivalent to 
"git fetch" + "git rebase".

git rebase depends on both branches it operates on, not just one. The 
same goes for "git merge", I assume it is just a coincidence that git 
merge does have this characteristic you now expect both to have.
