From: Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] OS X El Capitan + Xcode ships without SSL header?!
Date: Sat, 21 Nov 2015 19:58:51 +0100
Message-ID: <BBD3F9B1-9FCA-4207-B374-3ADCF19F1431@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 21 19:59:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0DND-0001aK-3Q
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 19:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760117AbbKUS6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2015 13:58:54 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35619 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbKUS6y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2015 13:58:54 -0500
Received: by wmuu63 with SMTP id u63so11858996wmu.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2015 10:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=BlO2lO/2SHUGBjott64D7b5dWeTei9mDqcBegjS2xu4=;
        b=vSstPuOM+Xuasut3Vf4cwWPCs4PSiztwRF1jEdmraMRPoQZAxvlCohLVOTzVjB40oy
         K82RrbCDv7ho6XL9NqRffoAaH8avBwgxgAvfcsotafOr1iQ8CLi8kGr7dcPzS77eYm7f
         FYWtqLCTakL7wDBfcBRjk3Yae5+uUWAWGM36OvtPmPaV8WW1P2cBsR48eiRRnfJhSpBN
         atcdkiVAJBUvaWnTlv1jmL1pn5wx+lIWnNKmVUW+3o6RYUMM9jS6GB2uTBznDEMhyBee
         qhRmeWGDzKgDnDHOiNVAWbM9v787ahko3akLX+M5W1kb7IYtzFY5dQocmejelVDKk+nR
         iXLQ==
X-Received: by 10.194.243.227 with SMTP id xb3mr23403651wjc.96.1448132332894;
        Sat, 21 Nov 2015 10:58:52 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB64E1.dip0.t-ipconnect.de. [93.219.100.225])
        by smtp.gmail.com with ESMTPSA id v196sm5311941wmv.10.2015.11.21.10.58.51
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Nov 2015 10:58:52 -0800 (PST)
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281558>

Hi,

I cannot build Git on a clean machine with OS X El Capitan 10.11, Xcode 7.1.1 and Xcode command line tools because of missing OpenSSL headers.

It looks like as there are no OpenSSL headers at all. I only found this weird non working version:
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-migrator/sdk/MacOSX.sdk/usr/include/openssl/ssl.h

I installed OpenSSL with brew, added the include path and it works.

Can anyone confirm?

Thanks,
Lars
