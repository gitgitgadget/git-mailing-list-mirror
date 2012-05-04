From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Clarity of error messages
Date: Fri, 4 May 2012 09:50:18 +0530
Message-ID: <CAMK1S_hYRN=Td8oOZwtMud2-NyUX=jHWMGHG5ziD8axdQPF8tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Fri May 04 06:21:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQA16-0005Ad-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 06:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134Ab2EDEVB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 00:21:01 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56868 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab2EDEUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 00:20:18 -0400
Received: by obbtb18 with SMTP id tb18so3421787obb.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 21:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LkMMUNw+C/s/+BzcL33TZoMSUwlGrgqTBncaD+Rvhdk=;
        b=yCCs8YZcKO70/9MRa3uLnHUOKwZ6E4YxEh+GEJVqfIb9emLC9i+2EPknKVqlkajpD+
         32XYCHbAkiAQMEm+acZPtRJGy65ZlLaJN5txlH+gUSgJXWH1xd41fNNyedIYUZgTZFbg
         WyTmrNAkJPtzoB9gAJYc3HBQpeCQ4n0xiiRULKALbqnySAf1tf55Eo3cONIAKUeSVIP7
         mLGR1TH7LsddDflk45S2+0WEaCQbTDIhj7V+AuT5ZDDMlJuiFh8FBXWkGklqsY4+n3Wl
         u9NK6I2n0Ef3HlJH9TqImOWkpkKRFTFHXuetjt8tpkdKxWube056jLdwhzUeCWp6lLdD
         VeBg==
Received: by 10.182.11.40 with SMTP id n8mr6280045obb.32.1336105218101; Thu,
 03 May 2012 21:20:18 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Thu, 3 May 2012 21:20:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196985>

On Fri, May 4, 2012 at 8:43 AM, Nathan Gray <n8gray@n8gray.org> wrote:

> I just led a team of reasonably bright people through a transition
> from SVN to git. =C2=A0Not one of them understood this message. =C2=A0=
Every one
> of them thought something was broken. =C2=A0This is a very common
> occurrence, so a short, simple message without jargon for this error
> would be a big, big win.

[Doesn't matter what error message we're talking about so I snipped
out most of this.  Also snipped out most of the original recipients
and changed the subject line to better reflect the specific topic that
evolved.]

What I have to say comes from my experience developing, documenting,
and supporting gitolite, (a project that is far smaller than git).

No one will ever agree on human-readable text.  It's not
bike-shedding; that's the way it is.  I have changed the gitolite
documentation far more often than I have changed the code, so far.  In
fact, I have started batching documentation changes due to the sheer
number of them.

Also, some people don't want to read documentation or learn a bit
about the tool before hand -- they would like the error message to be
all they need to read.  (I wonder how they learned any programming in
the first place!)

I am starting to think that the correct treatment for error messages
is to assign every error a number (a la IBM mainframes; S0C7 anyone?)
and force people to look it up in one or more of the following
"indexes":

  - brief
  - verbose
  - verbose with examples
  - technical/internals

The default could print the "brief" entry along with the error number.

That won't reduce the arguments about what the message should say but
at least you can better accommodate more than one opinion.

Perl folks might recognise this as something like the 'diagnostics'
pragma and/or the 'splain' program, although (1) perl does not print
error numbers you can look up using 'splain', and (2) perl has only
one "index", while I am suggesting 4 different ones.
