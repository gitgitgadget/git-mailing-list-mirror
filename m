From: Patrick Doyle <wpdster@gmail.com>
Subject: git remote vs. submodules
Date: Wed, 10 Nov 2010 20:45:22 -0500
Message-ID: <AANLkTinev0W7-mm9wXmnZwY6DxN0Y2X0hJdpBOgM_4q=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 02:45:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGMEX-00053n-Li
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 02:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab0KKBpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 20:45:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58685 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0KKBpn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 20:45:43 -0500
Received: by fxm16 with SMTP id 16so969447fxm.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 17:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=kXdFKeIhh/hEhhcNBBLu/2lIDVlt5mdGMRE++ZXFZLk=;
        b=Rem0d6K092Z9XEji8aa3AzPqceE23IVcClHuV23cq/HyEMg0as+BQsVuXcui3VUtGh
         CQLMihpVd14kuwNlAufgEybkMWqKcgEJIvR/MmVqpWgsJU/kGb/HmcelUC7L7A9wx1RC
         KzqrazkraK1DAjgEzusmHKR504GkgwotDGW+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=k4edmHahGqXkbYge2l6tyKNv9+NIDbJLtOkULfz6p8GaT09WZv5ACcV+1yyyNyfI9C
         sBIcOMUpYO1nz6ElWj5qB4v+XoEptKwzCKeNXAFMWKds+s4+N/CbXYnrL1mTrzRRppry
         9f+0jSVMOZTBfNpKHVBnp1MhM63dU3MelHMck=
Received: by 10.223.87.2 with SMTP id u2mr6309040fal.106.1289439942214; Wed,
 10 Nov 2010 17:45:42 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Wed, 10 Nov 2010 17:45:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161203>

Hello All,
I was just reading about git remote and I started thinking to myself,
"Gee, nothing I've read says that the remotes have to share a common
ancestor.  I wonder what would happen if I added two independent
repositories as remotes to a superproject?"

So I tried it in a very trivial case.  The first thing I learned was
that I need to make the subprojects subdirectories of a top level
.git-housing directory.  Or else, when I merge them in, everything in
the top level of subproject1 gets mixed in with everything in the top
level of subproject2.  So this doesn't seem to be a good solution for
marrying arbitrary subprojects together.  But if I set up a library of
subprojects properly, it seems like I could do this.

So now I'm wondering... has anybody else ever had thoughts along these
lines?  Has anybody tried this?  Has anybody seen it work (or fail
miserably)?

Why would I want to do this instead of using submodules?  I dunno.  It
just came to mind when I started trying to understand what's really
going on with remotes.  And I vaguely (and perhaps even correctly)
recall there being some controversy regarding submodules when they
were first introduced.

Anyway, I figured It wouldn't hurt to ask folks in the know.

--wpd
