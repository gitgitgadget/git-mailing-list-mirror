From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
	mark
Date: Wed, 26 Aug 2009 07:02:24 +0200
Message-ID: <20090826050224.GK3526@vidovic>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org> <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org> <7veiqzjmy7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 07:04:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgAgT-0005Hd-Sk
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 07:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623AbZHZFCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 01:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755542AbZHZFCa
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 01:02:30 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:46972 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbZHZFC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 01:02:27 -0400
Received: by ewy2 with SMTP id 2so1072475ewy.17
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 22:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=GK4kxydx3fXx7hsGByR64uy38LgRXMhvJ9aVujYD/0g=;
        b=uHxzm8JiN5ZQM4EJkl3l7N/X55EZHdQHPLwJNtpjx8aB123FlYDaDKDLU9zEXyYfyN
         kCIVi8VNhyRsTcgQrpcaMa/Y3YiHpz5XhXWogKVKsmBSwFQC2WjulswubeXIP9/wVc/R
         lBJqDM2VA8CUJYJ03mSkzzRAX8Bkg7oSj45NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U2e7FhalUWf6Nop6l2+/IG/0vlu9FPY404BX7XxxaXAnqDnIojFl1gwZ30TYQ2X8fI
         JTu7qpm9zqMlaTvcjZWpkzx3NWLr/i5WfTlLf0jHw489dio2EMfuxngBhFySatReOzOv
         Ehm5tc4ORV2P0CNh8l9EPhFRYjR28aAL4NOlQ=
Received: by 10.210.92.8 with SMTP id p8mr5180492ebb.97.1251262948647;
        Tue, 25 Aug 2009 22:02:28 -0700 (PDT)
Received: from @ (91-164-128-218.rev.libertysurf.net [91.164.128.218])
        by mx.google.com with ESMTPS id 7sm2791022eyg.40.2009.08.25.22.02.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Aug 2009 22:02:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7veiqzjmy7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127066>

The 25/08/09, Junio C Hamano wrote:

> I therefore conclude that using the "remove above scissors" should be a
> conscious decision, and should not be enabled by default.  --obey-scissors
> would be a good option for this reason.

I'm not sure what between --obey or --ignore will help most to write
good commit message.  I (as a maintainer myself or as a contributor)
usually prefer to --amend a commit rather than play with copy/paste or
starting from scratch. So, I tend to agree even if the reasons are not
exactly the same. :-)

That said, I don't bother what is the default that much. The main
purpose is to have the choice.

For people who _really_ want to obey to scissors by default I'll add an
option to git-config. Whithout more comments, I'll add

  scissors.obey

.

-- 
Nicolas Sebrecht
