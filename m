From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sun, 22 Sep 2013 00:36:51 -0500
Message-ID: <523e81f338f1e_547c41e7c166be@nysa.mail>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
 <20130921212904.GA235845@vauxhall.crustytoothpaste.net>
 <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
 <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 07:58:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNcgs-00054G-NR
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 07:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab3IVF60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 01:58:26 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55950 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab3IVF6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 01:58:25 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so2436709obb.31
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qcAgcTQtEUSIwv1HcNcb2qagD087pGHrL8/6ys92KO8=;
        b=TOIY008xrtOTG9XxenX0ojhoIG3AwMN234zICNaI1I3/r9IhrVDd0/H3v5ZlzeieL5
         wJOEmTfOjEqCk/DHhJCnfltERi1rd6t0i0oUXKLCV9Yz8bZz19mbLR737OBYMvzVQtlU
         2uN9URg6Esm5Brltz54mGcRDMQeoXEEZ5iG9sI2/riuKFW58Hw0ninp7td1tMDGKA50j
         NjYz6u93LCdMrJuEZOfiycwEi5sVgRp/WjA54JQEnL6X/MfgxAYf4ey8ZfY9CgBx/rQC
         vsQHKwW1xcplHBtyFkk2B/tVwNF2c4650YcKPhWwzUfB80yvmrekiuW7rD1B5lq1RhMy
         XHcA==
X-Received: by 10.182.99.231 with SMTP id et7mr13864120obb.10.1379829504862;
        Sat, 21 Sep 2013 22:58:24 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm8576459oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 22:58:24 -0700 (PDT)
In-Reply-To: <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235159>

brian m. carlson wrote:
> On Sat, Sep 21, 2013 at 05:52:05PM -0500, Felipe Contreras wrote:
> > On Sat, Sep 21, 2013 at 4:29 PM, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > As Junio has also pointed out in the past, there are people who aren't
> > > able to use Ruby in the same way that they are Perl and Python.  If it's
> > > announced now, Git 2.0 might be a good time to start accepting Ruby
> > > scripts, as that will give people time to plan for its inclusion.
> > 
> > Yes, and there are people who aren't able to use Perl/Python in the
> > same way they use Ruby. That's why I tried to show why Ruby makes a
> > perfect choice.
> 
> I'm not arguing against Ruby.  As I said, it's a nice language.  I'm
> just saying that Ruby is not as common as Perl and Python.

In my books Perl is only a tiny bit more common than Ruby.

http://www.tiobe.com/content/paperinfo/tpci/index.html

> I think it's a bad idea to introduce an entirely new runtime, especially
> one known to occasionally blow up on less-common architectures, without
> some advance notice.

This is just FUD. What do you mean blow up on less-common architectures? Do you
have actual evidence or can we just dismiss that as a baseless argument?

> For example, at work I would not be able to deploy a git using Ruby
> immediately because Git is an RPM and Ruby is compiled from source, if it is
> even present at all.

Again, what do you mean? In all the distributions I've seen, vim is compiled
with Ruby support by default, so unless you think vim is an essoteric package,
libruby is almost definetly packaged and available.

> Also, the only Python script that is shipped with Git is git-p4, which
> is essentially optional, since most git users probably do not use
> Perforce. Otherwise, all the scripts in git are shell or Perl.

Neither perl, nor shell, nor python scripts solve the forking problem. My
proposal does.

> So this would be adding a significant additional dependency to core git, one
> which is likely not installed on many systems.

Another claim without a shred of evidence. It's the other way around, it's
likely already installed, and it would not be an additional dependency if the
current scripts get phased out in favor Ruby ones, or even better, C code.

> Of the systems in the Debian popularity contest, 41% have git installed and
> 23% have ruby1.8 installed, with only 16% having the default ruby installed.

Plus the 17% of ruby1.9.1, you get 41%, exactly the same as Git.

But we don't need ruby, all we need is libruby, which is 47%.

> > Now, if anybody has ideas into how the bindings could be more object
> > oriented, I'm all ears, but unfortunately what I foresee is that
> > nobody will consider this proposal seriously.
> 
> My concern is that the Ruby code will end up not being idiomatic, and
> people will view it as bizarre and unmaintainable.

There is no such thing as idiomatic Ruby code. In Ruby there's no single best
way to do something, there's many ways to do the same thing.

> for_each_ref could end up being something like REPOSITORY.refs.each,
> which would be more idiomatic.

And how do you propose to achieve that if the C code doesn't support that?

Do you have in mind the C code that would achieve that, or are you just saying?

-- 
Felipe Contreras
