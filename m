From: Sven <svoop@delirium.ch>
Subject: Re: [BUG REPORT] "git ls-remote http://git.domain.com/repo.git HEAD" doesn't work
Date: Sat, 14 Jun 2008 07:49:06 +0000 (UTC)
Message-ID: <loom.20080614T074854-525@post.gmane.org>
References: <loom.20080614T065448-251@post.gmane.org> <20080614071011.GA29699@glandium.org> <7vprqkh423.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 09:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7QWb-0004KA-60
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbYFNHtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYFNHtT
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:49:19 -0400
Received: from main.gmane.org ([80.91.229.2]:33285 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbYFNHtS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:49:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K7QVg-0001WT-Gq
	for git@vger.kernel.org; Sat, 14 Jun 2008 07:49:16 +0000
Received: from 151.121.221.87.dynamic.jazztel.es ([87.221.121.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 07:49:16 +0000
Received: from svoop by 151.121.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 07:49:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.121.151 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9) Gecko/2008061004 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84988>

Junio C Hamano <gitster <at> pobox.com> writes:
> Traditionally it _never_ talked about HEAD as it technically is not a ref.

How likely is it that ls-remote HEAD is added for HTTP as well rather than
stripped for all protocols?

In the latter case, there's of course a solution for Capistrano like using
refs/heads/master as a default instead and allowing the use of other refs by
configuration. I could do such a patch, however, this only makes sense of
ls-remote HEAD won't be added for HTTP.

-sven
