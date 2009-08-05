From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Merging to and from non-current branches.
Date: Wed, 5 Aug 2009 23:28:24 +0200
Message-ID: <81b0412b0908051428g40b7678ewc549f079abbd03ee@mail.gmail.com>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com>
	 <alpine.LNX.2.00.0908042236240.2147@iabervon.org>
	 <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: "lists@mgreg.com" <lists@mgreg.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYo2D-000592-7O
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbZHEV2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 17:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbZHEV2Z
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:28:25 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:58625 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbZHEV2Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 17:28:24 -0400
Received: by fxm28 with SMTP id 28so380923fxm.17
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pxk0lylTkxVQQZMObRP5Oi7lDJ7Gkc6tgp5e2adhF6w=;
        b=brsU24wIlX7Skf7Gmpdrlw9UiEvvZ8IXZtRyjsgsUVfjs4ZESehXcFloEFuC21YVfn
         NFmoU3XdJ2og7fnbpdyrSUxCq6xhbCQDX+PwjAxy/hsoMilJ2sdH+/Xv6oQTRPuRWkXL
         l2WmZfTlEv9PJ3aQhJ+ZmiA9qEntC+QqmImtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H4/eIMNp9b2N3EwN5jF5efE9B6hIubCQNyCuha0i+VTxQQW+WheaOzauRpl8mfWPFS
         FcsBBOPyoqoO8IU4S3KxCPixI+vzk0raM9nKxoJdC8zFY1zt8edr0Pt5WNQOFQ6IkVTB
         8i42XFnzJG0sIUERKceJgIvqn5P9w/TivPybU=
Received: by 10.204.59.145 with SMTP id l17mr1266324bkh.197.1249507704650; 
	Wed, 05 Aug 2009 14:28:24 -0700 (PDT)
In-Reply-To: <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124993>

On Wed, Aug 5, 2009 at 04:48, lists@mgreg.com<lists@mgreg.com> wrote:
> I appreciate your post. =C2=A0I understand what you're saying, and I'=
m not so
> much concerned about the logistics of what need to occur so much as a=
 single
> command to intuitively handle it. =C2=A0I've been doing a great deal =
of
> incremental development lately and it becomes rather tedious to have =
to
> checkout master, merge dev, re-checkout dev and proceed. =C2=A0I'm no=
t sure why
> this isn't currently possible with a single command.

Because no one needed this sequence of commands for long enough.

>=C2=A0I suppose I could write a shell script to do so, but that's a li=
ttle less "native"
> than I'd like.

But that's absolutely native to Git. Many Git commands are just shell s=
cripts!
Many guarantee (the "plumbing") you stability and machine-readability o=
f
their output precisely for this reason.

Write your script, propose it here, and there will be enough interest i=
t'll land
in the official distribution (or, more likely, in the "contrib"
directory of it).
