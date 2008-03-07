From: Steven Grimm <koreth@midwinter.com>
Subject: Re: tracking renames
Date: Fri, 7 Mar 2008 00:19:45 -0800
Message-ID: <526E4B08-9F52-461E-B542-4549987C4DFE@midwinter.com>
References: <20080304135734.b2c2f473.akpm@linux-foundation.org> <m3zltegmj0.fsf@localhost.localdomain> <965172C8-C7A4-4932-899B-1E1A77BD7C12@yahoo.ca> <200803051715.58375.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Harvey Harrison" <harvey.harrison@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 09:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXXoa-0004VE-Ct
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 09:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYCGITu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 03:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYCGITt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 03:19:49 -0500
Received: from tater.midwinter.com ([216.32.86.90]:34184 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751461AbYCGITs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 03:19:48 -0500
Received: (qmail 2083 invoked from network); 7 Mar 2008 08:19:46 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=AhwBbej7I9z1I9m60nz0I3LkWMp2dVDru4BfJZaIRPP+2gVZ+HWbukjgheaPhYGW  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 7 Mar 2008 08:19:46 -0000
In-Reply-To: <200803051715.58375.jnareb@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76467>

On Mar 5, 2008, at 8:15 AM, Jakub Narebski wrote:
> No, you are not the only one. Use Bazaar-NG (bzr) or Mercurial (hg)
> if you think you truly need rename _tracking_ as opposed to rename
> _detection_.

Having watched (and participated in) this discussion several times as  
it's come up on the list, the one thing I don't understand is why  
people -- not you, but others -- think this has to be an "as opposed  
to" issue. I have yet to see anyone propose that git should lose its  
rename detection, but the counterarguments and explanations about how  
inferior rename tracking is often seem to presuppose that that's  
what's being asked for.

I think the setup the pro-rename-tracking crowd mostly wants is, "git  
always treats explicitly specified renames as renames and uses its  
current detection regime if there is no explicit specification." As  
you say later on in the parent message, a wish-list item that hasn't  
become reality yet.

I am not saying I think it's too important, BTW; I'm just trying to  
clarify the other point of view. Personally, my only major wish item  
for git's rename support is better handling of directory renames, but  
I don't really care how git knows that the directory in question has  
been renamed. The file rename support has worked very well for me in  
practice.

-Steve
