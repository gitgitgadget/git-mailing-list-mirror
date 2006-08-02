From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] autoconf: Add support for SHELL_PATH, PERL_PATH and PYTHON_PATH
Date: Thu, 3 Aug 2006 00:36:55 +0200
Message-ID: <200608030036.56298.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 03 00:37:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8PKx-0005gC-Ae
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 00:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWHBWgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 18:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWHBWgb
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 18:36:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:33065 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932095AbWHBWga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 18:36:30 -0400
Received: by nf-out-0910.google.com with SMTP id o25so782750nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 15:36:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UFCYmFTJ/wZg35/8hQvwiESFuv+eBrbGXzAt4tmvhqIBK0CCeaTyeYJrzp+DIe+D5FYGKybd12+20HwoLzYHLmCwC7iGzptgmsQKer9iLzDDI711bqK7HgrwL3QRUdhzQDolXn/SmUBYzSbev5RsU93ZnkE8nPtZ57jG7sPHLvw=
Received: by 10.48.210.20 with SMTP id i20mr2980446nfg;
        Wed, 02 Aug 2006 15:36:28 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id p20sm151739nfc.2006.08.02.15.36.27;
        Wed, 02 Aug 2006 15:36:28 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24694>

The following series of patches adds support for setting SHELL_PATH, 
PERL_PATH and PYTHON_PATH from autoconf configure script using 
--with-FEATURE=PATH option to ./configure invocation

Needs revision by someone better versed in autoconf than me.

1. autoconf: Add support for setting SHELL_PATH and PERL_PATH
2. autoconf: Move site configuration section earlier in configure.ac
3. autoconf: Add support for setting PYTHON_PATH or NO_PYTHON

-- 
Jakub Narebski
Poland
