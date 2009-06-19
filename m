From: David Aguilar <davvid@gmail.com>
Subject: Re: visualise the output of git-diff?
Date: Thu, 18 Jun 2009 22:47:31 -1000
Message-ID: <20090619084731.GB46896@gmail.com>
References: <200906190732.24455.Karlis.Repsons@gmail.com> <87r5xgpsnr.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?K=C4=81rlis?= Repsons <karlis.repsons@gmail.com>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri Jun 19 10:47:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHZlA-0008I7-VA
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 10:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbZFSIrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 04:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZFSIre
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 04:47:34 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:39379 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbZFSIrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 04:47:33 -0400
Received: by wf-out-1314.google.com with SMTP id 26so797806wfd.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MhMmDZr4DExL6cf6PxlVOnVFuem4KPMcSvxuEz1JFbg=;
        b=JM8/3iFCORMiDlv2Xs2cqFT5wLwcgmqyxWp+oDZPoZYbjKGxyJmFT2NWKPtdpGuhf8
         1ieDX0u4wn7z+FznZlYxEJ0t4qzNieMi9WVDUAeb3h2jOC95sBAPpdj2RWSrc3H5TjUj
         KJ8zH9qvJh39YErIXzPnKpGvwLnfh6wouAFro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Q902K+WDsfREDk8lwY8qQjZYvQQ2Q8C9HxpHCJsTW/atM4CjfzpPLAhubcxIG/pFvc
         CeT8eHx8ec6jGvxvSuKfml0PuwwnJKryohG7X122pbAJ7g4UwGq5MXXJgO2myxTDj6f5
         kG7h1pYeMUGE0oa6vORer8iLrtABB+mIe0CG0=
Received: by 10.142.174.20 with SMTP id w20mr1304774wfe.285.1245401255688;
        Fri, 19 Jun 2009 01:47:35 -0700 (PDT)
Received: from gmail.com ([66.37.169.172])
        by mx.google.com with ESMTPS id 28sm238743wfg.5.2009.06.19.01.47.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 01:47:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87r5xgpsnr.fsf@iki.fi>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121889>

On Fri, Jun 19, 2009 at 10:52:08AM +0300, Teemu Likonen wrote:
> On 2009-06-19 07:32 (UTC), K=C4=81rlis Repsons wrote:
>=20
> At least there is "git diff --color-words" but it may not be what you
> want.
>=20
> > And about pager - are you people all using less or there are also s=
ome
> > non-console viewers available?
>=20
> I mostly use "less" but sometimes also "kompare" which is excellent:
>=20
>     git diff | kompare -

And of course.. don't forget about git-difftool =3D)
http://kernel.org/pub/software/scm/git/docs/git-difftool.html

	$ git difftool -t kompare
	$ git difftool -t diffuse
	$ git difftool -t xxdiff

The quality of the visualization is only limited by the quality
of your difftool.  We support lots of them.  From the docs:

"Valid merge toosl are: kdiff3, kompare, tkdiff, meld,
xxdiff, emerge, vimdiff, gvimdiff, ecmerge, diffuse,
opendiff and araxis."

Like mergetool, difftool has an extension mechanism in case the
built-ins are not sufficient.


Have fun,

--=20
		David
