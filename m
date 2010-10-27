From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Wed, 27 Oct 2010 02:01:36 +0200
Message-ID: <vpqocag33mn.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287986922-16308-10-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTinJQMSbW-bsEOS9610GXR7EtbESK_tLAfxt2ibK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 02:02:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAtT0-0000eg-1u
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 02:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758635Ab0J0ACD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 20:02:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44821 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940Ab0J0ACC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 20:02:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9QNtCat006758
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Oct 2010 01:55:12 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PAtST-00043g-AW; Wed, 27 Oct 2010 02:01:37 +0200
In-Reply-To: <AANLkTinJQMSbW-bsEOS9610GXR7EtbESK_tLAfxt2ibK@mail.gmail.com> (Jay Soffian's message of "Tue\, 26 Oct 2010 02\:20\:03 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Oct 2010 01:55:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9QNtCat006758
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288742116.77201@yqURDqC+pOc64Fm9tJexhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160012>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Oct 25, 2010 at 2:08 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> +In this case, "origin" is called a remote repository, or "remote" for
>> +short. The branches of this repository are called "remote branches"
>> +from our point of view, and Git will keep a copy of these
>> +branches, called "remote-tracking branches" in the local repository.
>> +These remote-tracking branches are references that will be updated by
>> +"git fetch" (hence by "git pull"). See
>> +<<Updating-a-repository-With-git-fetch>> for details.
>
> "...and Git will initially clone these branches into so-called
> "remote-tracking branches" in the local repository.

I don't thinks it's a good idea to use the word "clone" here. "clone"
is used for repository cloning, and I find it confusing to overload
the word for branches.

> Thereafter, the
> remote-tracking branches are updated upon fetching from[1] or pushing
> to the remote. ([1] which also includes pulling.)

I don't like the [1] kind of footnote within the text, but I forgot to
mention that "git push" updates the remote-tracking in my text.
That'll be fixed in next version.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
