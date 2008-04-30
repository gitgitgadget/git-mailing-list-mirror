From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: About git and the use of SHA-1
Date: Wed, 30 Apr 2008 17:56:58 +1200
Message-ID: <46a038f90804292256jc99306ck78b8718e0377a5c6@mail.gmail.com>
References: <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
	 <alpine.LFD.1.10.0804291232130.23581@xanadu.home>
	 <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>
	 <alpine.LFD.1.10.0804291352120.23581@xanadu.home>
	 <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com>
	 <alpine.LNX.1.00.0804291410340.19665@iabervon.org>
	 <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com>
	 <46a038f90804291958u14eddc49sb54c7fd4a3a10381@mail.gmail.com>
	 <7f9d599f0804292218x7d94d7del20d4d48bbad80fb5@mail.gmail.com>
	 <20080430054700.GA1345@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Geoffrey Irving" <irving@naml.us>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Nicolas Pitre" <nico@cam.org>, "Andreas Ericsson" <ae@op
X-From: git-owner@vger.kernel.org Wed Apr 30 07:57:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr5KD-0001WP-U2
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 07:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbYD3F5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 01:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbYD3F5A
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 01:57:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:13309 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbYD3F47 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 01:56:59 -0400
Received: by wf-out-1314.google.com with SMTP id 28so266507wfc.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 22:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MSLN/+UmOG+YQ2Brr2VCSQMUCHlektvPtKrS1zSzp7o=;
        b=P7UdWb5zDbvyFX91VevAw49COuUmPzLZrelr0OycWB+ap0T4BKjL6L1okwxJV2CtMUZjqdcM7pPBG7RAvpV1FFm7uGBRXwDqGJF+JLZkQCJY2jtNZ3sq5VOg1TAOMxfmFwcws6uSq9lCkdyQiNUthfXtpQbNobK5gqHLjXrE2qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N3wKI9SZm6BXvJWn/FWbfxP3jFooqxK7npn5UWXNsBAlmsaiahtqgvv9nuW+e9KqkpWvL02h4YSXjHYFSlqOBc6hwE37aVnUjoGGsnvmT/888nK9lkVm7z1/R+GMDm4m7Xr995sgLi1bxGktrKQiudSnipTb6Ugd1Dmfpi0D3CA=
Received: by 10.142.44.11 with SMTP id r11mr149780wfr.13.1209535018711;
        Tue, 29 Apr 2008 22:56:58 -0700 (PDT)
Received: by 10.142.212.21 with HTTP; Tue, 29 Apr 2008 22:56:58 -0700 (PDT)
In-Reply-To: <20080430054700.GA1345@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80796>

On Wed, Apr 30, 2008 at 5:47 PM, David Brown <git@davidb.org> wrote:
>  usertime and realtime are from the start of the invocation of the
>  postscript interpreter, not based on the outside world.  So, the

You guys are right - I misremembered the spec wrt dates. I had the
distinct impression that there was a way to get the epoch.

Sorry about the noise.



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
