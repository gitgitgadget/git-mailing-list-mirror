From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 6/8] sh-tools: add a run_merge_tool function
Date: Mon, 30 Mar 2009 00:46:26 -0700
Message-ID: <20090330074625.GA11769@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com> <1238389428-69328-6-git-send-email-davvid@gmail.com> <1238389428-69328-7-git-send-email-davvid@gmail.com> <200903300932.29870.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 09:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCDK-0003vV-1V
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 09:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbZC3Hpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 03:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbZC3Hpv
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 03:45:51 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:62901 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZC3Hpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 03:45:51 -0400
Received: by qyk16 with SMTP id 16so3350107qyk.33
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=I/S2an/TqoCmqRp/3cWHjDmCnz6T4hm2Asu6ciupohA=;
        b=SDGH1+HqqRco7548+LAWtuNTTiGeWy5LC3mqbLr6Zrsc81AHsrJsZlQV9aRrJI2wi6
         8bNCTgXMHELLDdo4/bSoR45lVZRG3VC/3TpwfC5e33caB5RwGLBpur1uodY1/x6GVIcy
         6ClPXDMSE3kOM3l6vfzWayGOvoi57v5wiRS0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FYwtHEyWvGLmCr94Ezop2LLi/IxBlOvhWidEBm2BmKwg0WIPHAPpZcYhP8Z9IyNDQH
         TVTxuI7qUnVibWs963dHRO2Q5VKIOE6IFxnGl5ip5eQUcRihLwuQNtR/jb9klypQodNp
         2p+cf8iLzJVfUfzIF2Ls0+ELQaSzwuZZP9N4Q=
Received: by 10.224.11.72 with SMTP id s8mr5712139qas.185.1238399148932;
        Mon, 30 Mar 2009 00:45:48 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 26sm5513167qwa.12.2009.03.30.00.45.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 00:45:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200903300932.29870.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115097>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> David Aguilar, 30.03.2009:
> > +# Runs a side-by-side merge tool
> > +run_merge_tool()
> > +{
> > +	merge_tool="$1"
> > +
> > +	# base_present is always false when !mergetool_mode
> > +	case "$merge_tool" in
> > +	kdiff3)
> > [...]
> 
> Kompare is missing here. Note, that this is only diff tool, not for
> merges.
> 
> Markus
> 

Thanks, will fixup asap.
I botched the --cover letter too ;)
note to self: no more refactoring while sleepy on plane.

-- 

	David
