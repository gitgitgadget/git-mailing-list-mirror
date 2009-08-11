From: John Bito <jwbito@gmail.com>
Subject: Re: [EGIT] Push to GitHub caused corruption
Date: Tue, 11 Aug 2009 15:52:29 -0700
Message-ID: <3ae83b000908111552o53189a44h45fc44f124850483@mail.gmail.com>
References: <3ae83b000908101446q2d4f1101we4bbd7023f78b03@mail.gmail.com>
	 <200908110810.45369.robin.rosenberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0Cu-0000G9-BD
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 00:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbZHKWw3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 18:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZHKWw3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 18:52:29 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:53482 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbZHKWw2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 18:52:28 -0400
Received: by gxk9 with SMTP id 9so5584120gxk.13
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nhAy22IPrsEvY8JRzb49paf0XSfl7FEwPgvj/uhZIlU=;
        b=Ss+Gsxv3RB7aaL0WYa+Fxok54/qECsj2QNkKOW4/tsThMapmk+8NgUBEGPoK/YRpaI
         tinsjpKslqEkewmawWZUiTMH8pKcYCZrBnfo6I5K74FkCXhwjv34tZFJv/bqKo4u4upj
         6t8QaM7EI3uUuhA7v891A+RhERwqfMOfsQ0yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=UiWbW/b8PpKZATPSod2p92IqLrp/eZfVDt5Z/vqqj+6dzKZlJQfKMRM6/FxcBa4GXd
         nqW25v7or/4g2MaiiKwWlxfpAV8FF7GH+b6UslcsLjBSrVKAJlWVwiEDPkt32hxH1qAn
         OOie68BUzCtTuq5ArLMYDV8LUvVifQlL9XqIU=
Received: by 10.90.217.13 with SMTP id p13mr232671agg.108.1250031149104; Tue, 
	11 Aug 2009 15:52:29 -0700 (PDT)
In-Reply-To: <200908110810.45369.robin.rosenberg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125610>

Running git fsck -full on the repo that I pushed from is clean.
Here's the git fsck -full from GitHub
       <mojombo>       git fsck --full
       <mojombo>       broken link from tree
f4f9ecd1875938baa42467dfd6a8134d75fe5de4 to tree
57548924f1eca854dc8db00844f95d3de2c82957
       <mojombo>       broken link from tree
f4f9ecd1875938baa42467dfd6a8134d75fe5de4 to tree
3d1f74522c3e7c3c03390fae376446fda6eed306
       <mojombo>       missing tree 3d1f74522c3e7c3c03390fae376446fda6e=
ed306
       <mojombo>       missing tree 57548924f1eca854dc8db00844f95d3de2c=
82957
       <mojombo>       dangling commit ab6ce47159c1eaff0e4bae1929167926=
7de9f669

The repo on GitHub is back where it was before the push.  I have a
copy of the corrupt one from GitHub (358MB tar.gz).  If there's
something I can do that would help to improve JGit/EGit, please let me
know.

Thanks,
John

On Mon, Aug 10, 2009 at 23:10, Robin Rosenberg<robin.rosenberg@gmail.co=
m> wrote:
> m=E5ndag 10 augusti 2009 23:46:34 skrev John Bito <jwbito@gmail.com>:
>> Using the 'release' build of EGit (0.4.9.200906240051) I pushed a
>> commit to GitHub. =A0After that, using git to pull, I get 'bad tree
>> object' resulting in 'remote: aborting due to possible repository
>> corruption on the remote side'. =A0I had a similar problem back in A=
pril
>> (using integration builds of 0.4.0). =A0I'm willing to investigate i=
f
>> there's interest in finding the root of the problem.
>
> Fixing problems related to repository integrity is definitely interes=
ting. One
> can live all kinds of problem, as long as they don't destroy anything=
=2E
>
> -- robin
>
>
