From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 08:05:51 +0200
Message-ID: <20080703060551.GB27419@cuci.nl>
References: <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl> <20080702182510.GC29559@glandium.org> <g4gho9$g42$1@ger.gmane.org> <20080702143519.GA8391@cuci.nl> <20080702183701.GE16235@cuci.nl> <20080702193157.GA21297@leksak.fem-net> <37fcd2780807021342j75f351a5sa525b892caedf965@mail.gmail.com> <20080702234644.GC21297@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Mike Hommey <mh@glandium.org>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK81-0002yW-1g
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbYGCHAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 03:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbYGCG6S
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:18 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55567 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbYGCGFw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 02:05:52 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id AC0C85465; Thu,  3 Jul 2008 08:05:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080702234644.GC21297@leksak.fem-net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87254>

Stephan Beyer wrote:
>On Thu, Jul 03, 2008 at 12:42:30AM +0400, Dmitry Potapov wrote:
>> On Wed, Jul 2, 2008 at 11:31 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
>> > I wonder if grafts can be used in combination with sequencer in such a
>> > way that you rewrite foo~20000..foo~19950 and then fake the parents of
>> > foo~19949 to be the rewritten once.

>> I don't think it is a good idea. During the normal work you should never
>> use grafts.

>I have written this in the context that Stephen only changes some commits
>from a long time ago (foo~20000) and then I showed a way how to avoid that
>sequencer rewrites the rest which takes so long.
>This is not related to "normal work", but to Stephen's use case (if I
>got it right).

You got it right.

>What I've meant, was:
>Instead of faking a lot of parents, changes and even merges using an
>extended grafts file, he could rewrite some patches - which can be fast -
>and then use _only one_ graft to change the parent to the changed and
>rewritten commit.
>This can be done iteratively and seems to be a good agreement in speed
>and reliability.

Indeed.
-- 
Sincerely,
           Stephen R. van den Berg.

This is a day for firm decisions!  Or is it?
