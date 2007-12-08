From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: XML parsing error from gitweb at freedesktop.org
Date: Sat, 08 Dec 2007 02:49:44 -0800 (PST)
Message-ID: <m3d4thtqaq.fsf@roke.D-201>
References: <799406d60712061334q33d2dba5r5496ba21069a4547@mail.gmail.com>
	<8c5c35580712061411k7a40a08el35f31c43add25cb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Adam Mercer" <ramercer@gmail.com>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 11:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0xG5-0007t3-Cy
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 11:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXLHKts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 05:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbXLHKts
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 05:49:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:1982 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbXLHKtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 05:49:47 -0500
Received: by nf-out-0910.google.com with SMTP id g13so520829nfb
        for <git@vger.kernel.org>; Sat, 08 Dec 2007 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=OtU1E9nRV+DbcvyLbne2a+GbAcUr4nhIlwvbwBww+R8=;
        b=XZrHg5nSu9XM93ikNn4LUwS8ERJ0/EsO906A7ZQdAVLkHIAk62HpDkewxQjNFy5p6ms6I+tL/aMGZu8wbRHmvBlxx4AbcFR/ErW3R2STWs8iTlY3LPItpUVPXWLbQxtsstOnxewskz6SirfvHFgW8LrR6XzMfB7O+eh0BC9SWTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=gqUR7wsbIw92GG93x8/H2tYd11y+OJekNTYvUNJ0nFmGGKtKIyUpR8uXhgB638f9wisDugVyvSO907ODiN3XVn3FSUSnhNNLOHjUsA1Ys+jkLRir3ZVVxClH4xqiGKBWDk8msQzfpf5rybZAWK/lyKOK4uwkvhob7Rkci9YhwG4=
Received: by 10.86.97.7 with SMTP id u7mr3200074fgb.1197110985634;
        Sat, 08 Dec 2007 02:49:45 -0800 (PST)
Received: from roke.D-201 ( [83.8.198.153])
        by mx.google.com with ESMTPS id f19sm914796fka.2007.12.08.02.49.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Dec 2007 02:49:44 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB8AncSx015022;
	Sat, 8 Dec 2007 11:49:38 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB8AnCYH015017;
	Sat, 8 Dec 2007 11:49:12 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <8c5c35580712061411k7a40a08el35f31c43add25cb3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67537>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On Dec 6, 2007 10:34 PM, Adam Mercer <ramercer@gmail.com> wrote:
>>
>> as cgit displays the commit OK
>>
>> <http://cgit.freedesktop.org/xorg/xserver/commit/?h=xorg-server-1.2-apple&id=48e6a75fbdd0fee86e364f02ace83f20b312a2b2>
>>
>> leads me to think that the problem lies in gitweb.  Could this be a
>> problem with gitweb?
>>
> 
> Actually, it's a problem in both cgit and gitweb, but you need to look
> a bit harder to find the error in cgit. It seems that gitweb on
> freedesktop.org doesn't detect a file rename (due to diff.renamelimit
> maybe?), so it shows the full source of the offending files, while in
> cgit you'll need to go from the diff to either the old or the new
> sourcefile to get the same error:
> 
> http://cgit.freedesktop.org/xorg/xserver/tree/hw/darwin/quartz/applewmExt.h?h=xorg-server-1.2-apple&id=141f69dc3d8d6e7d8ff65607f43700ac11243041
> http://cgit.freedesktop.org/xorg/xserver/diff/hw/xquartz/applewm.c?h=xorg-server-1.2-apple&id=48e6a75fbdd0fee86e364f02ace83f20b312a2b2
> 
> The problem is a number of unencoded ascii char 12.

Strange... I have checked gitweb code, and esc_html used in HTML
version of diff output escapes _all_ control characters ([:cntrl:]).
So ASCII char 12 should be shown as \014 in "cntrl" style.

Ahhh... I see, Freedesktop.org uses some ANCIENT version of gitweb,
from before it was included in git repository.

Try to ask Freedesktop.org admins to upgrade gitweb. Some nice
features include:
 * mod_perl compatibility
 * ability to display binary files correctly
 * gitweb do not use /usr/bin/diff, and do not use temporary files
   (and supports renames, typechanges and combined diff format)
 * better support for strange characters in contents and in pathnames
 * very basic support for submodules
 * snapshot support (optional)
 * forks support (optional)
 * 'next' links in 'commit' and 'commitdiff' view
 * optional features: commit search, pickaxe search, snapshots
   support,...

-- 
Jakub Narebski
ShadeHawk on #git
