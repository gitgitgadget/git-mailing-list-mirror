From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Wed, 28 Nov 2007 15:36:23 +0700
Message-ID: <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	 <Pine.LNX.4.64.0711271617350.27959@racer.site>
	 <20071128000731.GD9174@efreet.light.src>
	 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:32:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKut-00045Y-T2
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:19 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIX3-0007rL-P6
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:44:33 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIWv-0003wr-4y
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbXK1Ig0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 03:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbXK1Ig0
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 03:36:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:8728 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXK1IgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 03:36:25 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1309455nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 00:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s9ltcfHnpuTZzVy38xaQxTU1/LeqMyQgkPH58L6gBIo=;
        b=lfsfa5D2rMtVZughyXUwfm9a6DUeG95oDqTrMatX1wh041TsZuXRRkAJgED5iFXyH5wsW4hcUyEMdtUn73m23+ZjcXKwUwL1qIRvKjgkFblfoPLt+VYSwSKxweGv/kB8KaAoQ616apvXFJ77EWFIWIUGrL5R9dVKLiuKdvtKzow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QGzr7tHjfFrN2I8G3H3O7f4R9fXaWF983+muFe4LIHld8B5d1hzomJRvwR2Sz6vD+ZWyrZVjpps9nz03QN5Ab4kcNGhpEHo9RRpwHvKZpzKj/wQfveeXFf623ukO/WdEQUpXKMffvwnALms0WQZMN9uiLj2f5S/P0BM1/GxMbBY=
Received: by 10.86.58.3 with SMTP id g3mr4732346fga.1196238983926;
        Wed, 28 Nov 2007 00:36:23 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Wed, 28 Nov 2007 00:36:23 -0800 (PST)
In-Reply-To: <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 13642AF476B506FB5E91D12D1A358E4610B4656E
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 60 total 724131 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66330>

On Nov 28, 2007 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> In case somebody is thinking about 36e5e70e0f40 (Start deprecating
> "git-command" in favor of "git command"), that is a somewhat different
> issue.  What Linus suggested is not installing git-foo link for built-in
> commands _anywhere_ on the filesystem.  Not just "out of user's PATH".
> That is not deprecating dash form but removing the support for it.  We
> need to give ample time for users to adjust to such a change.

A little note on this one. I've been using git without builtin links
for a while with my git-box port. There are still some builtin fixups
needed. And because execv_git_cmd() always uses dash form, so it's
impossible to use vanilla git without builtin links.
-- 
Duy
