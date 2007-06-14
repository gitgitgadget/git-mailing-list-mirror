From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Stupid quoting...
Date: Wed, 13 Jun 2007 18:06:19 -0700
Message-ID: <4670948B.7070407@midwinter.com>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706131316390.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 03:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HydnA-0004sx-SZ
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 03:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080AbXFNBG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 21:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756986AbXFNBG1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 21:06:27 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:47095
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1756953AbXFNBG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 21:06:27 -0400
Received: (qmail 9448 invoked from network); 14 Jun 2007 01:06:26 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=I9tflkp17wrh9voJ8QmY/ZSFUGWmmoNIMwc5Mud41mK8HzzqeMEufmLSSXuQbteD  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 14 Jun 2007 01:06:26 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <Pine.LNX.4.64.0706131316390.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50151>

Johannes Schindelin wrote:
> The recommended way is not using spaces to begin with. I mean, does 
> "David" contain spaces? People seem not to see the problem, and fail to 
> blame Microsoft for all the damage they have done, introducing that 
> stupid, stupid concept of filenames containing spaces, and _enforcing_ it.
>   

To be fair, Microsoft did not invent the concept of filenames with 
spaces. Even UNIX has, I believe, always allowed them, though you risked 
running into buggy scripts misbehaving if you used them. And really, 
filenames with spaces are only a nuisance in a text-based command line 
scripting environment, and only then because someone early on decided to 
use space rather than some other metacharacter as the only available 
delimiter between command arguments in scripts.

For regular users who aren't writing shell scripts, long-form filenames 
mean a document's name is the same as its title, which is hugely helpful 
from a user interface point of view: "February Marketing Budget" is much 
more self-documenting as a filename than "febmkbgt" or whatever they 
would have had to choose in the old days (and remember, UNIX had a 
14-character filename size limit in the early days; long filenames 
weren't introduced until BSD.)

I view filenames as primarily for human consumption, so they should act 
the way humans expect names to act. Computers can just use inode numbers 
or file IDs to refer to files (like, say, SHA1 hashes) -- the pretty 
names are all for the benefit of us meat-brained entities.

Then again, that means I also think case sensitivity in filenames was a 
bad design choice. To use your "people's names" analogy, if you ask any 
random person whether "Billy-bob Thornton" and "Billy-Bob Thornton" are 
the same name, they'll almost always say yes; most people don't consider 
capital letters and lower-case letters to be different letters, just 
different forms of the same letters. And I know how popular *that* 
opinion is around here...

-Steve
