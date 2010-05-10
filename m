From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 1
Date: Mon, 10 May 2010 10:29:40 +0200
Message-ID: <i2gf3271551005100129s63b14129r5207cd177881c3ba@mail.gmail.com>
References: <g2zf3271551005050559v2ea99346gcc59f941d634ce1a@mail.gmail.com> 
	<90AEA593-35CC-403E-8918-94DB45BC0E06@cordelta.com> <o2pf3271551005091512qdebc006cic2c5b85ab7a9e23e@mail.gmail.com> 
	<66B5CC1B-044A-483E-88D2-DCB0785E3ABE@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon May 10 10:30:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBONS-0003Uz-4J
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 10:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538Ab0EJIaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 04:30:05 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:42924 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0EJIaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 04:30:01 -0400
Received: by qyk13 with SMTP id 13so5742462qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=WtFd4y+NDYR73p+gOVl52kW4NHqyUCe+hvFDd0oFJqw=;
        b=FY8uDEp+jhhjWXhcIODrfv3aKs+oN/kaC/nWeM4dywSWcXh6xvrXZEiFjwxVRRIEJs
         BFlgsoeMLlhcnphrwXGjylr8Al2HYfdn7QZ8pdlGmkBdDot5+zjtAu1blVMsdZZgBsLH
         3FBI8LW299X0q7S0giwf/YGMHU6gMDDOaK0lA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LZOqAtXeMplOqq0oDKfBDXj1ObkV6cAr/6g2n7vW7uZVMlq0eR0XcLC6LaWxJwf0Nt
         gSrNR7aeiOTV/uEtrPixXDDYtNJfVsuxbv8dSKY0DBmyI1HjZ9YOQtm0Y3pHklaBN9aN
         M6kqAY0a5mvSY2NZCChsL5XXhdO7dYwsmZrNQ=
Received: by 10.229.225.7 with SMTP id iq7mr2888810qcb.26.1273480200309; Mon, 
	10 May 2010 01:30:00 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 10 May 2010 01:29:40 -0700 (PDT)
In-Reply-To: <66B5CC1B-044A-483E-88D2-DCB0785E3ABE@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146772>

Hi David,

On Mon, May 10, 2010 at 9:08 AM, David Michael Barr
<david.barr@cordelta.com> wrote:
> I was working on a slow but reliable alternate implementation for
> validation and regression testing. So far, it seems really hard to write
> anything reliable atop Subversion.

Okay. I won't really touch that because I'm not very fluent in Perl.

> I know its bad form, but I've done what I promise is the last history
> manipulation on my public repository. Now that the code is at a point
> that is quite functional and ready to receive contributions, I've signed
> off on my own commits and reviewed the history.

On a related note, we might also want to benchmark it against
alternatives and make the benchmarks public for the 1.0 release.

> On that note, do you think I should rewrite my history to include
> 'signed-off' or any other cleanup before I start accepting patches?

Yeah, I don't think we should have a problem with non-FF updates,
atleast until the project reaches 1.0 and becomes more public.

-- Ram
