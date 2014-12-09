From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import should not care about core.ignorecase
Date: Tue, 9 Dec 2014 09:22:45 +0900
Message-ID: <20141209002245.GA14103@glandium.org>
References: <20141209001211.GA13386@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 01:23:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy8Zw-0002Co-TC
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 01:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbaLIAW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 19:22:59 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:34726 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755493AbaLIAW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 19:22:57 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Xy8Zh-0003hg-6G
	for git@vger.kernel.org; Tue, 09 Dec 2014 09:22:45 +0900
Content-Disposition: inline
In-Reply-To: <20141209001211.GA13386@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261101>

On Tue, Dec 09, 2014 at 09:12:11AM +0900, Mike Hommey wrote:
> Hi,
> 
> As you now know, I'm working on a mercurial remote helper for git. As
> such, it uses fast-import.
> 
> In the mercurial history of mozilla-central, there have been various
> renames of files with only case changes, and it so happens that my
> remote helper blows things up on case insensitive file systems. The
> reason is git clone probing the file system and setting core.ignorecase
> appropriately.
> 
> While it makes sense for checkouts and local commits, it doesn't make
> sense to me that using git fast-import with the same import script would
> have a different behavior depending on whether the file system is
> case-sensitive or not.

Heh, I just found this thread:
http://marc.info/?t=139134708700001&r=1&w=2

It doesn't seem to have led to something actually being committed,
though.

Mike
