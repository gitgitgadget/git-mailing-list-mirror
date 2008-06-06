From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] provide a new "theirs" strategy, useful for rebase --onto
Date: Fri, 06 Jun 2008 13:28:05 +0200
Message-ID: <48491F45.3070100@gnu.org>
References: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 13:29:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4a7z-0004ZA-7G
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 13:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYFFL2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 07:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYFFL2J
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 07:28:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:46102 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbYFFL2I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 07:28:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so649738fgg.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=qj6XiVNPoGz6jyRH/qOPgF61PHs8ZfT8TXvM7mWGycY=;
        b=Ep3lKzGJdacgFOXC4yTyy8qg34srNCNMcQI/G/GUG6sTtzc39cMNCNsc6UYiVG0mQG
         PVuUiSu+jxhkZjB60PtDlTJTkhmwcLXB+RznhJyAp9RkdTKvehyUES+xCOjYZmlLju1/
         xL0sHKDiEvGrFajhDHPtQdRjZ7Az0jJlIUe90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding:sender;
        b=Y+U6BMVMtpvz3TAjL6sijTM/wSu3dCcErMweRSKjY6Cs8zgvYRPoEuw1y5hzNw1J8L
         3Ca/5dto+OsWUu+QPShBVjHyRxko1TTG9Iijhgx6LeGnXJ6ISCUl8JBgJ1ts3t8/SWb7
         2KDoHYxbYBrCk33bm3byHrnhjNtgm60ixmtQ0=
Received: by 10.86.63.19 with SMTP id l19mr19167fga.77.1212751686526;
        Fri, 06 Jun 2008 04:28:06 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id e11sm5259048fga.4.2008.06.06.04.28.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 04:28:05 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84049>

Paolo Bonzini wrote:
> The new strategy resolves only two heads, and the result of the merge
> is always the second head.  It can be useful with `rebase --onto`,
> because it always resolves conflicts in favor of the commits
> being applied.
> 
> The patch includes an update to git-rebase's documentation, showing
> how to use the new patch to convert an "--amend"ing commit into a
> separate one, as if --amend had not been used.

Signed-Off-By: Paolo Bonzini  <bonzini@gnu.org>

(i.e. forge it in my original commit message if the patch is accepted).

Paolo
