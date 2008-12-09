From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Getting submodules to follow symlinks?
Date: Tue, 9 Dec 2008 12:55:47 +0000
Message-ID: <57518fd10812090455wd109843mfece11eae9e4f593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 13:57:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA29N-0002DC-Fp
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 13:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbYLIMzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 07:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYLIMzu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 07:55:50 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:9859 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbYLIMzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 07:55:49 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1476309muf.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 04:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=cQZknZ/YpH/yUh6vYxVyy6CK8PM7OET+HvvBskN80qc=;
        b=cmMq2wG8ffdiI/cuCjhqJ0JN4ePoFfQTu0X85y3Ld2SKqXX2kj3SCu4rj6PDknrJB7
         Dgqfl0tXabfbkR8/o9jSxtZ+G0niNRLjq1oR+QC0zL1XMncI/3F5XKqvIUvC8RF25+HH
         oZxmj/Z6gJBc+qwrGmjmzl71gQz4bhpk9DGlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=mGYZ/n6O1cuRQasg7ePn2wG2CiL95sOucCRUPzp3/S715N66Z5qGzy/7m2ZzXhbY3J
         mFSOFWJBij4V2tXnWFFF5DwLIR4/yoAesFtbvb9uyGozqiW/lKRETBxbpgWsjdYxl6/j
         1Ci8di1fqBTyv9KmQt3n+8lHC+YYCGlR2MlMg=
Received: by 10.223.126.203 with SMTP id d11mr94124fas.8.1228827347426;
        Tue, 09 Dec 2008 04:55:47 -0800 (PST)
Received: by 10.223.104.193 with HTTP; Tue, 9 Dec 2008 04:55:47 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: fd40124481e098be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102629>

My git repository contains a symlink to another repository.  I'd like
to make that second repository a submodule of the first, in such a way
that when someone else clones the repository, there's no trace of the
original symlink.

Is this possible?
-Jon
