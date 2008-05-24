From: Mike Hommey <mh@glandium.org>
Subject: Re: git-rerere: Usage question
Date: Sat, 24 May 2008 09:54:36 +0200
Organization: glandium.org
Message-ID: <20080524075436.GA4377@glandium.org>
References: <4836D46A.7070807@dirk.my1.cc> <7vwslkpo1o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 09:56:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzocQ-0006KC-Ry
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 09:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYEXHz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 03:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYEXHz1
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 03:55:27 -0400
Received: from vuizook.err.no ([194.24.252.247]:33699 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbYEXHz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 03:55:26 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1Jzoaw-0006kT-Ck; Sat, 24 May 2008 09:55:20 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JzoaK-0001bb-Q6; Sat, 24 May 2008 09:54:36 +0200
Content-Disposition: inline
In-Reply-To: <7vwslkpo1o.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82802>

On Fri, May 23, 2008 at 05:02:11PM -0700, Junio C Hamano wrote:
> These days, rerere is pretty much automatic in that rerere is called
> automatically from places that generate conflicts (e.g. "git merge") for
> purpose of (1), and from places that the user tells git that the conflicts
> are now resolved (e.g. "git commit") for purpose of (2).

Note that it is not totally automatic for most people because the
default is to enable only if the .git/rr_cache directory exists, and
neither git init nor git clone create this directory.

You still have to set rerere.enabled yourself.

Mike
