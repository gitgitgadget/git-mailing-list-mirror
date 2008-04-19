From: Mike Hommey <mh@glandium.org>
Subject: Re: git over http
Date: Sat, 19 Apr 2008 20:15:10 +0200
Organization: glandium.org
Message-ID: <20080419181510.GA9536@glandium.org>
References: <16785966.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jacobhenry <jachenry@indiana.edu>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:34:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnHbl-00014o-JM
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 20:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbYDSSPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755054AbYDSSPc
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 14:15:32 -0400
Received: from vuizook.err.no ([194.24.252.247]:33114 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbYDSSPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 14:15:31 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JnHar-0001Ed-SQ; Sat, 19 Apr 2008 20:15:28 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JnHag-0005hp-9r; Sat, 19 Apr 2008 20:15:10 +0200
Content-Disposition: inline
In-Reply-To: <16785966.post@talk.nabble.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79913>

On Sat, Apr 19, 2008 at 11:05:36AM -0700, jacobhenry wrote:
> 
> The past couple days I have tried to configure git over http.  To this point
> I have it working for a small repository. However, when I try to push a
> large directory to the server, it gives me a very vague description of the
> error "http-push died with strange error".  My apache logs do not even
> flicker.  Is there anywhere I can look to see what the actual error is?  
> 
> Here is the trace:
> 
> Fetching remote heads...
>   refs/
>   refs/heads/
>   refs/tags/
> updating 'refs/heads/master'
>   from 0000000000000000000000000000000000000000
>   to   267c7ff02a8dbd0e0d81bbfeee4e64faa4773f83
>     sending 301 objects
>     done
> Updating remote server info
> Waiting for http://url/webservice.git/objects/95/
> error: http-push died with strange error
> error: failed to push to 'http://url/webservice.git/'

Is your server webdav-enabled ?

If yes, can you try again with the GIT_CURL_VERBOSE environment variable
set ?

Mike
