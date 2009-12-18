From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git remote set-head not working?
Date: Fri, 18 Dec 2009 17:24:48 -0500
Message-ID: <76718490912181424l3815ce95o6dcde77ea00cbd11@mail.gmail.com>
References: <76c5b8580912180825t17bfc90eq20dfc05cafa8c02e@mail.gmail.com>
	 <20091218165302.GA1746@sigill.intra.peff.net>
	 <76c5b8580912180938s2b885efax33be860f963ba92f@mail.gmail.com>
	 <76718490912181328k5f87d82u499b7a1eba471126@mail.gmail.com>
	 <7veimst0w6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 23:24:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLlFn-0005lb-HH
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 23:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbZLRWYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 17:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbZLRWYu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 17:24:50 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:32863 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbZLRWYt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 17:24:49 -0500
Received: by iwn1 with SMTP id 1so2489450iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wmkw70hrYQehFNZ6VlurpMB+wFVbesSL1W74tsj5PB0=;
        b=CfX5Ximf9s9WkzEzMK/AWI2jqTF6naz5lX9Gc7kmy76tNPzjmmb3JEn3IKhbBkq3bM
         qNIk+k8++G0y3E+riGaQvpgJObrsgtx73k9PLL0kucILxOTfQ52BzJQwVps/kxMxW9ZI
         vZJNIumZr6Q9dCqUIyb/vymqU2P3wuBurR+y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tTscvM2W0ZNvl/Ieg2pJnfIoh4OYk2L5PNEf4RhGa3RHAsCV2xd/xdE7dnZ6gWn06A
         pEArI3WfFXO+3OVoyg/PVQ+h2LR8Pt7Yk0G08UBw0ZYd0vu8aqvNTqVghu9PS6p3bTuI
         8yRxjLrWP66WsuKQ4g0OXziqrtp6e2Uc6fhs8=
Received: by 10.231.167.65 with SMTP id p1mr1287195iby.20.1261175088998; Fri, 
	18 Dec 2009 14:24:48 -0800 (PST)
In-Reply-To: <7veimst0w6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135445>

On Fri, Dec 18, 2009 at 4:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> The remote command is about updating things under .git/refs/remotes,
>> not about updating a remote server. For updating a remote server,
>> there is really only push. Clear as mud?
>
> We still support (and unfortunately we would probably end up supporting
> for a long time) "remote update" so it is not strictly true, but that is
> the original motivation behind "git remote" subcommand.

But "remote update" updates the local repo from the remote, it doesn't
do anything to the remote itself. That is the point I was trying to
make clear -- "git remote" doesn't ever do anything to the remote
repo, it only updates things on the local repo.

>> Understood. I'm not sure whether the send-pack/receive-pack protocol
>> supports the notion of "I want to change what HEAD points to."
>
> It does not support it, but that is not because there is a strong reason
> it shouldn't.

Okay. I'm sure deciding where to place the command "I want to update
what HEAD on remote points to" would be a fun discussion. :-)

j.
