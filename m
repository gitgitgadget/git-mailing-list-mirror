From: "Alf Clement" <alf.clement@gmail.com>
Subject: current repository hash
Date: Mon, 16 Jun 2008 13:51:52 +0200
Message-ID: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 13:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8DGn-0003xr-Tv
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 13:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbYFPLvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 07:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755015AbYFPLvy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 07:51:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:2597 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000AbYFPLvx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 07:51:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3233391fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=nsywSBG0e6QJiHg7JR4MwiYH+CFTeUsQSJIKsahQHK8=;
        b=o7BoxlhoUKkET4Sg4o27MeUa4CnNf6gmtefmd3PFbPyfB4ySJRf1ew9+6aWKudd430
         fgYkDbKLB4uJKPJxZSaEymQ5YfkhwYA0ntwAAAZavJWhfBqMLEql9PxZBVbvODPBjxJT
         wyM+mEwN5A3+5Azv29ebVrkZTJmV0ORZAMlz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=QcBHRDoY+F+24PTLuZGLyFWFmtEN0d3hl5QRjBxjcsz2go4Cw3gPRr8ibqXAfbBSaD
         80cNY+RfW7bHRvFc7AnQxaLKfYFpCH3Hly0WWzsvKorYFeQPIb7G11uNLADEXdAbGtuk
         5FrhfCG8QhUjbS3SrnhP9OtLIfJyQmklUdiz8=
Received: by 10.86.9.8 with SMTP id 8mr7632673fgi.22.1213617112084;
        Mon, 16 Jun 2008 04:51:52 -0700 (PDT)
Received: by 10.86.96.14 with HTTP; Mon, 16 Jun 2008 04:51:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85182>

Hi all,

I want to compile the current repository hash id into my program, to
be able to checkout later this
id an see the exact files for the compile. It should flag if there are
currently modified files in the
directory tree.

What would be the best command to get a unique identifier?
Do I need the 40 digit hash id?
How can I make sure that a shorter hash id will be unique?

Thanks,
Alf
