From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 14:26:17 +0100
Message-ID: <200704181426.29969.andyparkins@gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
	"Tomash Brechko" <tomash.brechko@gmail.com>,
	"Pietro Mascagni" <pietromas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 15:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeABG-0008JF-0m
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 15:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992448AbXDRN0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 09:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992456AbXDRN0h
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 09:26:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:7135 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992448AbXDRN0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 09:26:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so406930uga
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 06:26:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dovtJNij5Px3sM2hQQ5MuY52veNZzHT9Anoh2IBK5ZBGsIfxkQyL7KDWvcWqsNF403N639Br/tN1fijxwRo/whC6jq432JwrHMkUe7v6sB8gCKOJOvqSR24E4pUv6zA2daPGbTajjiifERhcJ8Af3USep15dFz2GbAMZ5NgdYIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JHWjBz70SKPIthB8oyEOKKNRBBiGh5T1mZvPtyogx+VzkFcrC8lh5YLg82F9UlCvyLboJzXIqIUYo8vOIM64CD/e/exurpgNF2Ui76G4kYN3SPVON+mxOFkpbQRk+SBSOV4p5JHlbEeyqFzDXEvYJxOPLtD0EE6rWN53sWB+qZA=
Received: by 10.82.175.2 with SMTP id x2mr766792bue.1176902795377;
        Wed, 18 Apr 2007 06:26:35 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y37sm624600iky.2007.04.18.06.26.33;
        Wed, 18 Apr 2007 06:26:34 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44894>

On Wednesday 2007 April 18 13:40, Guilhem Bonnefille wrote:

> An other point is that CVS/SVN actions for our developers are
> "trivial": update or commit, nothing more (even tags are made by

> In my mind, git-svn or even git-svnserve, are THE tools to introduce
> Git in teams not convinced by the power of DVCS. Or perhaps someone
> will create a porcelain that offers the same simple interface of
> CVS/SVN and will integrate it in all the fantastic IDE ;-)

It's already there.  The git porcelain can do almost anything.  If you were so 
inclined you could write a fake svn command that translated all those calls 
to git.

svn add = git add
svn update = git pull
svn commit = git commit -a && git push

I'm fairly convinced that the reason everyone thinks git is hard is because 
they're introduced to too much of it too quickly.

git /is/ easy.  It's more powerful, so there are more knobs, but if you don't 
want to use those knobs - don't.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
