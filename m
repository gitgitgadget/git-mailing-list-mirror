From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.5.2
Date: Wed, 11 Nov 2009 13:05:26 -0800 (PST)
Message-ID: <m3ljicsrg0.fsf@localhost.localdomain>
References: <7vljiypw9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:05:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8KNk-0004ZE-C2
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217AbZKKVFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759216AbZKKVFY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:05:24 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:61905 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758402AbZKKVFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:05:23 -0500
Received: by fxm21 with SMTP id 21so1486194fxm.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 13:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=r3uh4J4p72a1JNu+/cpaiFNa+KnQvZ0xU9XkCItQueQ=;
        b=iQw3ToHCYlnqnimbBA0L8u/eccxgL4SZWgK3qPDAl4A+oyaZsJ/HIg78tQOeVGtY8F
         ki8xBVNy6F0ZiMuuR6elMqCwEdmgjRpxR9zfm/A6N84uYUy0z5GDmlMq+ID27f0EJk7K
         SZcBe6ezHeqCA1RmIjjd3zLUlXBnbYcJ248WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rZZWiNJkag1yzqJfu5/I0MzpSuU5VYyRPfTlbuGGReG8grCHqjmFEqT5rdCTfpwhCL
         /8s0T94aHPUE3oNA+H5YssbnGSMsfkqGUjqB6XH6h+2MRVkb79xNq/G37N10Q1Prkdw0
         HIPz8h5jSM0GROmFECGs4J4MUkvmyVd0t5hdU=
Received: by 10.204.175.80 with SMTP id w16mr1509249bkz.207.1257973527352;
        Wed, 11 Nov 2009 13:05:27 -0800 (PST)
Received: from localhost.localdomain (abwa45.neoplus.adsl.tpnet.pl [83.8.224.45])
        by mx.google.com with ESMTPS id 16sm689813bwz.3.2009.11.11.13.05.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 13:05:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nABL5MxD001730;
	Wed, 11 Nov 2009 22:05:22 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nABL5Kbk001727;
	Wed, 11 Nov 2009 22:05:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vljiypw9s.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132702>

Junio C Hamano <gitster@pobox.com> writes:

> The RPM binary packages for a few architectures are found in:
> 
>   RPMS/$arch/git-*-1.6.5.2-1.fc9.$arch.rpm	(RPM)

I tried to install git from source RPM... and failed:

  $ rpmbuild --rebuild git-1.6.5.2-1.fc11.src.rpm 
  Installing git-1.6.5.2-1.fc11.src.rpm
  warning: user junio does not exist - using root
  warning: group junio does not exist - using root
  error: unpacking of archive failed on file 
    /home/local/builddir/SOURCES/git-1.6.5.2.tar.gz;
    4afb1f6a: cpio: MD5 sum mismatch
  error: git-1.6.5.2-1.fc11.src.rpm cannot be installed

Error messages are line wrapped for better readibility.

Redownloading the file didn't help

  $ ls -l git-1.6.5.2-1.fc11.src.rpm 
  -rw-r--r--  1 jnareb users 2713416 Oct 26 03:59 git-1.6.5.2-1.fc11.src.rpm
  $ md5sum git-1.6.5.2-1.fc11.src.rpm 
  9f89a01b65e1b8e8934c3a2252064632  git-1.6.5.2-1.fc11.src.rpm

-- 
Jakub Narebski
Poland
ShadeHawk on #git
