From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Wed, 4 Nov 2009 07:41:28 +0100
Message-ID: <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com> 
	<fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com> 
	<1257295737457-3942366.post@n2.nabble.com> <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com> 
	<1257315478920-3943388.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 07:41:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ZZ5-0001gG-4o
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 07:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbZKDGlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 01:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbZKDGlo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 01:41:44 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:48785 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZKDGln (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 01:41:43 -0500
Received: by ewy3 with SMTP id 3so2789449ewy.37
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 22:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fiLs4gPkj2kwxzKX1OsfV7q4ollau8Yif1fSpL7IoYY=;
        b=CjnE/nrK8rj37E/gIdCI7GC35zX/NtozVFVJTTCFJ0xkLDsRLM4YAnIhJ853a7q1DZ
         sIl8HZyLYhnTniYVq5453vFX86z22UHJgFbOjJ6soifOKMaSUfqrYdgEhuYvd7ealK3y
         FgCnkBaxyDYlXjNPFaNSMGF+OxIqgJmGqgRIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sjZWDifaEd33Ed58fw5Bq9uWSVaLVhAkS+gZ21l/whyQgaqmYNlOSOIbA4p0OsXXfD
         sJyxdIT1RClYxbFBxIz8AvJbZn6vBrOfvtw0zNltuHxWxkbDiObWvbG0fFie3/mhjl0T
         TBPzHoCGMbFjYR8a84SsvXsL0idr9QJ6vkZDs=
Received: by 10.216.87.9 with SMTP id x9mr402959wee.0.1257316908162; Tue, 03 
	Nov 2009 22:41:48 -0800 (PST)
In-Reply-To: <1257315478920-3943388.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132045>

Heya,

On Wed, Nov 4, 2009 at 07:17, Tim Mazid <timmazid@hotmail.com> wrote:
> So instead of invoking 'git checkout REMOTE/BRANCH', do 'git checkout -b
> BRANCH REMOTE/BRANCH'.

Automagically doing 'git checkout -t remote/branch' when asked to do
'git checkout remote/branch' was suggested earlier on the list and I
think there was even a patch that implemented it, not sure what the
outcome of the series was. I do remember that Peff was annoyed by it
at the GitTogether though so it might be a bad idea.

-- 
Cheers,

Sverre Rabbelier
