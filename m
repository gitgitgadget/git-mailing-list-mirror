From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Diff format in packs
Date: Mon, 31 Jul 2006 17:08:25 -0400
Message-ID: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 31 23:09:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7f0F-0001RT-3F
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 23:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWGaVI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 17:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWGaVI1
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 17:08:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:64623 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030458AbWGaVI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 17:08:27 -0400
Received: by nf-out-0910.google.com with SMTP id o25so31031nfa
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 14:08:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HWqa8kJ0f5EUpc66SnuxtIK8Yb6qNCYHPcrGUqXSwRXaSLFgpDYZnjIxHt65QXZAbhoJOGi/FL1cdMiHakelEwB9l/+S1unfa6s4Be7UkLkbdqORMaEoCsMz1v7IRcW65hPcrw+VnIpZ8Rd3L1EaEK22D/ec3cchhCK9M8hRsYs=
Received: by 10.78.116.19 with SMTP id o19mr38273huc;
        Mon, 31 Jul 2006 14:08:25 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Mon, 31 Jul 2006 14:08:25 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24544>

I see how the diffs are encoded into the pack, but what did they look
like before compressing? It would be great if they looked like CVS
diffs. I poked around in the doc and I don't see anything. Is this
specified somewhere and I missed it? I see that the diff code is from
libxdiff  but I haven't figured out how it is being used yet.

I'm trying to build a small app that takes a CVS ,v and writes out a
pack corresponding to the versions. Suggestions on the most efficient
strategy for doing this by calling straight into the git C code?
Forking off git commands is not very efficient when done a million
times.

-- 
Jon Smirl
jonsmirl@gmail.com
