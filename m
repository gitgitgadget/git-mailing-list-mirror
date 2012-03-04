From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] "Remote helper for Subversion" project
Date: Sun, 4 Mar 2012 10:23:22 -0600
Message-ID: <20120304162322.GB17923@burratino>
References: <1330777646-28381-1-git-send-email-davidbarr@google.com>
 <CAFfmPPMPDCKjAmZ85Cj1cdT2yAUykm9sV6a66zXeFRmYfrmtjg@mail.gmail.com>
 <20120304075424.GI14725@burratino>
 <CAFfmPPPs0FRbT-i+ZwBLNSca330Eo7thjNxDt3hJf0yUATthtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 17:24:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4EE4-00081d-FS
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 17:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab2CDQX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 11:23:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44862 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2CDQX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 11:23:28 -0500
Received: by iagz16 with SMTP id z16so4489291iag.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 08:23:27 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.50.140.101 as permitted sender) client-ip=10.50.140.101;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.50.140.101 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.50.140.101])
        by 10.50.140.101 with SMTP id rf5mr4230996igb.27.1330878207753 (num_hops = 1);
        Sun, 04 Mar 2012 08:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k2lH5DuXbpr/UGl9u4owltR4b0dmxwoVbhBSTh49eNE=;
        b=YneBRiz7jbzqXgYU9VwA6yafVrrNiiAqlQ5QuSuyGN0gKKwS4CiwJJYtMtsZA+Ia2B
         brcruuZulf70S8kCad/zE5KGSOR6L0YHRGfUEPe4mIjOgvMSAYPT2ENRJGYwbx9NiDDN
         I9vKZ5+obfWmjCMIuGPJhdTv3DB2UlSF31gfyxFEwXNT8rQeoW4KzGgUb8M+CGqiMU7L
         JR23PDv6+CJD/kJbObCJu/uwUwjFjQ68BRnInU5heoOVfvRzFyZPqDUKNJtyb47jX/5h
         Fb1EKr43Snv9ffnIFNMp7uQ6n4Vy0vlMRoL76FZodTGI2BHMFZULyINu63NSYOk9iuls
         1OAA==
Received: by 10.50.140.101 with SMTP id rf5mr3518147igb.27.1330878207659;
        Sun, 04 Mar 2012 08:23:27 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ut8sm8636047igc.11.2012.03.04.08.23.26
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 08:23:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFfmPPPs0FRbT-i+ZwBLNSca330Eo7thjNxDt3hJf0yUATthtQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192164>

David Barr wrote:
> On Sun, Mar 4, 2012 at 6:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> (More generally, if anyone wants to resend useful svn-fe patches, that
>> will help a lot.)
>
> Found at former SoC2011Projects wiki page:
> (http://git.wiki.kernel.org/articles/s/o/c/SoC2011Projects_b1f9.html#Remote_helper_for_Subversion_and_git-svn)
> [vcs-svn, svn-fe: add a couple of
> options](http://thread.gmane.org/gmane.comp.version-control.git/176578)
> [remote-svn-alpha
> updates](http://thread.gmane.org/gmane.comp.version-control.git/176617)

Do you mean these are patches that should be applied?  New emails
containing a git url or, even better, the actual patch are best, since
it means I can be sure I am looking at the latest or at least the
intended version of the change.

[...]
> However, I think it also potentially incorporates git-svn style
> slicing of history.

Do I understand correctly that you mean paying attention to copy-from
information, like "svn log" does?  (For example, making cloning

	svn::http://svn.example.com/project/branches/feature

when branches/feature was originally copied from trunk involve
grabbing "http://svn.example.com/project/trunk" in early revs?)

[...]
> The remainder is porting git-svn logic to the new helper.
> However, it would be interesting to see what's missing with respect to porting

While git-svn can be useful for inspiration when wondering "how could
I possibly solve such-and-such problem", I'm not sure feature-parity
with git-svn is too important.  After all, people needing git-svn
features can still use git-svn.

I say this since git-svn has lots of features we are missing:
not discarding unhandled properties (important), shared history with
multiple branches, author mapping, fetching and pushing svn:mergeinfo
information, partial clone via a path-ignore regex, choice of
timezone, filename reencoding, manual svn:ignore-to-gitignore
conversion, svn-compatible "log" and "blame" output, custom git<->svn
branchname mappings, and so on.  The ability to track one branch,
including push support, with a linear history would be exciting
already and doesn't require all that.

Cheers,
Jonathan
