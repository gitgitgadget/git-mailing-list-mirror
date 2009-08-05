From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Merging to and from non-current branches.
Date: Tue, 4 Aug 2009 20:46:04 -0700
Message-ID: <fabb9a1e0908042046w174d2591n2d9502d81a795d3a@mail.gmail.com>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com> 
	<alpine.LNX.2.00.0908042236240.2147@iabervon.org> <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: "lists@mgreg.com" <lists@mgreg.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 05:46:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXSU-0005Bi-Do
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 05:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbZHEDqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 23:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbZHEDqZ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 23:46:25 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:63038 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbZHEDqY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 23:46:24 -0400
Received: by ewy10 with SMTP id 10so832692ewy.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 20:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2kdxo16Hnq2rFTRWOhPZJBq4BFx+lQJE1T3vweFVX5o=;
        b=Ut1i32vu7IrldfH/DzGnY3sudPUDyt7OeCHm3F6wsLz3jfIdU0H/STrWolBTsMvrER
         oD/M1p9Nd/2reoz3gv3JFBwHhSKNGYRb7ZFrTYdj9pM40OXW+08L3ZTCLoNdeDVnnQ11
         6mdDlpPUssJaXYxY1GbaRzhQN0FwrgxbRrXRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sqFgg4gA4UN5X+HsJiihResLVVjdqfv01QanL1O9RmHuN8t7vr8sEc7lAHovy8Kg9u
         ++tO8G9t6l0UdKzfikKZ3yvjgSd6mmGF4r+BQ+Io8oyGe4lnXhdRXkjHrJ+4k0tHkMM7
         sOMGNXPzF3ZMu3Snru1m+PlClrTA/UR6SFNn0=
Received: by 10.216.91.15 with SMTP id g15mr1589341wef.24.1249443984103; Tue, 
	04 Aug 2009 20:46:24 -0700 (PDT)
In-Reply-To: <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124847>

Heya,

On Tue, Aug 4, 2009 at 19:48, lists@mgreg.com<lists@mgreg.com> wrote:
> I appreciate your post. =A0I understand what you're saying, and I'm n=
ot so
> much concerned about the logistics of what need to occur so much as a=
 single
> command to intuitively handle it. =A0I've been doing a great deal of
> incremental development lately and it becomes rather tedious to have =
to
> checkout master, merge dev, re-checkout dev and proceed. =A0I'm not s=
ure why
> this isn't currently possible with a single command. =A0I suppose I c=
ould
> write a shell script to do so, but that's a little less "native" than=
 I'd
> like.

You might want to try out an alias:

$ git config alias.update "!git checkout master && git merge dev &&
git checkout dev"

--=20
Cheers,

Sverre Rabbelier
