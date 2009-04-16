From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: renaming remote branches
Date: Thu, 16 Apr 2009 09:09:17 -0400
Message-ID: <76718490904160609s1ef9c1e0m6f19ff169666fa3@mail.gmail.com>
References: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com>
	 <20090416065934.GA20071@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 15:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuRMj-0004kf-AU
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 15:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbZDPNJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 09:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbZDPNJT
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 09:09:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:19183 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbZDPNJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 09:09:19 -0400
Received: by rv-out-0506.google.com with SMTP id f9so396573rvb.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cdZnmZ6kGhzsAC0TCYSUCIp9sAZsY0FrAmSycDDwsOk=;
        b=xkUCRC18zhH80LekE2wfTY/GIEs1V6hTzt/RntBwrSc6n0DCHi8Xav23jCTK2ctgQd
         5pQjbkus3ArtF4PMuaSXnoVucQJ88PHNdKKmA1lvDHhc8PRNDKtsi5NjEtOyVFLE8WZB
         mLKoDPP+8AR6Se57meGg8gy3ElNseGj1fDG3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SyVxTt8aD2BX7myF2blCyZzRmOv/FGbhGfsZ3YUX1uDNSlg7JrUgPxjatXYuFMNKjg
         62GlJwF4bGAef/4sphrOlwJWceaF3dMvnglNYYwOkhjjgT/je7ME8iRwgrytOYclyUav
         pJv7DIYW8y2O0bZd+LsExDrYPSfj0vdNk8Vj8=
Received: by 10.140.187.10 with SMTP id k10mr795902rvf.29.1239887357981; Thu, 
	16 Apr 2009 06:09:17 -0700 (PDT)
In-Reply-To: <20090416065934.GA20071@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116697>

On Thu, Apr 16, 2009 at 2:59 AM, Jeff King <peff@peff.net> wrote:
> Not only is this not user-friendly, but it does not preserve any branch
> config or reflog at the remote (both things that "branch -m" does).

I wonder whether we should:

a) teach git remote a rename-branch sub-command
b) add support on the remote side for properly preserving the config and reflog

Thoughts?

j.
