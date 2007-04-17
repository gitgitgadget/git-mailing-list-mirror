From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 22:33:46 +1200
Message-ID: <46a038f90704170333t38992792m77ddb3d927b21842@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pietro Mascagni" <pietromas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 12:33:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdl0R-0000gY-RS
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 12:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbXDQKds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 06:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbXDQKds
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 06:33:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:46434 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbXDQKdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 06:33:47 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1977538wxd
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 03:33:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMhw4u3daPHDBvqZsOegSIpGIkUfdQT6SUHvG46mBDqvc+gLtiVHzvzoJUN63heuxNiP4iQshRg5c2Qqk/wqlxUv8N2yqhl3+4Qt6HyriwCDRV7ok7ZiPJ+X00tH0g63X5fe1TLAAZdlqNmMvuy508C8Jom1YgMmtjDIwS/gHPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+39k62XLXbxluHPX+ZJrMRqjJoNL5qt2M+KEwo9TsaEofvy3VTkCchEklDAkc9vN2KYKBlxwg5sQ4YMGZ/8jNVBsFe/7TK5cEhe1gNyTuaF2wMrwPEhU7WOccCU8nlQoa29en4S0NpFec7Nq9X6jOe076HMiVVrtqLA8BW5eHE=
Received: by 10.90.49.19 with SMTP id w19mr1346544agw.1176806027040;
        Tue, 17 Apr 2007 03:33:47 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Tue, 17 Apr 2007 03:33:46 -0700 (PDT)
In-Reply-To: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44758>

On 4/17/07, Pietro Mascagni <pietromas@gmail.com> wrote:
> So, in 15 seconds, how does one argue that GIT is vastly superior to
> other version control software, especially CVS.

Adding some ammunition:

 - Old school SCMs allow you to branch, but are unable to keep track
of merges in any meaningful way. Every time you merge, history is
lost. GIT (and other DSCMs) have excellent branching _and_ merging
facilities.

 - Speed (try it on you project repo, or if the project is new, on a
repo sized to what you'd expectyour project to be).

 - Disconnected development. Checkouts on your laptop, continue
working when the server is down.

 - Extremely powerful and flexible if you are using the SCM to manage
the deployment.

 - Behaves transactionally, even when doing things like applying patches

 - Anon GIT is much easier to run (via http)

 - If the team is large, of for any reason the code needs review, you
can setup a tiered review/merge scheme like the linux team does --
instead of a shared repo, each developer has their own repos, and
integrators review and merge (or reject!).

 - Signed tags for releases

And yet... If the project ends up using CVS, you can setup your
cvs->git gateway. Even if you are always at the office, and just use
CVS most of the time, It's enormously useful to be able to call gitk,
use pickaxe, etc. And just by having those tools around your project
will probably benefit.

cheers,


martin
