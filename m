From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [ANNOUNCE] codeBeamer MR - Easy ACL for Git
Date: Sat, 21 Nov 2009 18:42:53 +0530
Message-ID: <2e24e5b90911210512g5ec26307te63d10912a7906fb@mail.gmail.com>
References: <4B03B153.1020302@intland.com>
	 <20091118120936.GL17748@machine.or.cz> <4B054D0A.5030802@intland.com>
	 <2e24e5b90911192056t706071ble163a53741017ef@mail.gmail.com>
	 <20091120074702.GW12890@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Intland Software <marketing@intland.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Nov 21 14:13:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBpmY-0001Vz-7L
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 14:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbZKUNMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 08:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbZKUNMs
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 08:12:48 -0500
Received: from mail-px0-f204.google.com ([209.85.216.204]:59295 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbZKUNMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 08:12:47 -0500
Received: by pxi42 with SMTP id 42so2356170pxi.5
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 05:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=QYNACDfKaeXMS6SdUTVz8ea0h1/oKsjEHSi+rfMnYCc=;
        b=D/PxhWo+diTyViQTa9eTvGzPxOFULoyAPIKzhMlSoLGPaAZua+Di2fXqTjGD43/rey
         zPdjhNAdB6B3gZ1oCnxqeN10kQvvAk5iloSWz1l2R4rI/Dmx3lDMWHU0VPLaeSN+vu+O
         bUTugm6ZQSh3w2iTBlDftV2yoSWpUr1Teuhg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=u6u7oWeeL2LbLAmFlc5kbFNO3jamzEMocork8s0j+5sFREQzH8TPx1EFaMVPH2IMTJ
         r4hPgexOP6PWhaXlM+lGn6iYjb3zXggNikekp7d2nrc1nv+CXFihW/Hd5wYq2Q+Bgg4A
         5P080oLikCSiPiEYjcxswsbQObKZ4jrOOgLuI=
Received: by 10.114.187.7 with SMTP id k7mr3801526waf.106.1258809173921; Sat, 
	21 Nov 2009 05:12:53 -0800 (PST)
In-Reply-To: <20091120074702.GW12890@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133394>

On Fri, Nov 20, 2009 at 1:17 PM, Petr Baudis <pasky@suse.cz> wrote:

> I brought Gitosis/Gitolite up because I got the impression that MR was
> marketed primarily as a Git ACL tool, the other things being sort of
> mirror; maybe my impession was wrong, but I still think the comparison
> in ACL capabilities is useful.

Sorry; didn't mean to imply you were wrong about that...

But the bulk of MR is probably the web based stuff, wiki, issues etc.,
which means gitolite is way on the other side of the spectrum, so it
felt like any comparision is moot, and used the code/binary sizes to
highlight that.

But you said just the ACL capabilities... set me thinking...

Intland: do you have a page that describes your role based ACL stuff a
little more?  I have a feeling that, modulo it all being in one text
file, gitolite can probably come close :-)

>> You should stick to gitorious, github, and -- here's a new
>> one for you -- indefero.
>
> Hmm, I didn't even know about this one, thanks for the pointer. Looks
> like this suddenly is a very popular area. High competition is good!

Oh yeah, and indefero is actually looking pretty good -- I know some
guys at $DAYJOB looking at it very seriously.

> (BTW, if you don't care about wikis and issue tracking, but you do care
> about simplicity and light-weightness, you should best stick to Girocco!
> ;-)

:-)  yes it is nice, but again, at $DAYJOB access control (even to
view projects) is a big deal.  A very big deal, actually...!
