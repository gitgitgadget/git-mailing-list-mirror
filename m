From: "Felipe Carvalho Oliveira" <felipekde@gmail.com>
Subject: Re: [PATCH updated] git wrapper: DWIM mistyped commands
Date: Sat, 30 Aug 2008 19:17:11 -0300
Message-ID: <a2075f4c0808301517m1df72e85j5a0de23c04c7f6ae@mail.gmail.com>
References: <20080828171533.GA6024@blimp.local>
	 <20080828212722.GF6439@steel.home>
	 <a2075f4c0808301510g1af01b14kd58da12dc2e80f93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 31 00:18:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZYlu-00058O-B8
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 00:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbYH3WRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 18:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbYH3WRN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 18:17:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:49938 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100AbYH3WRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 18:17:12 -0400
Received: by ey-out-2122.google.com with SMTP id 6so562472eyi.37
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=POSBPdYkdIdtx7WVGuimu0d55vHkjMey+jCGEWlPZCU=;
        b=ieFwK3juc0qNhzE0wzctfR+o8257hF88HFCV26ECehRIUHQV0hnoaoxqVfXaoOPWpi
         XB48VsJ1R7BHnEzn19+kdgDMKrt7A30C3IH55hWCiNJQqES8j7sh1jEn8eFKhPBAPesM
         zSpMY4l+bQo0a+G+fvKwcY4EP2TDxWxhpdBH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FJ4rjscDIGO4UWCsIkNTCcdU30UxCRhV0lRPGG4PdUATDA+6kT3+8kdTfeE5r0Sp2W
         gTYvUpbeeVtP9uVV8RvyGlnyLdzyU/nvtT0FG6nwlYldY7hj9vrzcDqSkExRqHOqE5Ie
         UTE1tn7qzjohGQjTyJXQKQOIRaQiULqNuBM48=
Received: by 10.210.105.20 with SMTP id d20mr3904981ebc.18.1220134631052;
        Sat, 30 Aug 2008 15:17:11 -0700 (PDT)
Received: by 10.210.46.3 with HTTP; Sat, 30 Aug 2008 15:17:11 -0700 (PDT)
In-Reply-To: <a2075f4c0808301510g1af01b14kd58da12dc2e80f93@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94440>

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> This patch introduces a modified Damerau-Levenshtein algorithm into
> Git's code base, and uses it with the following penalties to show some
> similar commands when an unknown command was encountered:

 Thanks so much by implement this. Few weeks ago I had thought about this.

  Felipe(from Brazil)
