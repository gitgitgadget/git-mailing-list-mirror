From: "Ping Yin" <pkufranky@gmail.com>
Subject: git diff-index --raw HEAD and git diff --raw HEAD output the same thing?
Date: Sat, 1 Mar 2008 21:10:03 +0800
Message-ID: <46dff0320803010510q67bc4101k9f85c71e5d20b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 14:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVRUi-0005j8-5N
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 14:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbYCANKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 08:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbYCANKF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 08:10:05 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:57426 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbYCANKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 08:10:04 -0500
Received: by an-out-0708.google.com with SMTP id d31so1013544and.103
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7L+partWKEpVlYA4QHmHb5P2WLE1HQNpaH8of1sIgZQ=;
        b=qZue7PirZYXyW4hvQcZs+zWwhN6b2kPlCOYGM9Eghx4HXhRj83uZb7jHQ1G6f/dMJpXVMfxhr6XXskoi67bv0OG8x2f8Nm+Dlgw1ScBFn2rNhhHmv6l8NbPZTp85Te1hm6kMxJpttv+4p9VUrf5P+aSxqb8cYzEijFVREW6SuXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lDcBJvcTfH21/Y5Mi0YEbeU4fbLHWIrmDY1lrGe78Fmcnq4JiqJUBypdR1h+1dzU7/hcgy5J23cCK0J2c81w73goMTzngwM2OuBHdshqiIfTeisjEDqjqDxb3hmg6gJRxnklu04y5xxFK752ifPCli4Z9u8ixplj3Cx4eKSclQ4=
Received: by 10.100.174.2 with SMTP id w2mr22647584ane.71.1204377003908;
        Sat, 01 Mar 2008 05:10:03 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 05:10:03 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75663>

Does these two commands output the same content except displaying format?

Follwoing is my test

$ git diff-index --raw HEAD
:160000 000000 ad1e416e87dc02617de68c41bb18e5abf0e24729
0000000000000000000000000000000000000000 D      WordBreak
:160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
0000000000000000000000000000000000000000 M      commonmake
:160000 100644 c517f783d9efb5a8d24f80fb67f644a39afec2a6
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 T      util

$ git diff --raw HEAD
:160000 000000 ad1e416e87dc02617de68c41bb18e5abf0e24729 0000000... D
 WordBreak
:160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
c1f46b3f10cc041e196c388490ddb049dacc7dc0 M      commonmake
:160000 100644 c517f783d9efb5a8d24f80fb67f644a39afec2a6 e69de29... T    util

Strange things is this line
:160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
0000000000000000000000000000000000000000 M      commonmake

why mod is 160000 while sha1 is 0000...

-- 
Ping Yin
