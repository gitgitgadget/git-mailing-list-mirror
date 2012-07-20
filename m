From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 16:32:28 +0200
Message-ID: <FF0EC850-7A16-4A26-A0F0-2FF45FF7F009@gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <7515FF5F-2B4F-4CD0-B4A3-D2B1328AE313@gmail.com> <20120720142630.GA31791@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 16:32:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsEFx-0008Uy-LB
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 16:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab2GTOcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 10:32:33 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58427 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab2GTOcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2012 10:32:32 -0400
Received: by wgbdr13 with SMTP id dr13so3710108wgb.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=NSGKE3W0seXizyAjV8X+tCdpgs4YayyClrtAwzg36UQ=;
        b=Uaf7bK5S8+syuDkWnDGWQ3RmKJbOMQCUnu395bzz4dtmskXEamRtpPO2PoAVH+nzHi
         QsucRoKVjVMirnvA+wvry6iy0EL3urBPplGRnIFHuLxobZM++E/ABdSGCeD5xqjZeQRQ
         ZuLUYNsOLTWy9yJH5x8K83/4jJ6FBznPagWubOGMiGfPadUdIB8KmYK05a2BPi1fZ/dr
         r9y1Az63Kx3aE9M7hl01KjkulbIDUAcucMT6YOoJ1WaIo3XSNJhvPkpVu5hVI9y9Nxfc
         KBmKneL8MbCVWEsdrIT3Ud6rX2+iwbZI56WREoe7TpUD4bJUuZ6QB7PstOritSRuWpDg
         1GgA==
Received: by 10.216.237.193 with SMTP id y43mr4120536weq.75.1342794750901;
        Fri, 20 Jul 2012 07:32:30 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id h9sm44936437wiz.1.2012.07.20.07.32.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Jul 2012 07:32:30 -0700 (PDT)
In-Reply-To: <20120720142630.GA31791@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201769>

On 20 Jul 2012, at 16:26, Jeff King wrote:

> On Fri, Jul 20, 2012 at 12:23:12AM +0200, Alexey Muranov wrote:
> 
>> i have no idea about Git source and little idea of how it is working
>> internally, but reading through your message i wonder: wouldn't it be
>> a good idea to timestamp the dead reflogs ?
> 
> Each individual entry in the reflog has its own timestamp, and the
> entries are expired individually over time as "git gc" is run. Or did
> you mean something else?

Yes, sorry, i was not clear, i meant to put dead reflogs into subdirectories yyyy-mm-dd, or maybe yyyy-mm-dd-hhmmss.

-Alexey.