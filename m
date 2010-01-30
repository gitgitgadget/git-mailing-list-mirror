From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: migrating to git: keep subversion revision numbers (as tags?)
Date: Sat, 30 Jan 2010 15:36:14 -0800
Message-ID: <8c9a061001301536g1a990881qa27ba681ee90c6eb@mail.gmail.com>
References: <20100130230829.GA3544@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "fkater@googlemail.com" <fkater@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 00:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbMrq-00017U-94
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 00:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab0A3Xgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543Ab0A3Xgf
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 18:36:35 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:65259 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab0A3Xge convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 18:36:34 -0500
Received: by pxi12 with SMTP id 12so2901158pxi.33
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 15:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cgeB2mgIgVSM/LKt9jTkfOhgOCRu5ogJH1chZE/ALfs=;
        b=nuONEjTQdlG3NkGCzw9Omr96N1zMqTYyyO8rdnhm6m+IvcuAauQ/C4mC+0e/PG9wVS
         bRx+32UNgmfhJUx8sphSiqw6xgZGNx85gDF3SX3gUxPlPe8s27FZ6XCnfR4OsNQWbC4o
         QmKHWXtAYksWA4Zk4oYml42mL30o69v6kWUdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YJOViZgE7owbsDksc3Qff4cFdvKIySoJTw9tfaq00j/dPw7QWv8eJf3ct2sHSVcYb0
         TS/G4NVci37RTmfQghwu9VIBPZtk+3UVV5TLDshKgb+HUVktCIhOmaZd28gJfkexJcpw
         Yc9dIc49HD9riOVWqsn9BYvE4+m01qYralpCQ=
Received: by 10.141.90.5 with SMTP id s5mr1831067rvl.81.1264894594534; Sat, 30 
	Jan 2010 15:36:34 -0800 (PST)
In-Reply-To: <20100130230829.GA3544@comppasch2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138520>

On Sat, Jan 30, 2010 at 15:08, fkater@googlemail.com
<fkater@googlemail.com> wrote:
> Hi,
>
> I would like to completely migrate from subversion to git
> (and NOT have subversion enabled anymore). However, I need
> to be able to lookup the old subversion revision numbers
> later from the git repository. The default seems to be
> though, that they are replaced by git sha-1 keys.
>
> It would be completely o.k. here to use git tags for all
> those subversion revision numbers (if possible), so, to
> create a tag for each subversion revision. However, I have
> neither seen any option in git nor found a script which does
> that upon cloning (converting) a subversion repo into a git
> repo.
>
> Is there a way to do so?
>
> Thank You
> =C2=A0Felix
>

There's not really any need to tag every revision with the SVN
revision number.  If you use svn-all-fast-export, or git-svn to do the
SVN -> Git conversion, then the SVN revision numbers will end up as
part of the commit message when it is in Git.

-Jacob
