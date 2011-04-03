From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Sun, 3 Apr 2011 15:08:39 -0500
Message-ID: <20110403200839.GG3830@elie>
References: <20110403172054.GA10220@kytes>
 <1301857622.3448.134.camel@lambda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 22:09:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6TbY-0001ck-9Y
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 22:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab1DCUIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 16:08:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63124 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab1DCUIo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 16:08:44 -0400
Received: by iwn34 with SMTP id 34so5156281iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TAlp9kRS5iv2Jggfafom3bnGJoL+N73tq/Kpm9of8B0=;
        b=oGrgNIqgRVHmHxHUsmujaAolgmoX1VpQFwMGkXeea8EgTldDmdImJcPqxcJSv0b4Xs
         xfVyeqoBjI7kfbGqjLYx6AtgR/CtVwErG5rZ1wMeA8Cm+069H4rg3z37uXfCTeRZ4t4v
         8ZtKGQEv/QRdTQRUw7RYeXSgwvpSgynMZ3Brg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VpLYffbox1xp1+q+nvHMjBNQ+403U7Pq9hrN4yEhTtA/xNZB69Xx76w9yYOAX2OEbF
         rls0oKwfmNKdGdNMIyjses+qB+rNTaVapXnAh00Hvy48TR/kcT8k8r+nEE6s7GvkYMPN
         GcrE6uCMs1EvvJADRjJCwXvvH95LG30KagTY4=
Received: by 10.42.140.198 with SMTP id l6mr821739icu.481.1301861323701;
        Sun, 03 Apr 2011 13:08:43 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id 13sm3200704ibo.59.2011.04.03.13.08.42
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 13:08:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301857622.3448.134.camel@lambda>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170781>

Stephan Beyer wrote:

> I want to mention an issue that I have not foreseen before: merges.
> (You need merges, for example, when doing rebase -i -p ... -p as in
> --preserve-merges.)
>
> When I began, there was code in the "next" branch that added the TODO
> instructions "mark", "reset" and "merge" to do merges properly and I
> based my work on it. The original pieces by J=C3=B6rg Sommer can stil=
l be
> found here:
> http://repo.or.cz/w/git/sbeyer.git/shortlog/6fabd85e8a777c26f3ae8ce11=
cb7f4265502ea7f
[etc]

Some more pointers:
http://thread.gmane.org/gmane.comp.version-control.git/148059
IIRC there's some rough consensus about the design, even if I'm not
sure what it is :).

Of course a dream would be a way to rebase merge conflict resolutions
instead of being limited to replaying conflict-free merges or
resolving conflicts by hand.  But that's a more complex story.
