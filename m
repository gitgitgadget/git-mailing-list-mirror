From: Patrick Grimard <pgrimard@gmail.com>
Subject: Delete particular file contents from complete history
Date: Wed, 9 Dec 2009 13:01:17 -0500
Message-ID: <9cdb17250912091001u362ce64fybe3d554304cbc445@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 19:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIQqr-0006Zi-K7
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 19:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438AbZLISBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 13:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756428AbZLISBM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 13:01:12 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:50827 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420AbZLISBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 13:01:11 -0500
Received: by fxm5 with SMTP id 5so7838274fxm.28
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 10:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=lNFuGVYawcNTpWoMSiBXBOT+eeE6Sy4NJtHtkreAyb0=;
        b=egyOVVmIMTJvas/xYmrGRVn6XY/xPd5EQve0d7GhPsEAXXAUvAbV2FOGgkHgdiMPpl
         DpV0tNZBmZEfWJfGWVTXvlXsyNv8qDO5yehJEhBfYxYOTVBnbO8i7HaSgXsHGur6SLXI
         a9VDMtviLWWhQpG6jpa9YkoHcCnmwCuHA8c9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=edJezU0Muggnk+G2Dd70luWhLHUUrO+JJjq4GNnDG+67/RSiCW8tnLz0CwvxXwbxWO
         CoNQQkQIWfBCfXhWzVJmDL40FIIs9tnrqzZfgjpnrDadvJvb3LCFXi2bozX0b0NpUH4S
         TGMhvM7fyv1n0vyLJ9ew1wkq37Lpl0R9HlerY=
Received: by 10.223.92.131 with SMTP id r3mr2031815fam.40.1260381677247; Wed, 
	09 Dec 2009 10:01:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134990>

Is there some way to remove from the entire history a particular
file's content?  So for example I did an initial commit which
contained a file I didn't want in the commit and since then I've
committed further changes to the project, even started a branch to
experiment with some additional features.  I don't want to lose any of
my new commits or branch, just want to remove a particular file's
content from the entire history.

Thanks.
