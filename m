From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v2 1/4] git-p4: Allow setting rename/copy detection
 threshold.
Date: Mon, 22 Aug 2011 01:09:22 +0100
Message-ID: <20110822010922.3b5b573f@fenix.utopia.dhis.org>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
	<1313706054-11740-2-git-send-email-vitor.hda@gmail.com>
	<7vy5yq5nkb.fsf@alter.siamese.dyndns.org>
	<CAOpHH-VsoOSOH6ym2exCH=W4NmuKRw+f53HrwB47YD3u-iDe2w@mail.gmail.com>
	<20110819114719.GB15639@padd.com>
	<CAOpHH-WJWxeTSO5Dy6UR9pJh3w9hQSBuE7O1mY2KDAEsS9OAPw@mail.gmail.com>
	<20110820111956.GA5893@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 02:09:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvI5D-0000Y3-Sl
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 02:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab1HVAJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 20:09:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32946 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab1HVAJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 20:09:35 -0400
Received: by wyg24 with SMTP id 24so3157454wyg.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=Wq+iaW21qP7CNC73cH6OGSjic2WGFSb5pUhB2vdn+yY=;
        b=scK/0+jI6KrK++N9uLg5zS/6nhyojaTXD3Tf3d8poUhP2rNL1GkHsG+Yt/6al/g1QA
         YBiq4+Y+GEEER89tE6pgmCXf48uYP010AJ13OFIfw9R5W55u8vyuiRfWvY/PEydLUnol
         cq6Wr885dfCBLod4DFqgc0Vz67Fu2HUEU1+yk=
Received: by 10.216.221.206 with SMTP id r56mr1559786wep.19.1313971773964;
        Sun, 21 Aug 2011 17:09:33 -0700 (PDT)
Received: from fenix.utopia.dhis.org (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id y61sm3607691wec.6.2011.08.21.17.09.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Aug 2011 17:09:33 -0700 (PDT)
In-Reply-To: <20110820111956.GA5893@arf.padd.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179827>

On Sat, 20 Aug 2011 07:19:56 -0400
Pete Wyckoff <pw@padd.com> wrote:

> I was imagining you would not use "--bool", and parse everything
> yourself.  But I see your point, and letting "1" mean "-M1" as
> opposed to "-M" is probably okay too.  I'm not particularly
> worked up about which way that goes.

I decided to only add --bool to detectCopiesHarder, at least for now.
Will send a new set of patches shortly.

-- 
Vitor Antunes
