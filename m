From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Pair Programming Workflow Suggestions
Date: Wed, 16 Sep 2009 16:17:30 +0200
Message-ID: <20090916141730.GA24893@vidovic>
References: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com> <BLU0-SMTP195165E447A0C42386D083AEE30@phx.gbl> <c115fd3c0909160635x4d7368aeg4370668d765fd242@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean Estabrooks <seanlkml@sympatico.ca>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 16:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnvKJ-0000CL-6L
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 16:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbZIPORe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 10:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbZIPORd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 10:17:33 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:41149 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbZIPORc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 10:17:32 -0400
Received: by ewy2 with SMTP id 2so1457015ewy.17
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=1XttziCJx3P3s1R5hoc8QJSKIzpkMHOemHNW8T6s0sM=;
        b=QDzSKacnl/ZPj64dV19YR/gnlFiKJQuVNfFSJGxgaaXKvVvncKoc0eJs3T3l92Ucww
         6WjuP8xIirvuRUJ55imrFZ20KYbwEvbnzXi2/JE9mHsqhYSN711XZ91dev6wbfyywsLy
         Buk7R+N40JeV7CmSCbPnZmxtvuixVhjayPBmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BtRonoEi2HJbYkF02PXhOj+u+ZrKJK1ZK7u0SF24pIdKiD0E37feudw+tE88j7PCrk
         BUVZcfR3bq2O69afTyuJvXv2a8MLidx4aJfkz/jwkLH9+2qFj+HkdE4MRdzL0T7qR/OZ
         TLIlfblP/E5QnLiHT37QnG5XR+iPsAAqCl+ls=
Received: by 10.210.9.13 with SMTP id 13mr2412147ebi.3.1253110655450;
        Wed, 16 Sep 2009 07:17:35 -0700 (PDT)
Received: from @ (91-164-145-100.rev.libertysurf.net [91.164.145.100])
        by mx.google.com with ESMTPS id 5sm2768087eyh.3.2009.09.16.07.17.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 07:17:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c115fd3c0909160635x4d7368aeg4370668d765fd242@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128656>

The 16/09/09, Tim Visher wrote:
> 
>                         Pairing, on the other hand, is much more
> tightly integrated than that.  Just like in Brian's post, it's really
> a situation of Dev1 _&_ Dev2 wrote this feature, but one of them
> happened to be typing and doing most of the nitty-gritty developing.
> Changing the authors between committs almost seems to introduce an
> arbitrary level of distinction where it's no longer _both_ but _one
> then the other_.  Does that make my question any clearer?

FMPOV (and to follow the Pair Programming purpose), there isn't an "I"
in "Pair".  So having the same author name and sign-off for each pair is
what makes most sense. IMHO, "dev1_and_dev2" is actually the best
option.

-- 
Nicolas Sebrecht
