From: Osamu OKANO <okano.osamu@gmail.com>
Subject: git log --grep refuse non-ascii pattern
Date: Fri, 8 Jul 2011 21:38:40 +0900
Message-ID: <CABohpOEBLEgg_Nvd2bRRxRd9zpq_GWxSwTRzjg0bpMR6fu4O5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 14:42:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfAO4-00057D-4k
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 14:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab1GHMil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 08:38:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44838 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab1GHMik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 08:38:40 -0400
Received: by iwn6 with SMTP id 6so1713783iwn.19
        for <git@vger.kernel.org>; Fri, 08 Jul 2011 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Z/eg2oUvJYtaKkEAgwIRqpUvRuRnARfKo3P8Be/SXQY=;
        b=dH2vl065RsIt51GTnqK8Yi2EiMhkEV6UQ/7qNuV1+uGGOTpUcChg3cTYvgZOl2FRtx
         MWs5JXAEX+VRu7dY4WW6nBqVFcOHfRZMnksFsG264rOazNMMtgvKpy7jbGb2moZWL01D
         b9OQAKzpskghKzRPM2BpPK8IiiPU80xOItHrc=
Received: by 10.231.67.18 with SMTP id p18mr1814797ibi.48.1310128720173; Fri,
 08 Jul 2011 05:38:40 -0700 (PDT)
Received: by 10.231.85.144 with HTTP; Fri, 8 Jul 2011 05:38:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176798>

Hi.
I found a issue about git log --grep.

On OS X,
$ git log --oneline --grep=コミット |wc -l
     684
It's ok.

On cygwin
$ git log --oneline --grep=コミット
fatal: command line, 'コミット': illegal byte sequence
It's not ok.
This message is produced by iconv().

Regards.
