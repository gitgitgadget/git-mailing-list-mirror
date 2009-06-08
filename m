From: Alex K <spaceoutlet@gmail.com>
Subject: git use pattern questions
Date: Mon, 8 Jun 2009 10:06:50 +0100
Message-ID: <e4a904790906080206t51ee260ve64304d8c1147ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 11:07:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDaol-0003g6-BF
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 11:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbZFHJGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 05:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbZFHJGt
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 05:06:49 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:62859 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbZFHJGt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 05:06:49 -0400
Received: by bwz9 with SMTP id 9so2882804bwz.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=IVhRJofWZ3vOpEugIlVHPlHyY9mNAHN4MRTetonEKEk=;
        b=g9P1r6zgc4ZbeiGd5BxTLx+R7qbuOmb/1/qVEYVohnVuOj+jNHj1hlabOqUIt7Ubmn
         tL1gvQr9i4ysWRLOarZHh06fG258q+QWTzT0IUGKY2d0F5mtdHxX6g646iJ+0zHdqpdt
         HLrRBtcwzKDLRhrntzZOyeR1iyhyolyHua2Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=pcBpAREMiQ+FNmuDra1IRAP4tEMlrag8/7Zmtk+YbOSl3GxNzMRptfX5dghA8/vXos
         l6qVMYTmtUJtKjE7cLbpX2VojbIcu+yGmwctjyKCeNG9dx2iL9dPgiwP2NfcIKkfe1iV
         g0QTCWNZgVwBDLzX5vTI/8Q9uQ98yIg6UUatY=
Received: by 10.204.118.69 with SMTP id u5mr6466795bkq.77.1244452010194; Mon, 
	08 Jun 2009 02:06:50 -0700 (PDT)
X-Google-Sender-Auth: 5648e33ca7049124
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121054>

Hello

I would like to publish a repository on say github but I would still
like to hide sensitive information from a config file which
nevertheless needs to be part of the repo. If it was possible to
publish a single branch then I'd make one especially for github and
publish the config file with something like "your password here"...

Would you know what's the best pattern to publish a repository but
still hide sensitive information such as values of passwords, mysq
port etc..?

Also I have a developpement version of the site and a production
version on another server. Is making a branch for the production
version a good choice? I used to simply rsync the changes from dev to
prod and make the changes in the config file for the production
version. This makes sense because in order for the site to run a mysql
dump and some other data not part of the repo needs to be synced.

Thank you,

Alex
