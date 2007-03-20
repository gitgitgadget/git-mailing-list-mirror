From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: relocating the binaries
Date: Tue, 20 Mar 2007 09:12:36 +0200
Message-ID: <f36b08ee0703200012o6f479defs6a8edc8fb1179b8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 08:12:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTYWX-00083Y-IQ
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 08:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbXCTHMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 03:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbXCTHMj
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 03:12:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:8276 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbXCTHMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 03:12:38 -0400
Received: by nf-out-0910.google.com with SMTP id o25so225265nfa
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 00:12:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uE6WnEoevjiRF9DUdLeTA2/QoNZ2FgkKP62iDybEAih9R5u0i+5OlqYsaGqxKViXN5JMlVpixiU67TWZQAycsH6y6kdrXYpXDCpzqsNFnxA61Oygh8C3pVj1DfVcMyQDoUOJZ2V2fFH1pXoGFbyziPsNwfIb7yRVVfdMQDmT9FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y7H33YH4OOYAQRrScexmuf9gtdT+prgP3F+v1T2BF01inAqmDcCC0zLRB2SZCAmdBovokyHrYGtPL0BnxiXouC6xIfKronsU3l0X7mKQILtimYFO9MO+uAnIyfEeNPwPqTFUMzPJc9zXBX/PIE2PQlbZanHKFrcY2yqJhDuG85o=
Received: by 10.65.251.17 with SMTP id d17mr4830483qbs.1174374756993;
        Tue, 20 Mar 2007 00:12:36 -0700 (PDT)
Received: by 10.114.47.14 with HTTP; Tue, 20 Mar 2007 00:12:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42725>

Let's say the git binaries were built with prefix=/usr/local.
I wanto to copy them (relocate) to other machine under
$HOME/run. WHich env.var. do I set to tell the git binaries  that
it's new prefix is $HOME/run ? nb: i'm not talking about rebuild.

Thanks
Yakov
