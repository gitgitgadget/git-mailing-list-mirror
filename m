From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: 'Use of uninitialized value in string' line 651 git-send-email (from the 'next' branch)
Date: Tue, 18 Mar 2008 15:44:36 +0200
Message-ID: <f36b08ee0803180644r23c21a21y9d753492be2189ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 14:45:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jbc81-0001Zu-F7
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 14:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYCRNok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 09:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYCRNok
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 09:44:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:26262 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbYCRNoj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 09:44:39 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2329323nfb.21
        for <git@vger.kernel.org>; Tue, 18 Mar 2008 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=8jWGmpoNebkmRjY7QeY97OcEOz0kHN7Gr1CYVQG1XOo=;
        b=EMlJpF+hbRQa4HEblXz9XYw0TTLn26seTEV9LdxilXf92/MuiTQ2PXKhxu7EtIlhPAbdaonKW6LGrPnn8we9DhFKVi7V5cfcFIpSAtCrFLYCXJLhxzt/GrW5Q5SWTVD3piDIoUmH2Wvy2+Ww2P7m6lnilEIhP8+roHWcKvrqEBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=v0FfTth1DyVh974weJIdY/tjf4kXVtwlpYQi6QKWFspTdNhKL75oWgNIPwc/oi3pG2TYU4g1ri+Ck9ojTI/USViCJjs9hrCfXtu27SUUN+rPeQ6Gcg34sLiRMJVm7VecIibUV9+oZHfLgSz5fMR9Iz7kCd3SfbdWlwA8KXd9jbE=
Received: by 10.78.162.4 with SMTP id k4mr1877449hue.43.1205847876324;
        Tue, 18 Mar 2008 06:44:36 -0700 (PDT)
Received: by 10.78.199.17 with HTTP; Tue, 18 Mar 2008 06:44:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77498>

line 651 git-send-email (from the 'next' branch), generates
Use of uninitialized value in string eq at .../git-send-email line 651.
sometimes. There are several ways to hush the warning.
It's $cc undefined, as returned by  extract_valid_address() in previous line.

Yakov
