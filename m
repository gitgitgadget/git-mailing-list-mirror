From: Jakub Narebski <jnareb@gmail.com>
Subject: GIT_TRACE_PACKET is not documented
Date: Sat, 4 Jun 2011 16:17:27 +0200
Message-ID: <201106041617.27944.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:17:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSrfg-0000kX-So
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 16:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab1FDORo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2011 10:17:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53599 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364Ab1FDORn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2011 10:17:43 -0400
Received: by wwa36 with SMTP id 36so2506414wwa.1
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=+CDaS3jIuCFZcQPaHrauYcAjQ62KDI7mAkJGjbt6DqQ=;
        b=FbRudWZyXsBP4gaLoS7vvFPT0x/vL4sQ6Trs02H0Gu6wtiSLzkAWdVdkl2F2spbhNN
         F3+shtxfdSQaLc8eI1RAXfBrAHmi8ENZ6QjyEaIbGbskWrSOfksZDMMvyz+YoHVciVCz
         T/42ZqpTEdkcbUqU2VjJXaCz2IpgoSqVUMfVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=fflx6OWAkqX194RRnKft8Hy2XIL+dKOjRa0oc2b0Szix8heqJmCchJlQ3AOz6jZDTt
         cYmMu5iK9KCWB+h4SIrDHnWU7zxUX2Znu9dQYilZjGr8ZMmC2HL7FIq+Fe67SQLQYoAQ
         YrBgYooUjJHtGjhelUumOOUwb1hyyDxVYB5P4=
Received: by 10.216.202.147 with SMTP id d19mr2985715weo.23.1307197062041;
        Sat, 04 Jun 2011 07:17:42 -0700 (PDT)
Received: from [192.168.1.13] (abva119.neoplus.adsl.tpnet.pl [83.8.198.119])
        by mx.google.com with ESMTPS id y3sm1348652wec.10.2011.06.04.07.17.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Jun 2011 07:17:41 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175058>

While GIT_TRACE is documented on git manpage, and mentioned in RelNotes,
GIT_MERGE_VERBOSITY is documented on git manpage and mentioned on 
git-merge manpage and other...  GIT_TRACE_PACKET isn't documented 
_anywhere_:

  $ git grep GIT_TRACE_PACKET
  pkt-line.c:static const char trace_key[] = "GIT_TRACE_PACKET";

-- 
Jakub Narebski
Poland
