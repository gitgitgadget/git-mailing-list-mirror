From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Clueless bisect error message
Date: Wed, 11 Oct 2006 14:08:11 +0700
Message-ID: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 11 09:08:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXYCN-0006vN-PV
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 09:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030666AbWJKHIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 03:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWJKHIM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 03:08:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:2866 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030666AbWJKHIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 03:08:12 -0400
Received: by wx-out-0506.google.com with SMTP id s14so131848wxc
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 00:08:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tp1nfQgPcuiSae2vZI9is1RAXVxESw9jTfkcBPOcSUWDYjbdDckaMtKsThr129gnp5xYMnQC/tnqpJ7AkaaD++bwaasBt/k/11Oo2/kdB++PstDpmDvMDcCjE4mSFnZRo7zZ36ITbRKUQ6Yfckl2v+EXHLKGP2dt4OtoffM9j8o=
Received: by 10.70.78.4 with SMTP id a4mr83727wxb;
        Wed, 11 Oct 2006 00:08:11 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Wed, 11 Oct 2006 00:08:11 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28695>

$ git bisect start
won't bisect on seeked tree

It complained because .git/head-name contained 't' which had been
deleted before. git-bisect reset works. However I'd request git-bisect
to inform more useful messages. At first, I was completely stunned:
"what is a seeked tree? how can I fix that?"
-- 
Duy
