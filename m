From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Initial manually svn property setting support for git-svn
Date: Wed, 16 Sep 2009 13:18:50 -0300
Message-ID: <a4c8a6d00909160918r77e418dbpe8debeff58d595c9@mail.gmail.com>
References: <1482075216.1261253084509966.JavaMail.root@klofta.sjsoft.com>
	 <1927112650.1281253084529659.JavaMail.root@klofta.sjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Moore <davidm@sjsoft.com>
To: David Fraser <davidf@sjsoft.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 18:19:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnxDj-00053F-4I
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 18:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933512AbZIPQSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 12:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933507AbZIPQSt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 12:18:49 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:19638 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933469AbZIPQSs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 12:18:48 -0400
Received: by an-out-0708.google.com with SMTP id d40so11173153and.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9CB1IhX26pPRkB3aZFsuCk/s4uoV38hcwDYQpg8A3KM=;
        b=xBvp18pXi1pRsqpu59mdE4twmgjk2JL84cMo8Up2PifMcAs9SInOAGyaHmi42KZswG
         gNmNy9/zDq2OgQSgEQ3HbCjE7X+wEDNIUg9ivG4Ml78dc79yaknazjl5ly5VWu/uI+pJ
         IcAiBwcIfLbXANoLnq7Gni3pdU1S+A8X9azIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nBSRLq4kjwZzXMK13ykZNLlWpI3xWSUbpF0a8Hoyj+W2XCEa+vQsye+hgXcOsW6ucJ
         C9VBlQxspTDWGki3jwpB2oF+xO1wcskdioocHRV8sKzRwnCtEtMGjiq4/J/DWCPE3XDH
         NuNqDKRTcRj7X0DFzxW28ZR7MHc94yEcmjvOc=
Received: by 10.101.59.5 with SMTP id m5mr9118850ank.67.1253117931552; Wed, 16 
	Sep 2009 09:18:51 -0700 (PDT)
In-Reply-To: <1927112650.1281253084529659.JavaMail.root@klofta.sjsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128661>

On Wed, Sep 16, 2009 at 4:02 AM, David Fraser <davidf@sjsoft.com> wrote=
:
> This basically stores an attribute 'svn-properties' for each file tha=
t needs them changed, and then sets the properties when committing.
>
> Issues remaining:
> =A0* The way it edits the .gitattributes file is suboptimal - it just=
 appends to the end the latest version
> =A0* It could use the existing code to get the current svn properties=
 to see if properties need to be changed; but this doesn't work on add
> =A0* It would be better to cache all the svn properties locally - thi=
s could be done automatically in .gitattributes but I'm not sure everyo=
ne would want this, etc
> =A0* No support for deleting properties
>
> Usage is:
> =A0git svn propset PROPNAME PROPVALUE PATH
>
> Added minimal documentation for git-svn propset
>
> Signed-off-by: David Fraser <davidf@sjsoft.com>
> ---
> =A0Documentation/git-svn.txt | =A0 =A05 ++
> =A0git-svn.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 95 +++++++++++++++++=
+++++++++++++++++++++++++++-
> =A02 files changed, 99 insertions(+), 1 deletions(-)
>
David, please read this, line 28:
http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3DDocumentation/Submi=
ttingPatches;h=3D76fc84d8780762e083cd4ca584b9d783b8c0cd81;hb=3DHEAD

Patches need to be send as plain text, not attached.
