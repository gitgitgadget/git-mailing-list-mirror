From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How it was at GitTogether'08 ?
Date: Sun, 9 Nov 2008 17:31:47 +0100
Message-ID: <200811091731.48694.jnareb@gmail.com>
References: <200811080254.53202.jnareb@gmail.com> <200811081631.06229.jnareb@gmail.com> <200811091636.55343.kai@samba.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tim Ansell <mithro@mithis.com>
To: Kai Blin <kai@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 17:33:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzDDt-0006LB-Mz
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 17:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbYKIQb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 11:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755267AbYKIQb4
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 11:31:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:34672 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbYKIQbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 11:31:55 -0500
Received: by ug-out-1314.google.com with SMTP id 39so205801ugf.37
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nMiAtojXO+E0UiNphVYRW6lA8uMickORzgHUUlBqxsc=;
        b=Nx3RIwJQ5Sj3yR/4Xvu+97kVsq7M4T1YG6jY7bmxpJ0l22O2ilC82/nLAKu4e5Ycwe
         95WGJQbC5IADGQ2c9MGgU/22bqfnMNEd/RYQQuNNfCZwngUVLa2V4htbLfzqsspO1PSd
         UORgy7IGAtKQUskCYi7WrgQiJUPBNhJTtcT8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tHLI+LNWe3+ShYZ7DrMNlds89OgDeklLna21PwPRYzuwQSOC1OX6BkhQet3XccM3rS
         j2bIZoR1vulLYCLdqU/+p3HWGrYLK1p5swHutOAe38PhwD6l8dlWfFtvYe89M9XZMyUL
         ixElmlw2GwW6GhUfU/SVn7iLX+dr/3WRBPpRo=
Received: by 10.210.92.8 with SMTP id p8mr6644628ebb.101.1226248313848;
        Sun, 09 Nov 2008 08:31:53 -0800 (PST)
Received: from ?192.168.1.11? (abww18.neoplus.adsl.tpnet.pl [83.8.246.18])
        by mx.google.com with ESMTPS id 7sm8625444eyg.0.2008.11.09.08.31.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 08:31:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811091636.55343.kai@samba.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100455>

On Sun, 9 Nov 2008, Kai Blin wrote:
> On Saturday 08 November 2008 16:31:04 Jakub Narebski wrote:

>>>> * Tim: Git as a Media Repository
>>>>  http://www.thousandparsec.net/~tim/media+git.pdf
>>>
>>> This has kicked off some mailing list discussion; I think this can be
>>> a major weak point for git, since checking out only a subtree (and
>>> only the latest revision) is the common SVN way, which copes with
>>> media repositories and the like just fine.
>>
>> Well, you can workaround this weakness by (ab)using submodules...
>> ...and one should always remember that casual partial checkouts
>> interfere a bit with whole-tree commits.
> 
> Interesting. How would you use submodules to work around the fact that binary 
> file changes diff very bad and produce huge histories with basically no value 
> for the user of the working copy? Can you do this from a GUI, easily? We're 
> talking about media repositories here, so our users are artists.

What I meant here (but perhaps was not clear) was (ab)using submodules
to allow to have full working repository without large [media] files
both in object database (repository) and without them checked out.

The workaround is to put all large files for example in 'media/' folder,
and make this folder be submodule. Each clone of repository can have
this 'media' submodule either present (both in object database, although
usually separate from main project object database), or not present
(not cloned and not checked out).

As to submodules UI and GUI support for submodules... currently it is
unfortunately lacking.


Note that I explicitly mentioned that (ab)using submodules to better
deal with large files is _workaround_, and not _solution_. Lazy clone
in version proposed by Tim is IMHO correct solution.

P.S. Could anybody document at last `delta' gitattribute?
P.P.S. You can have separate diff driver for binary files, but I don't
       know anyone who uses for example some such for images...
-- 
Jakub Narebski
Poland
