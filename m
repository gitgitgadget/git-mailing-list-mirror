From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: git-svn intermittent issues with absent_file
Date: Sat, 29 Aug 2009 22:35:24 +0100
Message-ID: <efe2b6d70908291435w7d607151g370717ba2e034a2c@mail.gmail.com>
References: <op.uzbs4bsq3myrm3@balu.cs.uni-paderborn.de> <20090827191902.GA3185@dcvr.yhbt.net> 
	<op.uzc1njug3myrm3@merlin.emma.line.org> <op.uzc46sm43myrm3@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@uni-paderborn.de>
X-From: git-owner@vger.kernel.org Sat Aug 29 23:35:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhVaO-0000BR-VL
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 23:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbZH2Vfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 17:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbZH2Vfn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 17:35:43 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:61205 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbZH2Vfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 17:35:42 -0400
Received: by ewy2 with SMTP id 2so3036625ewy.17
        for <git@vger.kernel.org>; Sat, 29 Aug 2009 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=yNXRSY7Md4L3hsJlC3ToRc6e7Nj4DU+OkqsK7d3MCrQ=;
        b=bHcWbDPGvk89//vPvB8+15Bi3t7oIJ86m7zN+5eeutXE1K2FqX54otk66v28mkQKIa
         khgjtQT9nczU/lK8Uvr4G66aHLCgzVQYopZ6mjZgvYXOUAewda90q6oYvFxQ7r5sjHxL
         yOQ9KflluhpaTXuTBvPxPs81roSvnEqiTD7xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Zjls2/ygpCZcUmY8OSP5b6gozVuy6AoimobDI12VzlnSYJw/AEMtLNWgK+41Ovod0f
         aRw2QgaBpeH21jZG5r8kgKtvKhDKCB6gBzSe07ES8aUoUvEr10ziT0DQiX6kzckA9YDb
         v/IwaNEevNsbMGUhVVUw9hSXxupxWSFsqIvwc=
Received: by 10.216.25.144 with SMTP id z16mr604832wez.179.1251581744101; Sat, 
	29 Aug 2009 14:35:44 -0700 (PDT)
In-Reply-To: <op.uzc46sm43myrm3@balu.cs.uni-paderborn.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127384>

On Fri, Aug 28, 2009 at 9:14 AM, Matthias
Andree<matthias.andree@uni-paderborn.de> wrote:

> So, the common idea set is apparently down to (a) intermittent server issues
> (I've asked for the relevant log excerpts) and (b) Cygwin issues, and we
> should keep in mind (c) git-svn, or svn bindings/libraries, losing the
> causes error conditions from (a) or (b) and git-svn just reporting later
> symptoms (absent files). More on the other experiments once I get around to
> them.

Won't help if it's a server issue, but if your suspicion towards
git-svn (or anything else you have the source for) increases, it may
be worth trying bbchop:
http://github.com/Ealdwulf/bbchop
That is like git-bisect, except it can cope with intermittent bugs.

Ealdwulf
