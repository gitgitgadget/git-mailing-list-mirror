From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 08:55:07 +0100
Message-ID: <e5bfff550802102355n3076ae6ax636e6c5635e6a0ab@mail.gmail.com>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de>
	 <20080211074817.GA18898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:56:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOTW9-0001UW-0I
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 08:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855AbYBKHzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 02:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756815AbYBKHzK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 02:55:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:44851 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbYBKHzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 02:55:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3311631rvb.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 23:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=U7WpbSmo0GZKfK6mG9Y/CUca+gA6qdiHuVjSPWOi1S4=;
        b=sztNShB0dhAbuS/LIIChwFgBZj/bBwqyEPBmSci1JeAVYeFbsPBa3elL+fwX9hqTFc1ZJCo2O9hPiEaSVEnN2QzZUEKAFQVENxPa+SS0NNy5zq9xfC2PbBmNyCg97RdDO8nW0o5EwePOTb2MlValVnE/vzGlEmQlWGVPXAIjv14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uvlwm+JnE1nMrymlsEka0YvtcbRlGTncCg849Geb8flCjDAGTfZQY+M7lD1DhvnSA5hfZiktppI3nSHu+r+AKhPs4O/sk1AtwXcGZahOQjX0C5g12KlaRWNu7FAzF7Ism0fGVDePt5rekR870XwfK9X2GuqeRZXiDuin0mZqgxA=
Received: by 10.141.97.5 with SMTP id z5mr10366878rvl.197.1202716507444;
        Sun, 10 Feb 2008 23:55:07 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 10 Feb 2008 23:55:07 -0800 (PST)
In-Reply-To: <20080211074817.GA18898@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73478>

On Feb 11, 2008 8:48 AM, Jeff King <peff@peff.net> wrote:
>
> It may also be that multiple rename limits are appropriate. I don't mind
> waiting 30 seconds for rename detection during a particularly tricky
> merge. I probably do when running 'git-log -p'.
>

That's exactly my point: ignoring diff.renamelimit in case of merges.
