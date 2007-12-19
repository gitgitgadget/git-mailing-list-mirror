From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Wed, 19 Dec 2007 20:46:53 +1300
Message-ID: <46a038f90712182346t5309448egebfd3726f4d493c5@mail.gmail.com>
References: <20071217110322.GH14889@albany.tokkee.org>
	 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	 <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	 <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	 <20071218154211.GB12549@alea.gnuu.de>
	 <46a038f90712181541x781c3ebcq6d85b88dbf5cbe23@mail.gmail.com>
	 <38C1471E-0927-4B43-AF73-70735820F8F9@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 08:47:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4teB-0000jr-Qs
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 08:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbXLSHq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 02:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbXLSHq4
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 02:46:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:25385 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbXLSHqz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 02:46:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so247179ugc.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 23:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/cPjCCZfu09gDjEgdaR8q3Hlj1SA4WWML/XrW+YNgWs=;
        b=XreY+sdykGVv3ptJulJs6msqD0kXGd8rjQ6yefVzKS/mI6CaeJPlMoUR81pq43B3lii4QXvZD/OrEBTnllUc07hl6uVNUpcGFQVCAo+T16pPYqHLJLBvyElDJ66ZWpKTenkf9NOzoPs8rJV+Wqf3OsU8EPnf5YLPBOf/V4dOw4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZeqXeEHnZX8EKEVhwU8H8KSOWnN2Bf+z90DWj17i66QpI8qgwn8RtdUMZDufGqHIb/n4S9gBLkyoZ9bG+wMy9pytA+bFoObwabnWWlcVGxs3KGfox7AFYAoGVUVjtHPvfx93E0grsJ55VnF2PW25t7itVP+nMeeRTrPEirTkD8s=
Received: by 10.66.243.2 with SMTP id q2mr1419599ugh.14.1198050413393;
        Tue, 18 Dec 2007 23:46:53 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Tue, 18 Dec 2007 23:46:53 -0800 (PST)
In-Reply-To: <38C1471E-0927-4B43-AF73-70735820F8F9@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68863>

On Dec 19, 2007 8:33 PM, Wincent Colaiuta <win@wincent.com> wrote:
> El 19/12/2007, a las 0:41, Martin Langhoff escribi=F3:
>
> > On Dec 19, 2007 4:42 AM, J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
> >> I vote for stash print the list, because I dropped in the pitfall.
> >
> > I've dropped there myself, and work with a large team where we are
> > both fans of stash, and scarred by it. Any newcomer to git that
> > "discovers" stash gets hit by it a dozen times, this is completely
> > unnecesary.
>
> I may be missing something here, but what's the danger here? An

Surprise. Your working directory has *just* changed under your feet.
Maybe you have an editor with further unsaved changes that is about to
act confused whether you undo the stash or not.

> unexpected stash is incredibly easy to revert, unless I'm missing

Once you know about it, yes it is. Once you know about the reflog, you
can sing and dance and never be worried. But for starting users, it's
a dangerous command.

> And nobody commented on the idea I posted earlier which
> seems to address the concerns about newbies not knowing what "git
> stash" with no params does:

I agree with making stash more verbose -- if the unlucky new user is
paying close attention, they'll have instructions on to how to get out
of trouble. But I agree more with making it "just verbose, no action"
by default. There are two strong hints:

 - all other state-changing commands take parameters
 - quite a few people in this list have gotten burned with it

Even after knowing pretty well how stash works, I still get mixed up
sometimes with the 'clear/clean/list' stuff. Or have a typo in the
command.

cheers,


martin
