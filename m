From: Jesse Wilson <jessewilson@google.com>
Subject: Gitweb complains "404 - No such project" when following links from Gmail
Date: Fri, 18 Feb 2011 17:12:25 -0800
Message-ID: <AANLkTinuPsWnaSAhmL3b0Bf3FWUEByRE50j+qD_ov0Qi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 02:12:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqbNY-0002sS-GJ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 02:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591Ab1BSBMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 20:12:50 -0500
Received: from smtp-out.google.com ([74.125.121.67]:37616 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab1BSBMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 20:12:49 -0500
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id p1J1Clwv000366
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 17:12:47 -0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1298077967; bh=stO7WX7G2z9PAjcH26iBNm9H5P4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	b=mWz4fgnTUK6vKLwHXZFH1LDvfllzuB/CUMiu6BUHDagG2zoAYpLzu/Q7WY4bZaG7U
	 mDc1qpxxtIwEyoNWgY+Mw==
Received: from pwi10 (pwi10.prod.google.com [10.241.219.10])
	by wpaz1.hot.corp.google.com with ESMTP id p1J1CVnh006792
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 17:12:45 -0800
Received: by pwi10 with SMTP id 10so140272pwi.0
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 17:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=AN7NcUsw7vYWlvlSKHr81Zz3/pcmTIjJqB7Hbam9VVg=;
        b=jvk4bsI1btIDWpAxnWOSgUdTgjD0wZS6WhBECzmXEmUq522k/6x+5VYg9aXoOPT8ST
         e69zpt2Bu2C9esK/Rz/g==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=DNT+bsOksUke7MejXbaArB+tdPcz65QlgPEcZI7aXNPuuG33XM59xaveboPUTzYXAO
         2vSD6+LVuKQ83Nd4FF6g==
Received: by 10.142.173.3 with SMTP id v3mr1020095wfe.62.1298077965104; Fri,
 18 Feb 2011 17:12:45 -0800 (PST)
Received: by 10.142.245.1 with HTTP; Fri, 18 Feb 2011 17:12:25 -0800 (PST)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167244>

Gitweb experts,

I've seen the following error on all git web deployments I've tried,
including the Linux Kernel and Android:

    /android/git=C2=A0/
   404 - No such project

Reproduce this by following this this link from the=C2=A0Gmail web app:
http://android.git.kernel.org/?p=3Dplatform/frameworks/base.git;a=3Dblo=
b;f=3Dcore/java/android/hardware/SensorManager.java

Pasting the same link into a browser's address bar yields a valid
page. Even reloading it yields a valid page.

Any ideas? I couldn't find the bug tracker for gitweb.

Thanks,
Jesse
