From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 18:42:33 -0800
Message-ID: <1196995353.22471.20.camel@brick>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	 <20071205.204848.227521641.davem@davemloft.net>
	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
	 <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 03:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0TB7-0007HC-RI
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 03:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbXLGCmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 21:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbXLGCmk
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 21:42:40 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:37579 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbXLGCmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 21:42:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so520841rvb
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 18:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=V2t5Z1Iucw2rx5fh1MMn+qM0ykCygNmXuEtcq8qdYC8=;
        b=pnTSz8tP0Qo3ogUhJSMi1pJLtl/kR3McHMmafwzQjQ4TwVJ08/ZoNr0Clz+VTVzaVNOktld6HuxYpAOUZndWgUEnzxRQ2BSYxakgt1hKSTodDMOesy0TAIPR51djpMVY8Ohqs/HwKvN6qixX1gmZrW+P+IJFZ3SkDxUbiIbraj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Oh9pX5O8d/EDrSbVEqimgwc8CzPqURDUY70s9Kt0+UYl+rHQYrIryqbkmzGqdxuJn0KFUgvUcwFPlAfTGPruA8+henAN/FvPYpD3CFCs/dSMEZ1lN6yGevpUmvP+VeA390PSAAVRJm8gepGizbajWfIIA/UiaLezWS3Ajy7qRKk=
Received: by 10.141.107.13 with SMTP id j13mr2406125rvm.1196995359034;
        Thu, 06 Dec 2007 18:42:39 -0800 (PST)
Received: from ?192.168.1.124? ( [216.19.190.48])
        by mx.google.com with ESMTPS id b34sm159055rvf.2007.12.06.18.42.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Dec 2007 18:42:34 -0800 (PST)
In-Reply-To: <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67368>

On Thu, 2007-12-06 at 13:04 -0500, Daniel Berlin wrote:
> On 12/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > So the equivalent of "git gc --aggressive" - but done *properly* - is to
> > do (overnight) something like
> >
> >         git repack -a -d --depth=250 --window=250
> >
> I gave this a try overnight, and it definitely helps a lot.
> Thanks!

I've updated the public mirror repo with the very-packed version.

People cloning it now should get the just over 300MB repo now.

git.infradead.org/gcc.git


Cheers,

Harvey
