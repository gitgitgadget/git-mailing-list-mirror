From: "Ping Yin" <pkufranky@gmail.com>
Subject: git-log --pretty=format:%s doesn't honor option i18n.logoutputencoding?
Date: Mon, 12 Nov 2007 20:04:05 +0800
Message-ID: <46dff0320711120404l5581b1fbpc91c2557bcad2c88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 13:04:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrY1g-0004VN-LP
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 13:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162AbXKLMEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 07:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758018AbXKLMEI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 07:04:08 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:12530 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbXKLMEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 07:04:06 -0500
Received: by py-out-1112.google.com with SMTP id u77so1176426pyb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 04:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=RRPivkyf6+z80L/EwnCCkEk0W4yEEXX60KitMoUjgEM=;
        b=ZRdxOB9hwPDtvPV4YulQzpZPWvPAHi+6iCLrTnCKOP9+M0ghZBgK20ue1tC22FQ/97MrBqM+R9nSVoKH/CIVXiwN8DGpYKMBQi5bXq5Muxcsaxp1s4mFWG22PclKhBJ0bHLGDEKCcI9skE6iN+nxfCwULTkCkdKeotL0HmE+tcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n/RBMgTwbT+JhyTcTT80nZHmtlXhhtmEjwaalkYxmn0+X9mKFexHCvsKJgu2IfH/nzJ3wFzgS6mX2jEPIXytcGH74AcMyPOcwnwGDM5jTyh2k3fumfGjV7UrTqecODkEng7bjkUIhmz6LoskqggEjfuYRqln3b+QVEFnHspdw9k=
Received: by 10.35.70.17 with SMTP id x17mr6006828pyk.1194869045655;
        Mon, 12 Nov 2007 04:04:05 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 12 Nov 2007 04:04:05 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64606>

$ gtcf --get-regexp i18n.*
i18n.logoutputencoding GBK
$ locale | grep LC_CTYPE
LC_CTYPE=zh_CN.GBK
$ git --version
git version 1.5.3.4

And my terminal encoding is GBK

$ git log --pretty=oneline
msgs with chinese character displayed correctly

However
$ git log --pretty=format:%s
the chinese character doesn't display correctly

-- 
Ping Yin
