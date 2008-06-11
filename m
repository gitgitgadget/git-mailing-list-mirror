From: "Alf Clement" <alf.clement@gmail.com>
Subject: Question on subprojects
Date: Wed, 11 Jun 2008 17:09:55 +0200
Message-ID: <556d90580806110809o57b561b9peb4eda4368461fa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 17:12:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Ryh-0003xM-Sd
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 17:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760649AbYFKPKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 11:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbYFKPKA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 11:10:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:24338 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760643AbYFKPKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 11:10:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2149411fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=QW94UvO3/TrTuYXYrFYmahh8r1bRuyhwZ7EWq5zPK8Q=;
        b=IWBB+8hxUOsku92ew4sHlIfj75aKXFYY3Hk412ma9qgt6TfKLr2hsgp0WvU8Fbc4/z
         6k/MJeNMaPEhdw/7A0OhoaG2fA37oW0qQTcZZSFt8450eBDC96yeTnm+NQv4SD5E5CUT
         /U1m93ehxMXKdGH2TAtD8/QWQu5/x0wN3Mtq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=AgJTBA0CYVbZPG4ooy330B9WCxIf74CyuaOH23wvZbMEAtHh8EwMPj6rQOZmR7JIf6
         HXtxQr1kz0aNaLYNMHrf3IKCPNvowyrDUNI/4h8phwviVgTSYSKm1kvMM0nVDc20IBYq
         EgcSDgdeNj8QiaRPBG6AfvfbUKHYqR0sh63Ps=
Received: by 10.86.23.17 with SMTP id 17mr381563fgw.44.1213196995574;
        Wed, 11 Jun 2008 08:09:55 -0700 (PDT)
Received: by 10.86.96.14 with HTTP; Wed, 11 Jun 2008 08:09:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84617>

Hi all,

I have a little problem and maybe someone can advice a nice workflow for this.
I have a directory structure with 6 git repositories, which are
dependent on each other.
Now I think it makes more sense to have a single git repository for
them in the main directory, as each project is
also not very big.
Any idea how to do this and keeping the .gitignore files for each of
the directories?

CU,
Alf
