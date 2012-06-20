From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 02/11] Makefile: fold MISC_H into LIB_H
Date: Wed, 20 Jun 2012 16:07:30 -0500
Message-ID: <20120620210730.GB6142@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183055.GB30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:07:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShS7x-00080e-CD
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 23:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758057Ab2FTVHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 17:07:39 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40411 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852Ab2FTVHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 17:07:36 -0400
Received: by yenl2 with SMTP id l2so5654951yen.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mYKL5c6KCmM2asjwjmMP8Ug+aaQqQnWzDthcziMGupg=;
        b=GoXTCISPU8Sk+OhXv6g6P4c1edRplrEdLGsc7HX48s/SCimwbiaAs9zdObln1iXDqn
         cVO06f9ycA2y78GxjbJ296JguORynxI564PLieOF4g5ebeZsDFEW86SHvfFrXLzetkH8
         nMXNxCgzpjR+SuP28VWOlJaMFAI6bIeCYZxbuBpZ2pLun+kL+gis1aWuj7+v8mkBZz2p
         YT2J66RVAWpusxDemOVVrujqT/uSNjcz4u89kFxaQgYsT2opXSb0rmE+naAjRoorBKN6
         +HruTfyFp09c+XKZ0ptfLIZPstAvpHiT8ugCOAdBNp22qbmbb1kUHYhVbk8qOZTXOkwm
         eo1Q==
Received: by 10.101.165.29 with SMTP id s29mr9037342ano.2.1340226455447;
        Wed, 20 Jun 2012 14:07:35 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id b8sm42142244anm.4.2012.06.20.14.07.34
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 14:07:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620183055.GB30995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200362>

Jeff King wrote:

> Let's just fold MISC_H into LIB_H and get rid of these
> manual rules. The worst case is some extra compilation, but
> even that is unlikely to matter due to the reasons above.

Should XDIFF_H and VCSSVN_H be folded into STATIC_HEADERS, too?
