From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Mon, 28 Apr 2008 20:19:48 +0200
Message-ID: <48161544.90500@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 20:55:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYVp-0006n6-ET
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbYD1Syx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbYD1Syx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:54:53 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:4015 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbYD1Syw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:54:52 -0400
Received: by fk-out-0910.google.com with SMTP id 19so5917540fkr.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=heD7vbZuKR0bQtyx5bTdI8/JBlJ7W/06l5HcpXvBdQI=;
        b=Tql1Y70ZOPH5Q/qmGW0KqwlE6mvlvhKx07hT36H8VLRldc9KWAE5SySCzSv4fe50GedfYhKmdO3vh7/lh728X5BWF9zYW3Pxp4JqgyBFo6z06h5nO69pMcQKDte4DhUh8m4PuO34ts1PyI8Unl8SBrP0UbGRQK0EgdUBHwEvC6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=l9en0gSneICVkPf8txLz/sN5RStgVrpMQxhP5y4qCjetOo6zhm1tIIGHu9w8fBTwqjLBavgMFNHjRkgzT4LBD6YJ8+mgnESDeq9hAmbWYznWVeFnRyYb4DU3doMUQzQPEJrcUiBnkwEFsZm1vUJJoAEX6mECvJYYPnss2mw4Hlg=
Received: by 10.86.95.2 with SMTP id s2mr8407112fgb.7.1209408890745;
        Mon, 28 Apr 2008 11:54:50 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id 3sm5316766fge.7.2008.04.28.11.54.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 11:54:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080428181012.GB6710@steel.home>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80584>

> my v4l2
> repo (which is a pretty collection of all kinds of remotes)

I can add a global boolean configuration to change the default value of 
skipDefaultRemote.

Paolo
