From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Mon, 26 Oct 2009 09:29:31 +0100
Message-ID: <20091026082931.GA6192@localhost>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <20091025160213.GA8532@localhost> <7vzl7eocd6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 09:29:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2KxK-0006Ge-H6
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 09:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbZJZI3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 04:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755238AbZJZI3X
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 04:29:23 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:49486 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbZJZI3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 04:29:22 -0400
Received: by bwz27 with SMTP id 27so1890337bwz.21
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=lpttL+M+0q7/U8cjoG1vtnPgy9Ygm3d6r8/spNVOwUU=;
        b=alK0gs6NX/B6E/NnDRL6D8WSlw/t/QqGlVeU+pHMAmO9/WPnkOILw/47L1wMjtEYh9
         Tho4YZIFI9k8G4IHJUWNn6k1lUZnp2djl3ikVoJZpzKeFup53pLjvtgqvrExwOInyy0B
         US+HRcIaPCMxIwY5cr6mna2VK3aNj9qZ6+fM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=MUsob5/6yH8N+kjwlODrWlGmptK7hc22IugvDVaVlocDeJ3ZZ9UwI2W7g00wIWrX5x
         xDLEcINTg3sm9JGskoGH2MYwh20T0KAk4QQljqtbXxK6UrlyC5rOmuoO9gg6DWSh/Km+
         dKocpYS2zo9NSAupE3rPJjEntSLoS1FSvyIZA=
Received: by 10.204.8.151 with SMTP id h23mr591589bkh.194.1256545764057;
        Mon, 26 Oct 2009 01:29:24 -0700 (PDT)
Received: from darc.lan (p549A7830.dip.t-dialin.net [84.154.120.48])
        by mx.google.com with ESMTPS id 16sm667474bwz.3.2009.10.26.01.29.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 01:29:22 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N2KxH-0001lS-DL; Mon, 26 Oct 2009 09:29:31 +0100
Content-Disposition: inline
In-Reply-To: <7vzl7eocd6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131245>

On Mon, Oct 26, 2009 at 12:14:45AM -0700, Junio C Hamano wrote:

> Are you giving this comment after you actually tried it on Windows and
> found it satisfactory, or is it just based on the general description of
> "this should make it faster"?

I just tried and it went down from several seconds to about half a second.
On slower machines I expect the difference to be even more noticable.

> I need to know, to sift acks/kudos based on facts that I can use to decide
> when to release it to 'master', from wishful thinking that I shouldn't,
> especially after seeing an obvious issue like the one reported by Stephen
> Boyd a few days ago (http://mid.gname.com/4AE0190E.8020803@gmail.com/).

I cannot follow that link. If you're referring to the "completion of
commands available only in build environment" issue, that could also be
considered a feature, because it allows completion of user-defined scripts.

Why does your PATH include the build directory during make, Stephen?

Clemens
