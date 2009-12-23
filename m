From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: Re: git svn mkdirs ignores compressed unhandled.log files
Date: Tue, 22 Dec 2009 22:12:02 -0600
Message-ID: <661FC27C-6C5D-4703-93BE-48B1812C3800@gmail.com>
References: <8BB233FB-4269-4B14-8703-A4FF1E25FB0D@gmail.com> <20091217200852.GA5797@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 05:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNIaI-0006Um-5v
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 05:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZLWEMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 23:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbZLWEMT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 23:12:19 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:58984 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbZLWEMS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 23:12:18 -0500
Received: by iwn1 with SMTP id 1so4901982iwn.33
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 20:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=G3NC8Z9Vyxwtpgua1rxpGCmxLr/2Bds7HN/YBlkeAMc=;
        b=hKRckltFxHB80IQ3SwbT41vRQkMZCsJTzO0iY/OVJkXOQrRaMz/uyOydw169X66QxG
         9lCgg4d1NwAPFCSMyh9I1cUPjBwDt83WME38jriY6Vdwe5Sa9fKau4UIm4IJC6qKCWBh
         f5yr+xxH96FAOXN+4uqwfdPghAIdiEkIzgAII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=veUcwrwj3hshYvBlj4ZO+fcR98f3F2xAMnQKoXXqm8AG5i0MPFCpgrN5K+WQ02dkt3
         JAErSt0gIKBHuLnCC9fzmg3j9IGJhlZOAtsq4W23GpFVf942l3dBtuXnU/zOXHxMdOOO
         LEzGfgeo7eY3V8RAXMoMHEFbUYi/7Mk0nY2zU=
Received: by 10.231.120.90 with SMTP id c26mr713026ibr.1.1261541526801;
        Tue, 22 Dec 2009 20:12:06 -0800 (PST)
Received: from ?192.168.1.4? (adsl-99-145-172-84.dsl.chcgil.sbcglobal.net [99.145.172.84])
        by mx.google.com with ESMTPS id 20sm5997267iwn.13.2009.12.22.20.12.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Dec 2009 20:12:06 -0800 (PST)
In-Reply-To: <20091217200852.GA5797@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135611>

On Dec 17, 2009, at 2:08 PM, Eric Wong wrote:

> Robert Zeh <robert.a.zeh@gmail.com> wrote:
>> It looks like there is a conflict between git svn gc and git svn
>> mkdirs.  The git svn mkdirs command only looks at unhandled.log files.
>> Shouldn't it also look at any compressed unhandled.log files too?
> 
> Hi Robert,
> 
> Yes, an oversight. Does this patch work for you? (Highly untested)
> 
> Would you mind writing a test case, been a bit busy with other stuff.
> Thanks.

Eric,

Your patch works for the existing t9146-git-svn-empty-dirs.sh test, and the test
I've sent as a patch in another email.

Robert