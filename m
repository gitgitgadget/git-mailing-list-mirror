From: Mike Hommey <mh@glandium.org>
Subject: Re: Announcing a new (prototype) git-remote-hg tool
Date: Sat, 6 Dec 2014 08:46:22 +0900
Message-ID: <20141205234622.GA2457@glandium.org>
References: <20141205205335.GA28935@glandium.org>
 <20141205221319.GK16345@google.com>
 <20141205225930.GA29256@peff.net>
 <20141205231330.GL16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx2Zy-0005sb-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbaLEXqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:46:25 -0500
Received: from [12.216.224.110] ([12.216.224.110]:51439 "EHLO glandium.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752774AbaLEXqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 18:46:24 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Xx2Zq-0000gU-8J; Sat, 06 Dec 2014 08:46:22 +0900
Content-Disposition: inline
In-Reply-To: <20141205231330.GL16345@google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260918>

On Fri, Dec 05, 2014 at 03:13:30PM -0800, Jonathan Nieder wrote:
> Jeff King wrote:
> 
> > One of the nice things about spinning remote-hg out of the core repo is
> > that it means we do not have to endorse a particular implementation, and
> > they can compete with each other on their merits.
> 
> True.
> 
> [...]
> > It's a shame that both squat on the name "remote-hg", because it makes
> > it difficult to tell the two apart. But of course that is the only way
> > to make "git clone hg::..." work. Maybe we need a layer of indirection?
> > :)
> 
> If the helpers are roughly interchangeable (that is, if you can switch
> between fetching using each one into the same on-disk git repository),
> then picking one to symlink as git-remote-hg in your $PATH should be
> enough.
> 
> If they don't have that level of interoperability, then there's an
> argument to be made that the URLs shouldn't be the same.

I don't think Felipe's and the one that uses hg-git under the hood are
already interoperable. Mine is also different from both. They should all
produce the same git trees. They don't produce the same commits. They
also don't share the same metadata.

Mike
