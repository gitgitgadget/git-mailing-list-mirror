From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: [ISSUE] git send-email sends wrong patches and non-provided CC (probably bug)
Date: Thu, 6 Mar 2008 15:11:19 +0600
Message-ID: <7bfdc29a0803060111vc98ef42q96c3ce343fef0859@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 10:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXC8w-00026b-N0
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 10:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758202AbYCFJLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 04:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757914AbYCFJLX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 04:11:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:65470 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351AbYCFJLU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 04:11:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3725153ugc.16
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=JHzk4Kt5uRA+yr9mp5vPQqvYGEALrhRBWltvNFhMDLM=;
        b=QuILt7C68HIrimNwE8m4vqkrhUe4bwmXN1CM6QCeIYRXZXuUQvULvNETfQsFI0xtFVrHM+i95CH5BEqV2tyyqo7PdIUBt1d1kek/zlry51SNYa/FblapNcZKosyq3KwhkmacWqTu7Zibh+WLSfzWX/clcT5PZP33U46z0Jxugmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RgQ1Id4r3PcPIWdSZMU+HgB7+b6lOYcbHU5TuIQAEO8JlUZ33GM74COLk1CWvALgSuC8QhBipJ9ExFqnROGkmKpvdHBL8chxx4FZGOp5++9+HtQcC885+1xJO6SUKh0gcXZoyL0n/YnFv78Ag5mtSdmt6JZFwQzUORc7+2EoE6U=
Received: by 10.78.182.17 with SMTP id e17mr9439616huf.26.1204794679034;
        Thu, 06 Mar 2008 01:11:19 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Thu, 6 Mar 2008 01:11:19 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76358>

Hi,

Firstly sorry to gitster as he probably has received 10 redundant
emails from me of my own patch, which I sent for test purpose before
sending to the mailing list. In this process actually I found 2
issues:

1. git send-email sends CC to gitster though his email is not mentioned.
2. I wanted to send patches from a folder containing 3 patches
generated with 'git format-patch -n -o /output/dir/ -M -B origin'
command. When I use git send-email it rather sends 5 email; 3 for
PATCH 3/3 with same subject but different body. I later generated them
without -n option and sent to the mailing list and that was sent
correctly. Unfortunately gitster has 13 emails of the same content out
of 10 are outcomes of the bug. I am providing their message id so that
he can have a look at them:
Message-Id: <1204793490-20160-5-git-send-email-imyousuf@gmail.com>
Message-Id: <1204788919-23615-3-git-send-email-imyousuf@gmail.com>

If someone else wants to have a look at the problem I can also email
it to him :).

-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
