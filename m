From: Alexander Usov <a.s.usov@gmail.com>
Subject: How do I get a squashed diff for review
Date: Fri, 4 Nov 2011 19:15:01 +0000
Message-ID: <CAH_EFyZ_0JB0-5cw-6VEJkfJhSjbmA=3upByQ3YpmnVSvR+9Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 20:15:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMPEx-0003DD-Sn
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 20:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933123Ab1KDTPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 15:15:43 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56010 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932955Ab1KDTPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 15:15:42 -0400
Received: by ggnb2 with SMTP id b2so2816741ggn.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=Siv7Y+XYRDbberXgrCGwf1yW48vop99XbfF5PKmoAII=;
        b=GpFsjf/FstlK3P5bwumKu4gizpNFDFGFsqw865FN19Ipb/1KdDvHEVObIU5urTCmMs
         4+CbXuO0LZcMLXx1EC7XFQHOme9QWN2KoZ05iRA1podkyACMUBxQe7i/GD9vsl0TqgnB
         PgpXydl0RZhN/dddK530AwxLSTN477V9OZKRs=
Received: by 10.236.174.3 with SMTP id w3mr14065656yhl.117.1320434142101; Fri,
 04 Nov 2011 12:15:42 -0700 (PDT)
Received: by 10.236.105.231 with HTTP; Fri, 4 Nov 2011 12:15:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184799>

Hi,

I'm wondering if there is an easy way to get a squashed diff of the
changes done on the=A0feature=A0branch for review.
In the simple cases (where feature branch is linear) there is an
absolutely fantastic way to get a patch for review:
git diff master...feature

However if the feature branch happened to be long-lived and had
mainline merged into it it's not going to work -- the
resulting diff would contain changes from the merge. The way we are
doing things now is to merge master into it
once more and then diff, however this is somewhat cumbersome. Is there
easier way to do it?

And while we are on the topic -- is there a tool for git similar to "bz=
r qdiff"?
It's a simple graphical diff viewer with 2 nice features -- it shows
complete diff (of multiple files) in a single window and
has a checkbox to switch between diff-only & full-text modes.
I have seen difftool, but it seems to work on per-file basis, and
something like "vi <(git diff ...)" lacks the easy way to
switch into full-text mode.

--
Best regards,
=A0 Alexander.
