From: Mike Hommey <mh@glandium.org>
Subject: Re: Allowing push --dry-run through fetch url
Date: Mon, 9 Nov 2009 08:56:07 +0100
Message-ID: <20091109075607.GA16706@glandium.org>
References: <20091106073707.GA14881@glandium.org>
 <7vfx8s0yy1.fsf@alter.siamese.dyndns.org>
 <20091106095357.GA13389@glandium.org>
 <7vfx8obz2o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 08:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7P76-00082j-TA
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 08:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbZKIH40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 02:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbZKIH40
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 02:56:26 -0500
Received: from vuizook.err.no ([85.19.221.46]:45305 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbZKIH4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 02:56:25 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N7P6u-0006ZJ-7l; Mon, 09 Nov 2009 08:56:27 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N7P6d-0004Lm-DO; Mon, 09 Nov 2009 08:56:07 +0100
Content-Disposition: inline
In-Reply-To: <7vfx8obz2o.fsf@alter.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132450>

On Sun, Nov 08, 2009 at 11:23:27AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Usually, when I run git push --dry-run, it's to check that what follows
> > (usually the refspec part) does what I want it to do, such as not pushing
> > tags I didn't intend to push(*), and stuff like that.
> 
> Ahh, that one.
> 
> That reminds me of a topic that we discussed but went away without
> reaching the conclusion on adding a "confirmation: are you sure this
> pushes what you want?" to the command.  I had a doubt about the patch back
> then which was that it hardcoded a tty interaction and it would be hard to
> retrofit it to help GUI frontends (so my suggestion was to use something
> like hooks mechanism, perhaps --confirm=this-script and allow it to do its
> GUI thing), but thinking about it again, they can always use "expect" to
> drive the interaction with the confirmation prompt, so it may not a big
> deal after all---we might want to resurrect the topic.

How about an option to have the confirmation asked, quite like
cp/mv/rm's -i option ?

> That was an unrelated, independent thought on your comment, but if we did
> so, you might not even have to try to use --dry-run on git:// transport.

Sounds like a good trade-off.

Cheers

Mike
