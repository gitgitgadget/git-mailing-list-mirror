From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: status letters consistency in log and ls-files
Date: Fri, 26 Sep 2008 14:28:50 -0400
Message-ID: <ee2a733e0809261128h4c50d27bq3942bd1b3b66d3ee@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 20:30:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjI4o-0001zl-SI
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 20:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbYIZS2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYIZS2x
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 14:28:53 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:12172 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbYIZS2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 14:28:52 -0400
Received: by mu-out-0910.google.com with SMTP id g7so862669muf.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=fO1kQoGdkNBmYwWnhoeHfyVZRkF5pesvgZFUBqqgEdM=;
        b=Ux5VZkRuHGlLalg4HsKZ4LzF0TtEGRLZn+RINOqu1TAjDC+OB0zVMEO2+4un/a/STW
         V5V6CMQLzj1m1CIdTVDbJTGjNhGXlFN5m+dcHgSLr68oLGEb0LotQejNiESHfz18ZKEe
         gsYtlSFgv24SW6k1EaG6H6Qg+Id722ijGsoIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=WO3UFHvZemscVbgjk4wWrjY5r5RWc+i3zxaL7Bkaq7BDjZcpo9NNfRq3/pera9uMkQ
         +ApIIpTIFTK9+vzGyh+vSSOF7RNgdip/C8jda13H7l2DvhEv+xWWa85ytdMmWN/rCr0d
         h8FQeqwXfbO6qdG/OUqezBOo0uY3PnfKx+Dxg=
Received: by 10.187.158.11 with SMTP id k11mr257048fao.54.1222453730054;
        Fri, 26 Sep 2008 11:28:50 -0700 (PDT)
Received: by 10.187.162.17 with HTTP; Fri, 26 Sep 2008 11:28:50 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96882>

Hi Everyone,
I am new yo git and there are few things I find quite odd. For example,

command "git log --name-status" uses the following letters to indicate
file's status
A  -- Added
B  -- have had their pairing Broken
C  -- Copied
D  -- Deleted
M  -- Modified
R  -- Renamed
T  -- Type changed (mode, time stamp)
U  -- Unmerged
X  -- Unknown

At the same time command "git ls-files -v" use different letters to
indicate the same
H  --  cached
M  -- unmerged
R  -- removed/deleted
C  -- modified/changed
K  -- to be killed
?  -- other

So, depending on which of the commands above are used status "R" could
mean either Renamed or Removed, "M" is either Modified or unMerged,
"C" is either Copied or Changed.

Is it possible to make it consistent across related commands?

--Leo--
