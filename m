From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/8] mergetool: use tabs consistently
Date: Mon, 30 Mar 2009 02:22:27 -0700
Message-ID: <20090330092226.GB18953@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com> <1238389428-69328-2-git-send-email-davvid@gmail.com> <7vzlf3flim.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 11:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDik-0006RU-PG
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbZC3JVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbZC3JVu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:21:50 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:59955 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbZC3JVt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:21:49 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2409692qwh.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6ewK9NG642gLJLb9VcwlJhzd5yMgdpIYEWBdc5YiJwU=;
        b=PcCUd1u51PqJBF5yUdgC4zAwlaOL2qDV1lVwmQabP0hKJ9mEr2OtyFpTOA+AI/IKcS
         CmALNVK1e7tHopKl3zXl1w1Jzx+my3KlGekVbmXlU3f98b3LITPO1Nz4bPiIVOaRvLfh
         +yC2A/GX91GZgqhd9VtbEUu2vMA4g7v2dlKss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pRYSWVZ/DWtCcR+IDRSZLACCp9u4QAmo4aa0/sA6FzFAXwlRGQ+ATzKxy1HBPTAsDA
         VkyclsIfWUr3/xMc2oSEaTix1wvZdfZ4AlCOduW2RFNks6GioR8sBfuYylaLpolL1NP6
         rMGsWrWnJpjeJ3tE4tTeMRVnZiqTv7lNoigi0=
Received: by 10.224.89.74 with SMTP id d10mr5809961qam.202.1238404906711;
        Mon, 30 Mar 2009 02:21:46 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm5605330qwk.27.2009.03.30.02.21.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 02:21:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzlf3flim.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115117>

On  0, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.
> 
> Even though this [1/8] is obviously regression free, and I think the
> overall direction in which the series is going is good, I'll wait until I
> hear Acks from Charles Bailey for the parts that involve mergetool.  I do
> not use either mergetool nor difftool myself, and going over every single
> line of this series to spot potential regression is beyond my bandwidth
> right now.
> 
> I do not think bits only common between mergetool and difftool should be
> called with a very generic name "sh-tools".  We didn't call the result of
> a similar refactoring for launching web browser from help and instaweb
> context with such a generic name (it is called git-web--browse).

I also felt iffy about the name.
Maybe...
	git-interactive--tools ?
	git-merge-diff--tools ?
	git-mergetool--lib ?
	(i'm pretty bad with this naming stuff ;))

(I have --interactive on my brain thanks to Ping's patch ;))

I can rebase as needed once we get more feedback, particularly
notes from Charles.

-- 

	David
