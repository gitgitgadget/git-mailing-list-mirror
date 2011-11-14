From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 14 Nov 2011 22:03:07 +1300
Message-ID: <4EC0D94B.3060805@gmail.com>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org> <buomxbzutjm.fsf@dhlpc061.dev.necel.com> <7v62inkymg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 10:03:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPsRp-0006EG-8E
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 10:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab1KNJDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 04:03:11 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36929 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab1KNJDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 04:03:10 -0500
Received: by gyc15 with SMTP id 15so4661981gyc.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2+f0Wjo1VDHT+9oidQ5N5MNrWbrlCBQ1iof7Lp2FL18=;
        b=F7FgGPjAR9Q8tkcUKMzGaYNvkHTsNV9GX8E/bqOK+IeNECE+wL0eA6ddMHzHBx3ZsX
         VFqpoK4UYB+iBjMU91LoNm+6DY2kja5G8OWSHneB7dLES1tBJvh6cqnUgov3GCrVKlnC
         L+bFHEImldT/6ez9maiJ8binRg5orKqG6FqIE=
Received: by 10.68.38.71 with SMTP id e7mr47900356pbk.88.1321261389590;
        Mon, 14 Nov 2011 01:03:09 -0800 (PST)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id f2sm26539796pbg.14.2011.11.14.01.03.06
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 01:03:08 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <7v62inkymg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185370>

On 14/11/11 19:27, Junio C Hamano wrote:
> Miles Bader <miles@gnu.org> writes:
> 
>> Do you mean a more elaborate UI that does this nicely...?
> 
> Yes, that is what I meant. I also have a feeling that people would prefer
> to have an option that treats these two repositories equally; your
> illustration makes one a subordinate to the other.

Not sure if it's what you're after but there was this patch [1] that I
was kicking around a while back. I've still got the code in an old
branch if there is interest in resurrecting it. It looks like I started
addressing Junio's comments and never posted v3.

[1] http://article.gmane.org/gmane.comp.version-control.git/143164
