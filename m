From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit stuff
Date: Mon, 25 Aug 2008 16:13:50 +0200
Message-ID: <48B2BE1E.2020503@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <200808212212.11184.robin.rosenberg.lists@dewire.com> <20080821201636.GZ3483@spearce.org> <200808220125.31990.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXcrc-0001gF-OB
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 16:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbYHYON6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 10:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYHYON5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 10:13:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:64783 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYHYON5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 10:13:57 -0400
Received: by yw-out-2324.google.com with SMTP id 9so122953ywe.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=MGGRCJuoV5tXYYf2W1c2ImSuc/3psNPHMrP4mgdxRHQ=;
        b=ZHranf931e1w6yKSZOnuhxa1c9VASXpze/ar2+6OsGRw/5ppCB6Q0U6IOPOWh/l1st
         8+2YsHbUoyk/YZKMB3K40Yl0PlwhaXr1DgEKiwq7wr+X8T/Z+BR2iL9btecDFmxiiI1j
         7pbcdz3vqPJJ3a/QV15FddiL+dXXuUox9BI38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ful3b5Hm36KjcDgwumhpUfG4MHymnjVoykORPwJC2hVMkGxVBJ/5Ypk2BPaE5wy4qK
         4GVmOsJE14pqI+LCW+3bVxiY+MZdTdk8efh/JgiCEzW6nXmlzmoeUTkmL+mWucAUfsUs
         oYcWiJHodsNPzTbvzRM8i5fuHvpNU96QRU8/s=
Received: by 10.103.243.7 with SMTP id v7mr2895593mur.118.1219673634591;
        Mon, 25 Aug 2008 07:13:54 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id e8sm26133295muf.6.2008.08.25.07.13.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 07:13:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <200808220125.31990.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93627>

Robin Rosenberg wrote:
> torsdagen den 21 augusti 2008 22.16.36 skrev Shawn O. Pearce:
>> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>>> onsdagen den 20 augusti 2008 04.42.42 skrev Marek Zawirski:
>>>> Actually, I'm now leaving for few days, so I'm sending out just fixes 
>>>> for issues pointed out by Shawn and found by me in the mean time. I'll 
>>>> squash these patches with existing commits in push branch, as it is 
>>>> probably worth nothing to keep this in history.
>>> As I'm too eager to get this out (seems to work), I can squash it and
>>> rearrange the checkbox-related code a little like stealing the icons
>>> from the Eclipse CVS and grouping the checkbox classes with the
>>> icons plus a tweak for selecting how the images for the checkbox
>>> are created.
>> Yea.  Go for it.  Reusing icons from Eclipse CVS is a good way
>> around the icon issue.

I'm back and looked at this solution - it is probably the best 
workaround for now, thanks!

> I pushed the cleanups to pu using the Eclipse plugin(!) built from that version. 
> You may want to take a quick look before we declare it master. 
> 
> Nice work Marek!

Nice to hear that:)

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
