From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Adding custom hooks to a bare repository.
Date: Mon, 28 Jul 2008 12:04:01 +0100
Message-ID: <18071eea0807280404w3365748cjcd11f536bf5d27eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQXI-00065Z-8w
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbYG1LED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbYG1LED
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:04:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:62836 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYG1LEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:04:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5660452wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=3xOrqtld41Ja+dGM7IeOAF/BuC+i6Wke59jMbHl+67w=;
        b=HRI3yfuNQP8MzdLts5Le/nwlwF1PyVU5pMW9548+cJvV5gAmzo7l8jqmUCH9HN3jQ2
         ThP6RA94TOQa/eg4G3zFt7J+ME+c0yQn13mZVkMz2VF8+N3D+72PeHUD4Vj3Y6OfzzZT
         L/6t+Pvng8hiN5MYcc2M3OZqhpyKuuvojyxYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=wSn7EfYTkf2Rz7ndk8fJi0KsjxPBpEUGCvbh975YHxpLnebAtPDK8re+GuNiW6ZhEY
         wUkE+xH3CRG61rt18GDrW2eD2IMUDQBgnuMSfkdzMhvR/Gjd1c98zEgRXjnc3rG14mEC
         kYXBfmpzlKJyc7lTvapaZx3nc5owwwhFxY5bE=
Received: by 10.142.157.15 with SMTP id f15mr1551534wfe.96.1217243041125;
        Mon, 28 Jul 2008 04:04:01 -0700 (PDT)
Received: by 10.142.104.15 with HTTP; Mon, 28 Jul 2008 04:04:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90438>

Hello all,

I'm trying to add in "post-merge" as a valid hook file to an already
created --bare repository.  In adding it to the correct place and
setting the correct permissions on it (the repository is a shared
one), it doesn't seem to be pulled down with the other hook files
already present when doing a "git clone".

Any ideas why?

Indeed, I also, as a test, added this post-merge hook to a repository
and created a --bare repository from that - thinking that perhaps the
hook file had to present at the time of creating a new repository, but
even then it wasn't copied over to the bare repository.

What am I doing wrong?

Thanks in advance,

-- Thomas Adam
