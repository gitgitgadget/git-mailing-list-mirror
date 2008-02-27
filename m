From: Mike Hommey <mh@glandium.org>
Subject: Re: FW: git via http protocol _and_ a proxy using
	NTLMauthentication -- git 1.5.4.2 & curl 7.18.0
Date: Wed, 27 Feb 2008 23:55:34 +0100
Organization: glandium.org
Message-ID: <20080227225534.GA16778@glandium.org>
References: <AA28F077645B324881335614E4F7C428034C08@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ken.Fuchs@bench.com
X-From: git-owner@vger.kernel.org Wed Feb 27 23:53:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUV9d-0003ev-4h
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbYB0Wwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 17:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbYB0Wwb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:52:31 -0500
Received: from vuizook.err.no ([85.19.215.103]:41872 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756184AbYB0Wwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 17:52:30 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JUV8Q-0000Vb-Ez; Wed, 27 Feb 2008 23:52:28 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JUVBW-0004Rf-QJ; Wed, 27 Feb 2008 23:55:34 +0100
Content-Disposition: inline
In-Reply-To: <AA28F077645B324881335614E4F7C428034C08@win-ex01.bench.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75317>

On Wed, Feb 27, 2008 at 04:10:57PM -0600, Ken.Fuchs@bench.com wrote:
> The command used to generate the above output is:
> 
> $ GIT_CURL_VERBOSE=1 git fetch \
>   http://www.kernel.org/pub/scm/git/git.git
> 
> I originally tried the following command as suggested by the git
> home page for getting "git by git".
> 
> $ GIT_CURL_VERBOSE=1 git clone \
>   http://www.kernel.org/pub/scm/git/git.git
> Initialized empty Git repository in /mnt/s2u1/git/test-git/git/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
> $
> 
> This seemed like a good test for validating my git installation,
> but this command doesn't access the proxy at all.  The fetch
> command does.  Why the difference?

git-clone is not a builtin yet. When it is (and a patch has come for
that), it will correctly use proxys.

Mike
