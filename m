From: "Thanassis Tsiodras" <ttsiodras@gmail.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 13:28:44 +0200
Message-ID: <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
	 <m37i7pggnk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 12:30:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvsCY-0003Iy-Lg
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 12:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbYJaL2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 07:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbYJaL2r
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 07:28:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:34802 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYJaL2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 07:28:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1012612fkq.5
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lClxGwJNpKn3qBbeaJtQDsf2tTwuvbCZ1YxxLXpOuyU=;
        b=dFxmpR0Hb4T0qkEMOnOZ6Crzc1WwuNP+PDr+pzI13QlKzcqRSSSAP4H9Zbnq7lOAlA
         XOnQs3+E3tTOWuVIt4qu3avTvqjBJFtgb/wDPi5QxnvvnetT3/he9+ObWZs3vFVBpK4O
         5hcanUBsYd4xoEkl8aawnm0W5/1dj/HElkmAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VA7QaPkOJm3HEGZeqXOO0YQq4cij3rLCd4pOFS8LcsyIx3BpHlQGZN+CvPPslLa14a
         6h1bawtAL5KYo/3NfdPVgy5RfQzl0cUt6LyhOMR5d/7AfWSQOZUmOatBP1nNI5MjRkxL
         0NZP+1FuSRmF/mI+CsTp5k/tRlP5ojTcnGzNw=
Received: by 10.181.197.6 with SMTP id z6mr3034854bkp.119.1225452524787;
        Fri, 31 Oct 2008 04:28:44 -0700 (PDT)
Received: by 10.181.5.13 with HTTP; Fri, 31 Oct 2008 04:28:44 -0700 (PDT)
In-Reply-To: <m37i7pggnk.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99578>

On Fri, Oct 31, 2008 at 1:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:

> I think you can use clean / smudge filter in gitattributes for that.

Thanks, I didn't know about that. Will look into it

> Git does deltification _only_ in packfiles. But when you push via SSH
> git would generate a pack file with commits the other side doesn't
> have, and those packs are thin packs, so they also have deltas... but
> the remote side then adds bases to those thin packs making them
> standalone: you would have to git-gc on remote.

So I have to git-gc on my side (after the commits), git-gc on the remote,
and then git-push?

What I gave, I have; what I spent, I had; what I kept, I lost. -Old Epitaph
