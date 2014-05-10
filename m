From: milki <milki@rescomp.berkeley.edu>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sat, 10 May 2014 10:32:26 -0700
Message-ID: <20140510173226.GA27483@hal.rescomp.berkeley.edu>
References: <536E2C19.3000202@gmail.com>
 <20140510172338.GB45511@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Sitaram Chamarty <sitaramc@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 10 19:41:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjBGi-0002QD-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 19:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbaEJRkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 13:40:36 -0400
Received: from hal.ResComp.Berkeley.EDU ([169.229.70.150]:55697 "EHLO
	hal.rescomp.berkeley.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaEJRkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 13:40:35 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 May 2014 13:40:35 EDT
Received: by hal.rescomp.berkeley.edu (Postfix, from userid 1070)
	id EFADF4F8; Sat, 10 May 2014 10:32:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140510172338.GB45511@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248662>

On 17:23 Sat 10 May     , brian m. carlson wrote:
> I don't believe this is possible.  There has been some discussion on
> related matters at least fairly recently, though.
> 
> Part of the reason nobody has implemented this is because it exposes
> additional security concerns.  If I create a commit that references an
> object I don't own, but is in someone else's repository, this feature
> could allow me to gain access to objects which I shouldn't have access
> to unless the authentication and permissions layer is very, very
> careful.  This would make many very simple HTTPS and SSH setups much
> more complex.  Alternates don't have this problem because they're done
> server-side.

If this were implemented service side and specified with, say, a config
option, would this security concern go away?

-- 
milki
