From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Sending patches with KMail
Date: Sat, 14 Jan 2012 12:31:11 -0600
Message-ID: <20120114183111.GC27850@burratino>
References: <2608010.fNV39qBMLu@descartes>
 <20120112162617.GA2479@burratino>
 <2304907.sEfEeC6Eon@descartes>
 <20120113233158.GD7343@burratino>
 <7vlipbxfne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>,
	git@vger.kernel.org, davidk@lysator.liu.se,
	Sergei Organov <osv@javad.com>, Kevin Ryde <user42@zip.com.au>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 19:31:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm8O0-0002AC-9T
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 19:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab2ANSbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 13:31:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46721 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab2ANSbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 13:31:22 -0500
Received: by iagf6 with SMTP id f6so122679iag.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hy+435NcBaJqMWa1GivxMBBtQpc3WKC1LZaXUMmgunM=;
        b=A26Gs9giuxY8++dLf+3ixTSXd/CScRk3yDPQ5S8P+NJWtlx1XSTPhj9rbz0xKgFG6Q
         iUnuyG80x4ufey2Adw0NqVqL8SrCupIqSijKOhZNLjAyqDPIwno6ae5JiL/x7w1UrdYO
         dcHYetyZUm/wlRodn3yxzXRBn2pIGbc0Ckqm8=
Received: by 10.50.189.194 with SMTP id gk2mr3320405igc.0.1326565881758;
        Sat, 14 Jan 2012 10:31:21 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id xu6sm22056094igb.7.2012.01.14.10.31.19
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Jan 2012 10:31:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vlipbxfne.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188574>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The hints at [1] might also be useful, in case you would like to try
>> and consider improving the manpage to document them if they work.
>
> Don't you need similar updates to sections for other MUAs and procedures?

Thunderbird approach 3, yes[*].  The others, no.

[...]
> Perhaps rephrasing the early part of the Discussion section, with an
> illustration that is designed to be more visible, would be a better
> approach?

I understand what you mean, but I don't think so.  The Discussion
section already seems clear to me, so I would prefer to wait to hear
from someone confused by it to find what exactly in it needs tweaking.
Adding additional paragraphs for each potential misunderstanding by
people who have not necessarily read the section has the potential to
backfire and lead even more people not to read the section...

My favorite approach would be to introduce a new option
--format=plain|mbox, with the default being mbox, allowing
format-patch --format=plain to produce a nice patch that does _not_
include a "From " line or q-encode its header lines, ready for use
without much tweaking in an email body as an attachment.  Then we can
just say "If you are not importing your patch as an mbox file, use the
--format=plain option".

Sane?

Jonathan

[*] Though I'd rather just remove it, since "how to use an external
editor" seems orthogonal to "how to teach Thunderbird not to mangle my
patches".
