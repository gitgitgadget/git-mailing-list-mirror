From: Josh Ralburton <josh.ralburton@gmail.com>
Subject: Question about "branch.<name>.merge"
Date: Fri, 18 Mar 2011 12:35:15 -0700
Message-ID: <AANLkTin-96TK_8MjAM7MB4CCyZ0ZSvD=ZanaYWLiXsvC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 20:39:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0fWC-0002Yr-JC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 20:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181Ab1CRTjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 15:39:22 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52837 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab1CRTfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 15:35:17 -0400
Received: by pzk9 with SMTP id 9so501931pzk.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=N2NY/jJgqK25kBXVcNpb0MFNpNvHyCWaVm8IpIJ4unQ=;
        b=OAJcy/ohRuG6zAGHk6KQOV/5uxPESWpZ1+qecsUcY+GeqMuVlElM+jLPwKxDSgtJPS
         3ovW5E1tUqV/Ez2//wkrQxkRF1L5BVpUBMG0+G4ubOeCS2qVJDGKtX9uyEcw/qHsjJSO
         4fg1yBkVEOM7LC4ZkwrF0cDoXYQh1xKzFFLb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Qdisv1rO3b2c918mSC2liBZNGOJ55tvMHFJKKh3sC13GwsmJ1ZaG67uDOMlaK69Xi6
         HAlKeQbl7z3edSNeoANvmqFWza0YzJV3H646HWUD1g1lfbTRckhiBU3szCAokJdP/uPD
         2gndEjQn1bxU2UsgCDWXJbELGaE/B3EScFocw=
Received: by 10.142.248.28 with SMTP id v28mr358681wfh.81.1300476915318; Fri,
 18 Mar 2011 12:35:15 -0700 (PDT)
Received: by 10.142.47.15 with HTTP; Fri, 18 Mar 2011 12:35:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169349>

This is a typical section from a .git config file:

[remote "origin"]
    fetch = +refs/heads/*:refs/remotes/origin/*
    url = git://git.kernel.org/pub/scm/git/git.git
[branch "master"]
    remote = origin
    merge = refs/heads/master

I am curious why "branch.master.merge=refs/heads/master"  was
implemented to refer to the remote branch (refs/heads/master) rather
than the local branch (refs/remotes/origin/master).

Thanks.

Josh
