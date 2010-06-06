From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sun, 6 Jun 2010 19:34:11 +0200
Message-ID: <AANLkTinjp8fprN0KkY-z8VuTXM4A1_VXPGVaUAs46qjX@mail.gmail.com>
References: <20100605110930.GA10526@localhost> <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com> 
	<20100605135811.GA14862@localhost> <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com> 
	<20100606161805.GA6239@coredump.intra.peff.net> <20100606165554.GB10104@localhost> 
	<AANLkTinTI3XaE6P_WZ_k56fgI4LNOLSalv_1GlVZNO7n@mail.gmail.com> 
	<20100606173233.GA11041@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Helwig <jacob.helwig@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jun 06 19:34:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLJk6-0002Dp-3t
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 19:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136Ab0FFRed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 13:34:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50304 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757821Ab0FFRec (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 13:34:32 -0400
Received: by gye5 with SMTP id 5so1812414gye.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=rYSWCAv8wFN0cHmA0G1PtQCg2AjqXNDjNe8sSWGlDdA=;
        b=aNtb1qT/LKVJwJmt0/5XYE8679OGM2gK7CpRQLI9GxPNJGvpUhazOPapeeoZ4q9BNt
         xCrHXCcgI2+Srmpcbg6LFziumfXY3ekgImGBpjq/jOh3IH42mD9kBniFKd4Zv7Rj2r9n
         8d/v4AKZw0vhhv2NxFOqii9f4iMY81UxCpHIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YzVrxjmjKAd4giw++0jj++ixqPDm33/LeKwH8z4ICQil9FcXf3K4ddebwaYQFfRLh7
         nk7ukBeZRKIxrQ/QGyPvDMrYyBrpUmejt3PZw06rlOoAZJHKJN0uHKLFJuZsx5xfhzYD
         6i7DMBWidJlB8TnQun88wFRPvynwq2AUQv4Jk=
Received: by 10.151.18.38 with SMTP id v38mr12797082ybi.420.1275845671114; 
	Sun, 06 Jun 2010 10:34:31 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Sun, 6 Jun 2010 10:34:11 -0700 (PDT)
In-Reply-To: <20100606173233.GA11041@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148529>

Heya,

On Sun, Jun 6, 2010 at 19:32, Clemens Buchacher <drizzd@aon.at> wrote:
> Also, isn't this more like "foretell what I really want" rather
> than "do what it means"? Who would guess that "git checkout
> $branch" means "create $branch tracking <random-remote>/$branch"?

Note that DWIM stands for "Do What I Mean", not "Do What It Means".

-- 
Cheers,

Sverre Rabbelier
