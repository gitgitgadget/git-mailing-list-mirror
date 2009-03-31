From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] format_sanitized_subject: Don't trim past initial length
 of strbuf
Date: Tue, 31 Mar 2009 16:29:31 -0700
Message-ID: <49D2A75B.20209@gmail.com>
Reply-To: 1238541878-11025-1-git-send-email-bebarino@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Wed Apr 01 01:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LonRL-0001D4-Qz
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 01:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764484AbZCaX3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 19:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764449AbZCaX3l
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 19:29:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:29522 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764352AbZCaX3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 19:29:40 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1814025wah.21
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=YvgbSAZk/KxTSmfYxnf+Cfy+51CBChs8C9s4ZI8qvZc=;
        b=F3TDDTZ/2M9byQ+5zNeUbby7fSIi63iwAc6paAS684DfEwBZqtSt5oz3Em9xjdfVik
         HemYEci0SLjxKfhUAhGtIXF3clCLgWAMGSiMER5lgRCXRsJhnd7Zzhf0Y2uywG+pIbDE
         lGYvDVLBaQnTsSbfO1eWZ9nYTbVXTWr2lguWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=GiRV3zDoinalak123xRBsvOI9kqB3dls2mMvGz5nF7MQCD55QNWFLytCln4ohATk/9
         4sD0+XMnhm6EXl8RrunhoW3NQ91l+VB/JDFk71ki9EmapzDlLsYx3MXZiHCqVScmsoX9
         Zto+Nb1F14cimkw31Y5zy8ym/AUCJ4czOCqS8=
Received: by 10.115.18.3 with SMTP id v3mr4729330wai.178.1238542178276;
        Tue, 31 Mar 2009 16:29:38 -0700 (PDT)
Received: from ?192.168.1.3? ([76.89.212.195])
        by mx.google.com with ESMTPS id v39sm6440687wah.40.2009.03.31.16.29.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 16:29:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090321)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115329>

Forgot to say this is based on next.
