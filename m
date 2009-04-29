From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Wed, 29 Apr 2009 22:47:00 +0200
Message-ID: <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
	 <49F8B7D1.2090903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzGhJ-0004Pf-14
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbZD2UrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbZD2UrE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:47:04 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52381 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbZD2UrB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:47:01 -0400
Received: by fxm2 with SMTP id 2so1432898fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/Q0vwGWHYKFWd+VBHf8+BNxGLsYre54IcGOIxMswUqg=;
        b=oj/8LhqH7rV9VjVkfCDW9yEV9Q5agv+u+4+iOmtDMEhtET2pnjQSBBP8NriHz/G2W+
         fdgPqgaahzD7d+rFlQ+pOiyFFc0PabKpIU0wEvyGlo2Li1TuUHPUPiy6k/p88cNK+KZX
         5NhETiHaeb5238xldraWJV9SDntFPGVpyh22o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cOE4NYPqPemyBm0oyj5+kGiKcgH7Yon3lmN4TxVMFLJ/s8QOc3wJPrW9PjiO4JGMhg
         TPsRU5u3rCMJ/Nmz2wpVNUZM7FsT6jW0yxU+VPSxURboh78zQalK+466/Xzz+7WnP1jw
         D37w65O6oCAfPllYfO++EOkyjz1tO2qPyYeWw=
Received: by 10.223.114.68 with SMTP id d4mr444715faq.86.1241038020210; Wed, 
	29 Apr 2009 13:47:00 -0700 (PDT)
In-Reply-To: <49F8B7D1.2090903@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117944>

On Wed, Apr 29, 2009 at 10:25 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Given the versions that fail for Martin and work for Avery and me I
> would think it's not a git issue but rather a matter of the svn version
> resp. the svn perl bindingds.

Good point. The machine where this is failing is an Ubuntu Intrepid box...

$ dpkg -l libsvn* | grep '^i'
ii  libsvn-perl                                1.5.1dfsg1-1ubuntu2
                Perl bindings for Subversion
ii  libsvn1                                    1.5.1dfsg1-1ubuntu2
                Shared libraries used by Subversion
ii  libsvncpp1                                 0.9.6-1
                Subversion C++ shared library
dpkg -l subversion* | grep '^i'
ii  subversion                                 1.5.1dfsg1-1ubuntu2
                Advanced version control system

On the F9 box where things succeed...

$rpm -qa subversion*
subversion-perl-1.4.6-7.i386
subversion-1.4.6-7.i386
$ rpm -qa *svn*
git-svn-1.6.0.6-3.fc9.i386

What are the versions in that F-10 box? Could it be an incompatibility
with svn-1.5.x?

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
