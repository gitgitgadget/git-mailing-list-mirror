From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Limiting disk usage
Date: Tue, 29 Oct 2013 07:22:51 +0100
Message-ID: <0a4899b7-f75f-4016-9c99-5e6e3fb9603c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 29 07:23:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb2ht-0003rC-G8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 07:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab3J2GXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 02:23:08 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:48115 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3J2GXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 02:23:07 -0400
Received: by mail-ee0-f47.google.com with SMTP id c13so1479454eek.6
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:mime-version:content-type:content-transfer-encoding
         :subject:from:date:to:message-id;
        bh=HA7m7j/y2+HlJwlInK+LCZWykIGkvG1Y7aazrNemQRo=;
        b=0t+hHvU1QMJWOUUhDg0iHkVSOJlrbIEYqh68/qS/YpDEXY0O9z1AjaU8WGooLZht7T
         /22Yi/K+ANXuM/2b0D2fdFpgIWm5lxDYnMIZRa0a9YG73avbEoWYtUYUogjzXBQG4pn8
         e9yeq4N4gSU7r6h/1zK92eWw42AqR4aoC7vdtvDPxM+kIsT52x1LdNxakh80knFvHm1F
         ClnR1DDw37CJRyWECq5NC+CTDVCOnFxsFzio4Rd7D+ovMSJgos50mGO2tiLkAjDFmx1s
         +FJDMms1H0w2DgfgUEeZVXmgAbLMeFY1LRBMccU8cT/ZzRSC5B+zUDrfmaEProZIDCyo
         52+w==
X-Received: by 10.14.205.194 with SMTP id j42mr93129eeo.119.1383027785631;
        Mon, 28 Oct 2013 23:23:05 -0700 (PDT)
Received: from [100.72.206.51] ([5.172.252.51])
        by mx.google.com with ESMTPSA id u46sm66180147eep.17.2013.10.28.23.23.04
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Oct 2013 23:23:05 -0700 (PDT)
User-Agent: K-9 Mail for Android
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236894>

Hi, 

What can be done to limit amount of space occupied on clone and checkout? I know about shallow clone and sparse checkout, anything else? 

Preferably I would split repository into multiple repositories but I worry that working with multiple directories would be much more troublesome. But maybe I am wrong? I don't have much experience with submodules, repo tool (what else?)

Thanks 
-- 
Piotr Krukowiecki 
