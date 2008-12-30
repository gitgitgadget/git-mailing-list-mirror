From: "Joe Casadonte" <jcasadonte@northbound-train.com>
Subject: Re: git clone - failing on cygwin with git:// but not with ssh://
Date: Tue, 30 Dec 2008 11:40:41 -0500
Organization: Llama Fresh Farms, Neare Paraguay
Message-ID: <u7i5hy5ti.fsf@terrapin.northbound-train.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 17:42:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHhfW-0002vv-Eo
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 17:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYL3Qks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 11:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYL3Qks
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 11:40:48 -0500
Received: from dsl092-238-209.phl1.dsl.speakeasy.net ([66.92.238.209]:56158
	"EHLO headlight.northbound-train.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750887AbYL3Qkr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 11:40:47 -0500
Received: from jcasadon-us (localhost.localdomain [127.0.0.1])
	by headlight.northbound-train.com (8.13.8/8.13.8) with ESMTP id mBUGegE6003480
	for <git@vger.kernel.org>; Tue, 30 Dec 2008 11:40:43 -0500
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104193>

Joe Casadonte <jcasadonte <at> northbound-train.com> writes:

> D:\temp>git clone git://foobar/otminfmyproj.git
> Initialized empty Git repository in /cygdrive/d/temp/foobar/.git/
> fatal: read error (Socket operation on non-socket)
> fatal: early EOF
> fatal: index-pack failed
>
> I've turned on verbose logging in the daemon and I see the following
> messages:
>
> Dec 27 17:31:53 foobar git-daemon: [30327] Connection from 192.168.1.102:2598
> Dec 27 17:31:53 foobar git-daemon: [30327] Extended attributes (16 bytes) exist <host=foobar>
> Dec 27 17:31:53 foobar git-daemon: [30327] Request upload-pack for '/myproj.git'
> Dec 27 17:31:55 foobar git-daemon: [30327] Disconnected (with error)
>
> Running the clone via ssh protocol from test client #2 works, though:
>
> D:\temp>git clone ssh://root <at> foobar/nfs02/git/myproj
> Initialized empty Git repository in /cygdrive/d/temp/myproj/.git/
> remote: Counting objects: 104, done.
> remote: Compressing objects: 100% (72/72), done.
> remote: Total 104 (delta 22), reused 104 (delta 22)
> Receiving objects: 100% (104/104), 76.97 KiB | 9 KiB/s, done.
> Resolving deltas: 100% (22/22), done.
>
> The same test machine has cloned from a different linux server via the
> git protocol just fine.

Looking for a little help, please.  Is this not a legitimate git issue?  Can
anyone at least help me diagnose the issue?  Please?

--
Regards,


joe
Joe Casadonte
jcasadonte@northbound-train.com

------------------------------------------------------------------------------
         Llama Fresh Farms => http://www.northbound-train.com
    Ramblings of a Gay Man => http://www.northbound-train.com/ramblings
               Emacs Stuff => http://www.northbound-train.com/emacs.html
          Music CD Trading => http://www.northbound-train.com/cdr.html
------------------------------------------------------------------------------
                       Live Free, that's the message!
------------------------------------------------------------------------------
