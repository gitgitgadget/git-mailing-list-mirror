From: Pedro Lemos <pedrolemos454@gmail.com>
Subject: Git Server Authentication & Management
Date: Mon, 4 Jan 2010 16:27:38 +0000
Message-ID: <1a710981001040827q23f61bdew8db1ae76d5bfb855@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:28:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpmf-0005YY-Lb
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab0ADQ1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068Ab0ADQ1k
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:27:40 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:59645 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab0ADQ1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 11:27:39 -0500
Received: by mail-fx0-f225.google.com with SMTP id 25so8863621fxm.21
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=66jxXd8GZ7PRDga4+17INhl9iDEGdsVUMEy4MwAcIAU=;
        b=B2FMCM2Zx103KGZdjJZJ3I86Qc2dp/qB4GEfjDdcm4hBXJShcp7DTCMsfw2jq9JBaV
         Lc7/OfC/aVVq1XaNpMsTDo0P3Mp/TIyUFdy2yB7gW0cSN3RqnEz6u43l5opB7ueKAHED
         bPoGdLhU6dPCkcc6WIA1jONu1l7hFk2QwAVS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jW+wOMPYaU1F9dhGI6OBLHnldFvyvFNTOWxiiZrkcBo9Qs6diPVHq7vYn6hJNaOgRj
         B3NQlbP7wWLnnTt4HeFurOQ+oF2F0WO79/Ba/SvmNNfE88WoXOi9NJxytM1fhjg4Tyxo
         RLaKoTaHsf65OZ3jVsIjIOW1vtIdWSlV8+wHA=
Received: by 10.239.166.7 with SMTP id z7mr880162hbd.23.1262622458908; Mon, 04 
	Jan 2010 08:27:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136127>

Hi,

I'm relatively new to Git.
At the moment I'm trying to understand if it will be possible to:

1 - configure a central server (server A) to host all my git repositories.
2 - also I would like to configure access to those Git repositories in
order to use authentication:
        - using LDAP;
        - using MS Active Directory;

3 - Moreover, I would like to know if is there any administration
interface to use within git repositories?
4 - And to close this email, I need a way to manage access permissions
over the server repositories. Such as:
        - read-write, read-only, or no access at all;
        - deletes-allowed, renames-allowed, tags allowed;

Can anyone guide me through any items referred above?
Any help appreciated!

Best Regards,
Pedro Lemos
