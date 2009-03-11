From: Tom Holaday <tlholaday@gmail.com>
Subject: git doc build failure on OS X 10.5.6 (Leopard) during xmlto phase
Date: Wed, 11 Mar 2009 10:21:57 -0400
Message-ID: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 15:28:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhPLG-0003pb-CW
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 15:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbZCKOWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 10:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbZCKOWA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 10:22:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:19859 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZCKOV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 10:21:59 -0400
Received: by wf-out-1314.google.com with SMTP id 28so29877wfa.4
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Io7NpIskjHGpnW2hGleFCLeM2hpMOoOnJG/4iq7DgIE=;
        b=cRjMgl7+MwrpWQlfhf1Fz0fK8webCUH4Xr/jfvJtzohtUyNAQoz6+VstQ2PCqxzzmP
         qzOu7gGhUPovX9QAzpRWLIP8BRhIlNJVS7P8tAQ99Q4lDDIr1UdGZaiVgzOVHj3ok4LI
         U8sNo6y8J92X/Ew7pZqusZNJ1hl4eZg7qpeEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Y/MDcmu5bItmyqwGEm+RV5SBO7+O3P0DGmhYefOiCgj3yOaKf/y4zdPCfVFAmk9Lnp
         NLYc55YNXKUC8AHEetodOMughpXNOKU6NcqCDY5tr0qQnKm92SNgg287dR8HFcVrKiSh
         E8WeQNRcIrwl0bXfgdPJTorQRimcjcT42arFg=
Received: by 10.142.185.21 with SMTP id i21mr3703611wff.220.1236781317475; 
	Wed, 11 Mar 2009 07:21:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112932>

Hello,

On OS X 10.5.6 (Leopard), the command ...

   xmlto -m callouts.xsl man git-filter-branch.xml

... terminates with these errors:

xmlto: input does not validate (status 1)
/git-1.6.2/Documentation/git-filter-branch.xml:431: parser error :
PCDATA invalid Char value 7
Clone it with <literal>git clone +++0+++</literal>.  The clone
                                    ^
/git-1.6.2/Documentation/git-filter-branch.xml:431: parser error :
PCDATA invalid Char value 7
Clone it with <literal>git clone +++0+++</literal>.  The clone
                                      ^
make[1]: *** [git-filter-branch.1] Error 1
make: *** [doc] Error 2

What issue-tracker, if any, would be appropriate for this?

-- Tom Holaday
