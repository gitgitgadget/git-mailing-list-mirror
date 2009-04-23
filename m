From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 15:45:46 -0500
Message-ID: <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org>
	 <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
	 <20090423201636.GD3056@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx5pZ-0005z8-BJ
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 22:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024AbZDWUpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757701AbZDWUpt
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 16:45:49 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:45467 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008AbZDWUpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 16:45:47 -0400
Received: by qyk16 with SMTP id 16so1542703qyk.33
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7iy3z8wFmn2LGwGKaFu2ALhNlwrOtL37dit3seR/l1Q=;
        b=yFjw3x0ED+5IF6rVU54w/FnOLIoluecRBTgoo3ZvxvNinUWs213Vc9LR8/lOXuG4R6
         Wx+ul+pj+2ukaeiJjEnAd+a3HlU43IbxxQwobpHuGaqzJw7fHC2WlsEDL+wYfcndjOfz
         8lfu3l5+oFvXDmSOqY2jq9AW+X5XfYfDwsKDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VFGQsJDU+XnvMcBogyT08YW+mJvEtP4X+9Nm8wBccSuxmRyObvCJaEaqZPgEK0Sets
         ZQR91fXlVFxSMqeujLfDltQisk9Vw5WhHAiiRTwydeWmshdeNVgdm5f7qOmrMP9JljI+
         7riOTan4ZAfGzAboXDpCdNyCiGg/U0NdooMjY=
Received: by 10.224.2.212 with SMTP id 20mr1918376qak.343.1240519546894; Thu, 
	23 Apr 2009 13:45:46 -0700 (PDT)
In-Reply-To: <20090423201636.GD3056@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117383>

On Thu, Apr 23, 2009 at 15:16, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 23, 2009 at 01:37:05PM -0500, Michael Witten wrote:
>
>> Everyone talks about "before one has the conceptual foundation
>> necessary to understand". Well, here's an idea: The git documentation
>> should start with the concepts!
>>
>> Why don't the docs start out defining blobs and trees and the object
>> database and references into that database? The reason everything is
>> so confusing is that the understanding is brushed under the tutorial
>> rug. People need to learn how to think before they can effectively
>> learn to start doing.
>
> I agree with you, but not everyone does (and you can find prior debates
> in the list archives). The user-manual is pretty "top down". There are
> some "bottom-up" resources available, but I haven't seen one pointed to
> as "definitive".I think it might actually be nice for there to be a
> parallel to the user manual that follows the bottom-up approach, and
> people could read the one that appeals most to them (or if they have a
> lot of time on their hands, read both and hopefully it makes sense in
> the middle ;) ).

I think the main problem, then, is that the tools have a UI that is
somewhere in the middle.

However, a discussion of blobs, trees, commits, objects, and
references isn't necessarily low-level. It seems to me that it is a
high-level understanding of the git world. Without those
*definitions*, people are left to their own wrong, inconsistent
thoughts.

The low-level stuff is HOW those concepts have been used in the
implementation of git: Where certain files are stored, how certain
bytes are organized in memory, what are the underlying porcelain
tools, etc. That what's low-level.

> But we would need somebody to volunteer to write it. I would be happy to
> help out, but I'm too short on time at the moment to be the driving
> force.

Maybe I'll try to write something, but it won't take place quickly,
either. I'd want to read ALL of the existing documentation first.
