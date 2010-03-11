From: Chris Packham <judge.packham@gmail.com>
Subject: Re: re-running merge on a single file
Date: Thu, 11 Mar 2010 14:08:03 -0800
Message-ID: <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
	 <201003112129.52596.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 11 23:16:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npqg0-0005Rz-KW
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 23:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758379Ab0CKWQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 17:16:13 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44413 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758368Ab0CKWQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 17:16:12 -0500
Received: by pvb32 with SMTP id 32so198205pvb.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 14:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6hFXcGnwfLL5xE4qnMbajHMvz4AY58pGcmE1rSiRj5U=;
        b=c09JgWSwZo94yBxV/N/tbyGcFhQ0fk272pUuApfrqbG7m8dcceckNi/Bw6/vgNzp/R
         8qdEf1mXUhOv0b6Ceglm4mkgtjgrgI/i9hRQy/6UbEty39eJ/Xo6fL59SMl3qcYL/I1G
         K+GlmZPA32498gHzKwAxsyh2FIPwPOJ8Jsd3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Knc74C1/D5Ucb0/7/ez4eKeE7eIzGAzDSFDC2HPi5BHfadys6gGO0fL8DiNKHeY2MO
         hnxGpLJjYsZD6ApJAq4LRtTJdndEqPkAL5yEa4coEyTiRewByWu4vS3yK0Vn4KRh5gEg
         Hpj2P2WO0hsjBibpTXfx73KEcc1TGIMDLIlzY=
Received: by 10.115.84.9 with SMTP id m9mr1685996wal.193.1268345283584; Thu, 
	11 Mar 2010 14:08:03 -0800 (PST)
In-Reply-To: <201003112129.52596.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142003>

Hmm, having trouble with cat-file syntax

On Thu, Mar 11, 2010 at 12:29 PM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> Not mergetool, but checkout:
> git checkout --merge -- file

Ok.
$ git checkout --merge -- cpu/mpc83xx/start.S

> git cat-file blob :1:file > file.base
>

$ git cat-file blob :1:cpu/mpc83xx/start.S > cpu/mpc83xx/start.S.base
fatal: Not a valid object name :1:cpu/mpc83xx/start.S

So I think I have figured out that I'm trying to get at stage 1, 2 and
3 of the file that git checkout --merge has just setup but I'm
tripping over the syntax.

Also if it helps

$ git --version
git version 1.7.0.1
