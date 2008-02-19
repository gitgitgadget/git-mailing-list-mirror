From: Mike Hommey <mh@glandium.org>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 07:39:37 +0100
Organization: glandium.org
Message-ID: <20080219063937.GB3819@glandium.org>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 07:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRM7O-0001JE-GV
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 07:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbYBSGho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 01:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbYBSGhn
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 01:37:43 -0500
Received: from vuizook.err.no ([85.19.215.103]:50703 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779AbYBSGhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 01:37:43 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JRM6g-00032K-H4; Tue, 19 Feb 2008 07:37:40 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JRM8f-0001Hm-NB; Tue, 19 Feb 2008 07:39:37 +0100
Content-Disposition: inline
In-Reply-To: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74378>

On Mon, Feb 18, 2008 at 04:49:33PM -0800, Anatoly Yakovenko wrote:
> so this is as fun as pulling teeth
> 
> i have been following this guide,
> http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
> 
> but no matter what i do, when i try to do the initial push, git just
> hangs without any messages.  I have nothing in my apache server error
> log, but i have this in the accesslog:
> 
> *.*.*.*- foobar [18/Feb/2008:16:40:12 -0800] "PROPFIND /git/repo
> HTTP/1.1" 301 320

Try adding a / at the end of the url you use for your repo.

Mike
