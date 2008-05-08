From: "Doug Reiland" <dreiland@gmail.com>
Subject: How to capture date/time of push vs. local commit?
Date: Thu, 8 May 2008 09:48:19 -0400
Message-ID: <6844644e0805080648g72c4b767l4bcf48ade319bf77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 15:49:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju6Uf-00049q-T9
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 15:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbYEHNsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 09:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYEHNsV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 09:48:21 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:12147 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYEHNsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 09:48:21 -0400
Received: by rn-out-0910.google.com with SMTP id e11so192397rng.17
        for <git@vger.kernel.org>; Thu, 08 May 2008 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=rdeN8tfL41TPRNBJ7gFyq8JC/UthQ2Rbi9tgx9JvTKI=;
        b=i+Q4gxJtYrWYi0ipftXMCuLx4Zm6/DFKHVO5gEjw5VmB2qiE1fyAwS4LkfoUdTT/S7XatDKfcxc692eVeg5qFgoSoGwaf+qb93/v9dd5oeQ1xoZtZA3m2d88PPj9XZev7Szn9ksuJ293fglU1UUMfuOz6gmqLp0oG8cy1gBZgpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B/uEouD8I8NLOt3HD0TnJAbanovlSwXFaf96i2/TZE7r6y2chGM2XU6e6G5lQpKRQL5sE3HXMxqGxntKaMXbu3blCtB/WwIZSNpIcCNz9VdrXklNlTBjh4zIKzBEiiNPPNnxJkl4V7tj2c71aEFYHGVFEyEohg55/0oVioUNU/c=
Received: by 10.115.77.1 with SMTP id e1mr3036044wal.208.1210254499293;
        Thu, 08 May 2008 06:48:19 -0700 (PDT)
Received: by 10.115.73.6 with HTTP; Thu, 8 May 2008 06:48:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81528>

I have a main repository that folks clone and push to. Using git-log
for example on the main repository can show some confusing (too me at
least) date.

For example, I clone. I make changes to my repository and commit on
Monday. I don't push my changes to the main repository until
Wednesday.

git-log on main repository show changes made on Monday.
This makes it hard to determine when folks really got stuff into the
main repository.

Is there way to change this so (in my example), I can determine those
changes weren't in place until Wednesday? Something in configuration
file or perhaps just a different option to git-log.

Thanks in advance.
