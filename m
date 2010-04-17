From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Git import of the recent full enwiki dump
Date: Sat, 17 Apr 2010 03:10:56 +0200
Message-ID: <y2h2d460de71004161810p2c331099q4b2d7dabd01e5f8@mail.gmail.com>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com>
	 <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 03:11:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2wZ7-0005CY-UA
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 03:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687Ab0DQBLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 21:11:00 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:42868 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722Ab0DQBK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 21:10:59 -0400
Received: by bwz25 with SMTP id 25so3753700bwz.28
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=nwtmY1SXM+p9UeVZBzoV4aQyDRyauiJ6rRMjXDWfWJY=;
        b=fIcBGaYyEAGp7FFPjDK/Q6tyK0jlP71CywXA74hpHZp9op8T0IHsAWgQXHBcvozEOr
         99FqHEhZ+w1mkklrXs33w5nziOdrKsH7uLiXtSyhsRnsUWCG7G0VNITXoxHKANxGiKFW
         zPH7nPBLu8hPt8khoFSoInirmpnTCeHYdxf5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wIvNo7HbJxQ7gS0wZiqDZgw/KwlKR3Pd9Y14OasnkyAr3XSFxbSnIWg6l5zzMuK1yo
         ux5OF1IOxdmRDlroGTSe9og2Z3CJ36K02iEQcyuQSH1/YD7dhiGSaKROFxQXwNxEzlHr
         /rjrA8CoLSwvbxnY0lpENu+1DFMWi2PDmkuxg=
Received: by 10.204.73.77 with HTTP; Fri, 16 Apr 2010 18:10:56 -0700 (PDT)
In-Reply-To: <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com>
Received: by 10.204.137.81 with SMTP id v17mr2385151bkt.93.1271466656216; Fri, 
	16 Apr 2010 18:10:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145103>

On Sat, Apr 17, 2010 at 02:19, Sverre Rabbelier <srabbelier@gmail.com> wrote:

> Assuming you do the import incrementally
> using something like git-fast-import (feeding it with a custom
> exporter that uses the dump as it's input) you shouldn't even need an
> extraordinary machine to do it (although you'd need a lot of storage).

I am using a Python script [1] to import the XML dump.


> Speaking of which, it might make sense to separate the
> worktree by prefix, so articles starting with "aa" go under the "aa"
> directory, etc?

Very good idea. What command would I need to send to
git-fast-import to do that?


> Hope that helps, and if you do convert it (and it turns out to be
> usable, and you decide to keep it up to date somehow), put it up
> somewhere! :)

It did.
I will make it available if it turns out to be useful. Keeping it up to
date might be harder unless they keep on releasing new
(incremental) snapshots.


Thanks,
Richard


[1] http://github.com/scy/levitation/blob/master/import.py
