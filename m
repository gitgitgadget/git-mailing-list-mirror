From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 15:07:47 +0300
Message-ID: <ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	 <1214306517.6441.10.camel@localhost>
	 <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	 <alpine.DEB.1.00.0806241246500.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7KJ-0007kl-UL
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYFXMHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbYFXMHt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:07:49 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:41799 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYFXMHt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:07:49 -0400
Received: by py-out-1112.google.com with SMTP id p76so1340490pyb.10
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jJPWTyHeNdwsekvtIwsnCSqTpX5rKT15llDvMaZqfTY=;
        b=mwQOxH81tNgb5ANkPggJsVD+4lr0nWjxGlZVexuMShw4j40L2KJ9D841b25d82qp5w
         FhlCCd/8MF2ayJP/v80yHC1oa0/EjOQcRX4SiSp+P8nbCyzTXgstJLP0gJXW6GX/elzP
         xxEC38MWaNE/UxURGGYxnSW4Me/O5PIhC727I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d/pCuaNwl8GvD7q+ceCxgA6KgaLrGTzx7RA5pKbdVd4/6I2d4jivSCTAJ7JN8nNRD9
         6fletP85il3/305/v4DS8XERWPlYaCNkQzj0SxphdjHnl+/MH9jNCNqjuA2N7ESxcgv1
         tWe9atOSCuB6JovY7LjnKhBbNf43GgCt7kMbo=
Received: by 10.141.204.16 with SMTP id g16mr14636809rvq.275.1214309267856;
        Tue, 24 Jun 2008 05:07:47 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 24 Jun 2008 05:07:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806241246500.9925@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86039>

On Tue, Jun 24, 2008 at 2:48 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 24 Jun 2008, Erez Zilber wrote:
>
>> On Tue, Jun 24, 2008 at 2:21 PM, Matthias Kestenholz <mk@spinlock.ch> wrote:
>> > On Tue, 2008-06-24 at 14:15 +0300, Erez Zilber wrote:
>> >
>> >> [root@kd001 t]# git-clone http://kites/pub/git/erez.zilber/my_test.git
>> >> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
>> >> Cannot get remote repository information.
>> >> Perhaps git-update-server-info needs to be run there?
>> >>
>> >
>> > Maybe you should run git-update-server-info in the repository on the
>> > server?
>>
>> Forgot to mention - I tried to run git-update-server-info from the
>> repository on the server.
>
> No, you did not.  Otherwise, the message would not appear.  It can be that
> you have _another_ repository on the server, but running
> update-server-info there does not help.

Thanks for the quick answer. I'm sure that something _is_ wrong.
Otherwise, everything should have worked already.

I think that I'm using the right repository for git-clone because it's
the same path that I used for git push:

[root@kd001 my_test.git]# git-push --all
ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git
erez.zilber@kites's password:
Counting objects: 9, done.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (9/9), 740 bytes, done.
Total 9 (delta 0), reused 0 (delta 0)
To ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git
 * [new branch]      master -> master

Now, on the server side:

-sh-3.1$ cd my_test.git/
-sh-3.1$ ls info/
exclude
-sh-3.1$ git-update-server-info
-sh-3.1$ ls info/
exclude  refs

looks like git-update-server-info did some work (added the refs file).

Back to the client:

[root@kd001 t]# git-clone http://kites/pub/git/erez.zilber/my_test.git
Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

The path is the same path that was used for pushing the repository.
What did I miss here?

Thanks,
Erez
