From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 03:15:49 -0500
Message-ID: <53562535f130b_3d2216372ec2a@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <535572b73183b_414c80b30863@nysa.notmuch>
 <CAHGBnuM3TVMbow7Zbb9QnEeJOR9aZY1dwj2CWqs-Ti_HDppE1w@mail.gmail.com>
 <20140421204506.GD5105@thunk.org>
 <535583c0caa69_5c94d452ec6c@nysa.notmuch>
 <CAHGBnuNFW7HCC2U418TC11CKqbB66EtXV_SOs7w0p5RcqAPuLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:26:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcW23-0007nA-8f
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 10:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbaDVI0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 04:26:15 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:35279 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbaDVI0N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 04:26:13 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so5296793oac.2
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 01:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=sNqT7OA6VmCYnvu92VWBJI8pSePLY4gyxGaeqzJJi8A=;
        b=JR4Ci6gMEPvPkPWRW5LMjoVBYm0IgMR4UlTnoH/tB5c5foQVGrSSHPzyqImVqpfTWW
         lV/p7TrYhGZrb9OlFAV+zZySqXwdEDgM/O2mdwXsWOGjDNlDUqCPu0QzfyIMfa6kKi6r
         00bDQm7AOUVFTAKcu3WM+mv3QYnNOc9SNsHD2jGmK17iquxlYOS7UE8PwS7y2YkD74tC
         6hUVXkLxoIYJZKnXXLmmWQATQeHMT1W6HDami6Dil/T3p+LIZsEuSr/XfAJgzfXxEKRA
         0GoxvdqZYcndT8O+b4sfrKocwsJ3YaT7jbEnUBZXY5xHFVHMTsntaBIXcQxJXAm7U+bJ
         zgzg==
X-Received: by 10.60.51.227 with SMTP id n3mr36347684oeo.33.1398155172511;
        Tue, 22 Apr 2014 01:26:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id wy2sm75433608obc.21.2014.04.22.01.26.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 01:26:11 -0700 (PDT)
In-Reply-To: <CAHGBnuNFW7HCC2U418TC11CKqbB66EtXV_SOs7w0p5RcqAPuLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246718>

Sebastian Schuberth wrote:
> On Mon, Apr 21, 2014 at 10:46 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> 
> >> The problem is that between "git rm" and "git mv", if we default "git
> >> cp" to mean "cherry-pick" there could easily be user confusion.
> >>
> >> I'm not sure that cherry-pick is used that often it really needs a two
> >> character shortcut.  Maybe just "git pick"?
> >
> > I'm in favor of having both 'git pick', and 'git pi'.
> 
> Please let's stick to one clear default alias for some central
> commands, and not introduce ambiguity between aliases. That said, I'd
> prefer pick over pi, but still cp would be my personal favorite.

I think porcelain commands should eventually change names (and maybe become
more friendly) 'git ls-files' => 'git ls', 'git cherry-pick' => 'git pick', and
so on.

If 'cherry-pick' evolves into 'pick', it would make sense to have the 'pi'
alias, and in preparation for that I don't see why a temporary 'pick' alias
would hurt.

-- 
Felipe Contreras
