From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Solaris test failure -- FAIL 61: invalid bool (set)
Date: Tue, 19 Feb 2008 16:22:20 -0500
Message-ID: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 22:23:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRZvW-0000VX-BY
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbYBSVWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbYBSVWW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:22:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:64803 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbYBSVWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:22:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1733320rvb.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+7yjm9rse8oigI/nfGdwnPFmX2eVEQOS8mEDOSWAtZY=;
        b=gWfhFhmsmFW5dcgH4KTH2udvNqZ/cfaxASXBjGqqTLR3uwv/kHY2Wl/W+PbWmrTyP6f+oTE1sh8qwMoElz2WtxjNRya0XHBp8SZxlNOcdwzF+QLlkX5twbFEbK8OAg+Om6XPQqu9kARDdsiGiHurpqnjh5AYYQKvNydJK7A+AuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VzkrqwVaVuHNtO3TLj3+OBt90wyFrQZTLjEubs6kv6tCi/A6jLR5Gs23ReCVx67DlUHEfHvHDeij6G1JZDqqdyIDsqW+T8YL0DD1hUCUPag8yYOqEECtIvXMcgbqJCLL/T7bKy9o56DhLoEmf3EaTPFas/8K9HZe8ifUjj7fFlg=
Received: by 10.141.88.3 with SMTP id q3mr5084402rvl.3.1203456140184;
        Tue, 19 Feb 2008 13:22:20 -0800 (PST)
Received: by 10.141.195.19 with HTTP; Tue, 19 Feb 2008 13:22:20 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74454>

Does anyone have experience with this test failure in t1300-repo-config.sh:

* FAIL 61: invalid bool (set)


                git config --bool bool.nobool foobar
*   ok 62: set --bool

* failed 1 among 70 test(s)
make[1]: *** [t1300-repo-config.sh] Error 1
make[1]: Leaving directory `/home/warmstro/download/git-1.5.4.2/t'
make: *** [test] Error 2


machine information:
xs5-trd-p1.grn:warmstro> uname -a
SunOS xs5-trd-p1 5.9 Generic_118558-38 sun4u sparc SUNW,Sun-Fire-V240 Solaris
xs5-trd-p1.grn:warmstro>

Any suggestions would be much appreciated.

Thanks,
Whit
