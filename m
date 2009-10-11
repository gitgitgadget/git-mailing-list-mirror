From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Vcs-fast-import-devs] What's cooking in git.git (Oct 2009, #01; 
	Wed, 07)
Date: Sun, 11 Oct 2009 13:58:59 +0200
Message-ID: <fabb9a1e0910110458x430dd67co330ba5f5bd550f9c@mail.gmail.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de> 
	<fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com> 
	<20091008173900.GI9261@spearce.org> <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com> 
	<e48c5e540910110440k33e3d0dcp6d8c1480b5848366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	vcs-fast-import-devs@lists.launchpad.net, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matt McClure <mlm@aya.yale.edu>
X-From: git-owner@vger.kernel.org Sun Oct 11 14:53:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwxv8-0002XE-Ll
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 14:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760651AbZJKL75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 07:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757127AbZJKL75
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 07:59:57 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:39578 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823AbZJKL74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 07:59:56 -0400
Received: by ewy4 with SMTP id 4so1781873ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=peb5P87R/ieOI6pztzaP3MhaB9Usp6hPh2o471kZrZ4=;
        b=SBwWSaHLgENyNRysJBG0x/zrHaIG8iOC92aAaIku/oU7MZZ+ynCt1fNfXWybIw0gVD
         1GIN1+o/Yo7Vs0YBi2FZKyhKP5gKya3MrtYActbmSKiN+KWjUy8EUuNfqq2A902g7Hb4
         mI3+ICzjAwfQLMfkC820Eddjwf7UntAk7c058=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eofJeFA2/95CCJHXwUBBuFm2knWIgPRmuYzVcZUwrhMrTueXI7oC7dRI/pKEvG6X0S
         LEJhNvVztICeqdV2lwxFa0xcA+mu/dO4eAQik5liLXxzTpEPxzGHLvhvuP61qp/23WEf
         EEpAfuErSUuLnbOEAbbiu2zjtEkpUatQIblfY=
Received: by 10.216.91.10 with SMTP id g10mr1441849wef.217.1255262359239; Sun, 
	11 Oct 2009 04:59:19 -0700 (PDT)
In-Reply-To: <e48c5e540910110440k33e3d0dcp6d8c1480b5848366@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129917>

Heya,

On Sun, Oct 11, 2009 at 13:40, Matt McClure <mlm@aya.yale.edu> wrote:
> Who is the fast-output developer to say that only one fast-import tool
> should use his stream?

He knows that a foreign tool that does not heed his 'option git
stream-changing-option' will mis-parse the stream. For example the
Bazaar people were talking about adding some Bazaar-specific options
so facilitate bzr-bzr traffic, it would be impossible for a non-bzr
importer to properly understand the stream if they were to ignore the
bzr-specific options. So either options should only affect things that
do not change semantics (such as perhaps whether or not to be quiet,
whether to try and limit memory usage, etc), or it should be possible
to indicate that an option is changes semantic and cannot be ignored.

-- 
Cheers,

Sverre Rabbelier
