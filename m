From: Simon Ruderich <simon@ruderich.org>
Subject: Re: File extension conflict when working with git and latex
Date: Fri, 21 Mar 2014 17:36:28 +0100
Message-ID: <20140321163628.GA28121@ruderich.org>
References: <20140321161324.GC2965@fu.192.168.200.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthias Beyer <mail@beyermatthias.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 17:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR2Qv-0005pz-Te
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 17:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbaCUQgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 12:36:32 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:59461 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaCUQgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 12:36:31 -0400
Received: from localhost (p54B5F0B4.dip0.t-ipconnect.de [::ffff:84.181.240.180])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Fri, 21 Mar 2014 17:36:29 +0100
  id 000000000002009B.00000000532C6A8D.0000570D
Content-Disposition: inline
In-Reply-To: <20140321161324.GC2965@fu.192.168.200.1>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244696>

On Fri, Mar 21, 2014 at 05:13:24PM +0100, Matthias Beyer wrote:
> Unfortunetely, we wrote our `make clean` task recursively. I think you
> can imagine what went wrong: The clean-task corrupted the repository,
> as it removed .idx files from within .git/.
>
> I lost work because of this ugly name collision.

Hello Matthias,

You can recreate the .idx files by running

    git index-pack .git/objects/pack/pack-<hash>.pack

for each pack file.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
