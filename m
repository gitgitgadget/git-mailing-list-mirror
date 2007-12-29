From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: NIST's policy: sha-1 until 2010, after 2010 sha-2.
Date: Sat, 29 Dec 2007 05:27:02 +0100
Message-ID: <998d0e4a0712282027y6e625141jcef90bd38fb83b75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 29 05:27:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8TIS-0006Dt-I8
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 05:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbXL2E1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 23:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbXL2E1E
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 23:27:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:37713 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbXL2E1D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 23:27:03 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1083751wxd.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2007 20:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=jxjlkeFGidQLQs/vF4HIxIM2W1E8xpCpGJNcUwhXiMU=;
        b=XURVoyJ+ZwGiKli86QvLklccf3tXH4USq++imX9tlI9Peglio8tKj9jVToVH/jgcBUFufLfgZg59QX9PLdAL+Y3Y1rvQM7cZOH7ew2ORr/6VQuozoNtCta5VMcgZSHwhO1NCBWnjdsA3JUkHv8MRQ+d+eful2WOj4e9/MAWgYko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sR96pZobpXmjmu+cDm8r7WrCI2leTg5uu5bfLm0Ph3tp5WmezUxGwQgmsllvopIyzQleAER1HK0FK18kBsjx7NcLICw66Z+rvs+9whu76IMjUfkSzDuZXkHbsc0vq6qPOuQlFLJxJIPTKAbf+M9boXl0ZLNpkBakCeq624nHV7U=
Received: by 10.70.58.2 with SMTP id g2mr6775716wxa.65.1198902422747;
        Fri, 28 Dec 2007 20:27:02 -0800 (PST)
Received: by 10.70.26.9 with HTTP; Fri, 28 Dec 2007 20:27:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69308>

Dear Linus Torvalds,

What do you think to do when your git has to change from SHA-1 to SHA-2
  because of the weaker collision-resistance of SHA-1 in the next years?

    (e.g. from an damn developer trying to commit a collisioned-SHA-1 file)

http://csrc.nist.gov/groups/ST/hash/policy.html says

NIST's Policy on Hash Functions
-------------------------------
March 15, 2006: The SHA-2 family of hash functions (i.e., SHA-224,
SHA-256, SHA-384 and SHA-512) may be used by Federal agencies for all
applications using secure hash algorithms. Federal agencies should
stop using SHA-1 for digital signatures, digital time stamping and
other applications that require collision resistance as soon as
practical, and must use the SHA-2 family of hash functions for these
applications after 2010. After 2010, Federal agencies may use SHA-1
only for the following applications: hash-based message authentication
codes (HMACs); key derivation functions (KDFs); and random number
generators (RNGs). Regardless of use, NIST encourages application and
protocol designers to use the SHA-2 family of hash functions for all
new applications and protocols.
