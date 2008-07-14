From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 15 Jul 2008 01:12:22 +0200
Message-ID: <487BDD56.7010505@gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.o
 rg> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXES-0000OO-If
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759187AbYGNXMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759188AbYGNXMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:12:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:16884 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759186AbYGNXMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:12:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2182544fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=ZO8h7c4wz1Y2VwoQ7mVt8q7LuVXPaBxu3ckxDS5Bh/U=;
        b=raRWARBrsnvm5LIEYfNZXXdZ7upEA2jwcNvJ45ZMIaY0vhiScF5GUjl+fJWVHX2Dwm
         uPHnFrYRSadmFlah6xZz5jbFkEXeJMmqdLXAsbzfsgDqKPPdA6UXw+rs6B7vnUViEEpA
         46caANi1qTGSk6x82CThwX3I/2U5gOv6k15bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=E+GJBbaXY79T4cDrRKh8cHCkpkpwr9FpvutYyU5DfszM15cjeAmnLbuQ++8ihoKwHa
         clNSkPXJhxHGpFJosaRgbUX2ZRs85ziw/bBn20ahbKus7GLD/viMKfDxso+eH46JrGXy
         r7AI6m9xJ2pBz3sBXk/urEGPaFj3FdfvL/IGQ=
Received: by 10.86.82.16 with SMTP id f16mr15077737fgb.16.1216077142923;
        Mon, 14 Jul 2008 16:12:22 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id 4sm8104758fgg.9.2008.07.14.16.12.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 16:12:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88476>

Junio C Hamano wrote:
> * lw/gitweb (Fri Jul 11 03:11:48 2008 +0200) 3 commits
>  - Add new Git::Repo API
> 
> This does not pass t9710, at least for me X-<.

Yikes; I thought I had removed all instanced of Carp::Always (which I
had put in for development), but this one apparently slipped through.
It'll be fixed in the next version I post (which will also have the
dependency on the non-core Test::Exception package removed).
