From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: New Proposal (simple) for Metadata in Git Commits: git-meta
Date: Wed, 16 Dec 2009 08:30:36 -0800
Message-ID: <20091216163036.GE18319@spearce.org>
References: <93857A5A-744E-4A7C-B42D-23A56A48AAF7@lenary.co.uk> <20091215220529.GD18319@spearce.org> <7349A827-41D5-434F-85FE-D49980A7D501@lenary.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Elliott <sam@lenary.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 16 17:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKwlz-0005Et-5X
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 17:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935020AbZLPQam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 11:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935013AbZLPQal
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 11:30:41 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51162 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935011AbZLPQal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 11:30:41 -0500
Received: by yxe17 with SMTP id 17so1053218yxe.33
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 08:30:40 -0800 (PST)
Received: by 10.150.35.18 with SMTP id i18mr2001390ybi.153.1260981040368;
        Wed, 16 Dec 2009 08:30:40 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 9sm460901yxf.41.2009.12.16.08.30.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Dec 2009 08:30:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7349A827-41D5-434F-85FE-D49980A7D501@lenary.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135331>

Sam Elliott <sam@lenary.co.uk> wrote:
> On 15 Dec 2009, at 23:05, Shawn O. Pearce wrote:
>> If you dropped the --git-meta-- tags above, JGit would happily
>> recognize the awesome: and Github: tags, but it might need a bit
>> more work to recognize the nested user: tag.  Also, you'd be able
>> to use git-meta on the git and Linux kernel repositories to pull
>> out and work with Signed-off-by, Acked-by, etc.
>
> I'm not entirely sure about this approach. The current implementation  
> also works with PGP-signed tags, where the information is not  
> necessarily going to be at the bottom of the message when i use `git- 
> cat-file -p`. I think it shouldn't be too hard to also have git-meta  
> read any YAML-like data just before the signing message.

Ah, good point.  But as you point out, it should be simple enough
to detect a PGP signature on the bottom and just clip that off the
end, and then perform the YAML-like data parsing on the footer.

-- 
Shawn.
