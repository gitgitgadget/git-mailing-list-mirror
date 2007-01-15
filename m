From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 19:23:05 +0000
Message-ID: <200701151923.07493.andyparkins@gmail.com>
References: <200701151000.58609.andyparkins@gmail.com> <200701151141.51659.andyparkins@gmail.com> <46a038f90701151036k7b9ee5e2sdd3bbf6d69f9a27c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 21:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6XTX-0000aD-ET
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 20:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXAOTZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 14:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbXAOTZ7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 14:25:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:2087 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbXAOTZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 14:25:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1444784uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 11:25:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BioMwW8pJri36AyVdzu7vYAzj+2oniFjHDSb/Dj9zF5lnQefuEtsux59Ke24TLReI1CuqjcWjUY7LeKnm9FtP1nrzVwfrLagxf5AQcV/LXDL1FsrTnFTdmOROWG6B3EpZA2szvgDA4IV1MtRBWDIWvtOdzZFuIZhvLNPoO5dFlw=
Received: by 10.78.149.15 with SMTP id w15mr2649768hud.1168889154123;
        Mon, 15 Jan 2007 11:25:54 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 32sm5216853hui.2007.01.15.11.25.52;
        Mon, 15 Jan 2007 11:25:53 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <46a038f90701151036k7b9ee5e2sdd3bbf6d69f9a27c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36877>

On Monday 2007, January 15 18:36, Martin Langhoff wrote:

> >  * Vandal spends one year developing reasonable relationship with Idiot,
> > all patches are good.  Occasional big patches are pulled by Idiot.
>
> If you are using signatures, the trojan horse would make sure he gets
> his patches signed. What is the advantage again?

He can't sign it as someone else, and so when it is eventually discovered the 
culprit can be hunted down and flogged.

> IIRC Linus discussed this early on, and his view was that authorship
> only gives you false security. The only security is in reviewing code.
> And that the code-signed patches are dog-slow too.

Eh? It's only a little bit of extra text to carry around.  It's signed by the 
original author when it enters a repository, so it's not a huge price to pay 
in any one place.  The checking, if you wanted to enable it, would only be 
done once per incoming commit to a master repository.  All-in-all, nothing 
that you wouldn't be willing to pay if you wanted this feature.

As an aside; I would also suggest that this isn't just about people trojaning 
a commit.  You could also argue that without it, this whole Signed-Off-By 
business is a bit a moot point.

The signed-off-by lines in the kernel are being used to establish original 
authorship and entry path of every line in the kernel.  It's fairly worthless 
though when the "signing" is just someone writing an easily forged line of 
text.  For example, what is to stop that naughty lad Linus from adding some 
code the infringes a copyright to the kernel and adding a "Signed-Off-By: 
Martin Langhoff" to the bottom?  Equally, when SCO come knocking with 
their "we wrote that line", a secure digital signature chain would go a long 
way to proving that a submission wasn't faked.

I'm not sure how far commit signing would go towards preventing that, but it 
could certainly be part of the solution.  Commit signing doesn't have to be 
all about trusting developers, it can be about recording history in an 
independently checkable way.



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
