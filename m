From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git-http-push (git v1.5) problems with DAVLockDB on reiserfs FS
Date: Thu, 18 Feb 2010 19:05:40 +0800
Message-ID: <be6fef0d1002180305i5f8d32b8p5b8dd30b5c8ff0a3@mail.gmail.com>
References: <hlj5ov$rca$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Fabien <fabien.ubuntu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 12:11:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni4Hu-0004hk-Tp
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 12:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757182Ab0BRLLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 06:11:10 -0500
Received: from mail-pz0-f178.google.com ([209.85.222.178]:40452 "EHLO
	mail-pz0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab0BRLLI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 06:11:08 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2010 06:11:08 EST
Received: by pzk8 with SMTP id 8so7828961pzk.22
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=UiPGOK2sRBaYveBiuaMQTYwE6QHoabakiFf4CgmX54g=;
        b=PQkoBv+Cni3YenPTDV4YjaViJhibcaUoTSaRb5C5vTd8/gAOzguljg7H4q6hVMkPdb
         P+4wvmhZuGgOP2ZOtSlXRNWmBQJ7HXKE6+OH4LQFgLHMAAmGUw89kh2PvOBN6FlmJ+5o
         wpuBV5d+lZfbQk1nsaMr+XIIpGOxPEV5K6drE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XWuHh/CcUe694idR/3PrErpFw4wjGPXVlHYOSQsPg2WcoswUAy3sn73PLwrkQeQJw3
         U4mg0DAy9WFNJ6/UZX6u6e2auIrvBCTkNPrnjpNyjFXSydL8ItrCL0AfzGCOElVQJmgJ
         Lct6UE/JuHo6TwoXpSKGU7gWuxIDy5DhneL3Q=
Received: by 10.143.21.5 with SMTP id y5mr2816838wfi.324.1266491140989; Thu, 
	18 Feb 2010 03:05:40 -0800 (PST)
In-Reply-To: <hlj5ov$rca$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140316>

Hi,

On Thu, Feb 18, 2010 at 6:45 PM, Fabien <fabien.ubuntu@gmail.com> wrote:
> I encountered many problems when using a git repository served over
> apache/dav on ubuntu 8.04LTS
> * versions in use on server:
> - kernel 2.6.24
> - apache 2.2.8
> - git version 1.5.4.3 or 1.6.6.2 (doesn't change anything on server side)

although nothing might have changed on the server-side, git does a lot
of server-side operations via WebDAV, like locking, moving files, etc.

> * versions in use on clients
> git 1.5.4.3 => causes problem
> git 1.6.6.2 => is ok.

why not just use git 1.6?

-- 
Cheers,
Ray Chuan
