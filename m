From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: collapsing commits with rebase
Date: Thu, 8 Jan 2009 10:38:44 +1030
Message-ID: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 01:10:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKiTO-0005oR-Pi
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbZAHAIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756806AbZAHAIr
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:08:47 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:23939 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbZAHAIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 19:08:45 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8118058rvb.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=/a6m/dY3yRFfscsCpR/UNyXRBf7xAQGRu+ULzc8d/U0=;
        b=MwTSy2p5lO3/NWm6HmcbuqZUm+dizAjYkMbnqtBnLu1JFzLkAMRpthBOJklGl8S/V8
         AKj6O0UueHt6LP/OLiw9vIz6ixurSG+BQgC9A/DTk7UaLEO0aP2tGunIPNIRynYrts6G
         nezMvcuuFSv+mjrEUz6D2iKvBNPFpsO+kdxto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=XE3HHg92KIKSMPndcwrL/4R096gIlE22jb1M0szQRh+Dr25y7dtLhvuMZPrvzw4QUt
         xfPPjgD/SrO+VTuXzL3eNusHUL9srVeAPnk9twjNecir2kDC98cFJOMwcawszOLFiDcO
         s/sIzObycs7f09Y5s3EAs069A6TJG+iWbUPIM=
Received: by 10.140.142.11 with SMTP id p11mr11754150rvd.276.1231373324827;
        Wed, 07 Jan 2009 16:08:44 -0800 (PST)
Received: by 10.140.136.16 with HTTP; Wed, 7 Jan 2009 16:08:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104854>

Dear gits,

I have a series of commits:

    A---B---C---D---E---F

I want to collapse B---C---D into one single commit. git rebase -i B  will allow
me to do this, but I'm looking for a non-interactive incantation.

Cheers,
Geoff Russell


P.S. The context is a program that performs a single high level
operation on a repository
as a series of commits but then wants to turn  it back into a single
commit without
user intervention so it subsequently looks like a single op in the history.
