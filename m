From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 18:13:55 +0200
Message-ID: <fabb9a1e0905200913u5252973aia9a20983b20243d3@mail.gmail.com>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home> 
	<20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home> 
	<025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com> <alpine.LFD.2.00.0905200853010.3906@xanadu.home> 
	<96BC1064-EEEF-48BC-B79A-9D15C517CF47@wincent.com> <alpine.LFD.2.00.0905201144040.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Nicolas Pitre <nico@cam.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 20 18:15:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6oRZ-0001GL-CF
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 18:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbZETQOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 12:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755312AbZETQOP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 12:14:15 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60071 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbZETQOO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 12:14:14 -0400
Received: by fxm2 with SMTP id 2so522859fxm.37
        for <git@vger.kernel.org>; Wed, 20 May 2009 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mqR9HTDsKgnPfVIFM+La5A0g3si8PU+skkjYIc/i9tE=;
        b=RYihY4O1i5NiPnHE0ErlwtGhC+ndlKJfhxnv3XY/GzNHuaZpvZtstEVGcFagi6DPeu
         4qNKZRYsWSXpG3A3ARI0qbVHGxJCS6qyv6uZ9a0gvIFtWi875oJKQzJET7ivUxV4uXP1
         sMLHA5tJ+Ril1aZwDwSzrdM+JGDCj/c+poFMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d5R11URqfo2gdDJWyDKzmz5054UmxFKvrj09EmEajdVN+V4YlrT5S43xd5uqqoEWGh
         esxTERgo5uxzHxYhkpXq5gnzYaDwkQYqxG2FzfNhXW8FHJrsPr996GafNmE5GpDJIhrn
         za2ptGJzPQII2s0hdQOYKnHt4cWIDAesWdZWY=
Received: by 10.103.117.9 with SMTP id u9mr814579mum.55.1242836055122; Wed, 20 
	May 2009 09:14:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0905201144040.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119618>

Heya,

On Wed, May 20, 2009 at 17:47, Nicolas Pitre <nico@cam.org> wrote:
> [...] _then_ it is worth adding a reflog entry for the otherwise about to
> be lost state.

On that note, the usefulness of such a feature is dependant on the
support we have for actually restoring an entry from this new reflog.
The current reflog is so amazingly useful because git has
awesome-cherry-pick-and-the-like-commit-handling powers that make it
easy to restore the otherwise lost state. But as far as I know,
there's no nice 'n easy support for restoring state to the information
contained in this new reflog, is there?

-- 
Cheers,

Sverre Rabbelier
