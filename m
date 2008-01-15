From: "Chris Ortman" <chrisortman@gmail.com>
Subject: First time compiling source
Date: Tue, 15 Jan 2008 14:34:12 -0600
Message-ID: <c0f2d4110801151234i2292ad2aw48e38f4f4fcb5ee7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 21:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsUb-0002Yt-FU
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYAOUeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYAOUeN
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:34:13 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:19408 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYAOUeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:34:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4532823wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=oohotJSLseokshNmRHsCZ3uCq2ibvlmDqt891d27Bhk=;
        b=OoJvYoj9ETV4/OwmTCnCEHkY89p+llMvoLYdD3neuJVW2zd5n1PUSX5Z3zf4ECanCk5aYA0WJcixIfiTcdO32RKG9DPdHSm1X4qhhHTNZwfsNdB6rOYK6N14vvqKSa9k/6ox/DXYVVcY6fsIWC7CBiyXWkPIkNFKbfcM/7A/IIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M8stnkKDTBCpw1IfXff0zZ/HHKBpueojx6qL1MOyBsYYC/Q5cyphI9+RRogNhx+JTfzuyae4NNpZuT01z7AvTcniIjfPoaaHmkbzF45693ndpyL/liIvya7hmmjkWzdvQIRpI2i4Al8ktQFRhvoxpq3K4Zk/lBNQTTSo6r8m/Yg=
Received: by 10.115.90.1 with SMTP id s1mr5295710wal.41.1200429252679;
        Tue, 15 Jan 2008 12:34:12 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 12:34:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70554>

Up until today I've always run git off whatever debs come with ubuntu.
But if I'm going to try to do some work I figured I should be
compiling from source.

To compile I did
git co -b current v1.5.3.8
make
make install

then to check
which git
/home/chrisortman/bin/git
as expected

however git --version still reports 1.5.2.5

What did I miss?

Thanks
