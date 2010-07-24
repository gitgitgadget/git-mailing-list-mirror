From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: git tag's history
Date: Sat, 24 Jul 2010 17:42:26 +0530
Message-ID: <AANLkTinCTcnr=tyC2+C4u5L0p_mXxTCMfSBm_JzqqMDW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 14:12:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocdau-0005PA-5j
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 14:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab0GXMM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 08:12:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47098 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab0GXMM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 08:12:28 -0400
Received: by bwz1 with SMTP id 1so2090001bwz.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=qSTZI8xzOZA/wYk+MUfrdcQ+OlP71MbcVlexqgZSbD4=;
        b=gphxp3fn1Z2waK9FiiBUQO4MQjnHc0nPO5xN5+GzhlZuRHF/ACqbWSJkJHlui+zpe1
         XYIquaXY+e3lvXnwwT6pQpU3JwYaHvnJvfy7wJlg34VErw0c/x+idDKhs10I0Mvv0+Pa
         HvEFJJbd/YA9twp6IpJCBknbruQY7pNKVSfv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Zg6NLILly8/M+jwcakW2TMHvA0hLJ/p80AZOwMldXGr7qfxsPVGpK8jR/u2t0KqSrl
         37PHD8IYlorufveezGNtk+WEasQknQPL9kFG/tQUXyi3j0HtFCBHI1UuvW8SoA+9jCSx
         wI/50FK1LrMweF4/HnI/2AHGTQOmUH2rFPG+Q=
Received: by 10.204.25.151 with SMTP id z23mr3752263bkb.46.1279973546612; Sat, 
	24 Jul 2010 05:12:26 -0700 (PDT)
Received: by 10.204.118.193 with HTTP; Sat, 24 Jul 2010 05:12:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151623>

If git tag's history is preserved or I need to implement this in
pre-receive hook

Scenario
^^^^^^^^^^^^
I create a tag FOO -corresponding to a commit cdf123

FOO->cdf123 and I push this Tag to authoritative repository ; all fine.

Now my buddy creates overwrite my tag (git tag -f) and now this tag
looks at some other commit

FOO->123aff

He does a push tag FOO; assuming no restriction in pre-receive this
push will get applied and my earlier cdf123 is lost. Is there any way
to retrive Tag's history or in need to implement some scheme

Thx/ Mahesh
