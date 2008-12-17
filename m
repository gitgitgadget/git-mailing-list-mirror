From: "Tim Visher" <tim.visher@gmail.com>
Subject: Is it possible to roll back unstaged changes while leaving the staged ones for the next commit?
Date: Wed, 17 Dec 2008 14:57:08 -0500
Message-ID: <c115fd3c0812171157m3d180534gb5630fbcf39b2bbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 20:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD2XP-0001AA-Ml
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 20:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbYLQT5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 14:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbYLQT5M
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 14:57:12 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:13007 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbYLQT5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 14:57:11 -0500
Received: by an-out-0708.google.com with SMTP id d40so32004and.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=14HmslDWDebdx/hoRrCneizSdnIcDPxnShiRkuvbIcQ=;
        b=VmFJG5DVdmOClJYr9lSOBQGfXbxzkyfR4mK5Enxsg4CrFOUmq24IO7BwBn9heRcBdW
         6/4ByIJz/O7wCftlagwh9+OcfZ4Kzfn4Q+v8ep3admqptRpUYcvNS6eLnhq4ruI6JmUF
         WVPfLKC2+arCNI8fouEQv442K6ymRTSWyGPs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=efJFX4nPUEryAvgqvUALcL5Rx9vMRzg9dd5Hv2PagoFi1w3io8+6d2bpVipSJqXnN0
         48bkMlSQdRcxlpJLmF/1aEV75hLPpBBJeuazLJLjUuBWdoh3w5v7gSZrAA6E60UgE6my
         uQl61AkMbMueStGBHdQdjk+3wlnFpVKgT/O3s=
Received: by 10.100.127.18 with SMTP id z18mr916824anc.6.1229543828958;
        Wed, 17 Dec 2008 11:57:08 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Wed, 17 Dec 2008 11:57:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103377>

Hello Everyone,

I'm attempting to use `git add -i` to help me resolve the differences
between two files in a way that makes sense (leaving class names, some
logic, but changing other things like white space, etc.).  I have all
of the changes that I want to be committed staged now in the index.
My question is this: is it possible to revert the changes that I
haven't staged so that the file looks as if everything inside of it
has been staged because none of the stuff I didn't stage is there
anymore.

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
