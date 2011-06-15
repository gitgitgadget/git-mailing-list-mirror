From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: forcing add of CRLF modified files
Date: Wed, 15 Jun 2011 18:31:46 +0100
Message-ID: <BANLkTimG+4u4jhgvG9xtEQ02yBu3kxDD2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 19:32:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWtwv-00086h-O3
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 19:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab1FORcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 13:32:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35190 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1FORcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 13:32:07 -0400
Received: by ewy4 with SMTP id 4so251563ewy.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=FyxLn2f/C2bReYDMb/+JTvRLs8JvPufJaxwewYEjgGQ=;
        b=WqbEbWPUXUo8sbkoQ1i0i3asCxKYm744afjysaGCwaJZIWuN4elaqrQoj/3HsAZjpA
         y8ZzB0nQPZFB5k8SwtvhCJWx6yW5MiK/WqraVEc1YQZj+tX+r4f0jRVot1Ta2TfdFBPd
         52Fz4/DJGgPkMg0o0f2BGNFwtCcXidyapV3EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=MwKaHPXRJujiZnje0ZRpSPI2PTXWi7LzffhBG7F1Nddgwj8bob//h+VhL2TrLI2818
         db4L3LPLN3zi6GJeSD1nVUAOfnzWxkyxUvL0ztADku7ovOdaYeLrfpZPdvnhlg7D/b9E
         pF4vPvPwkNGOw92d1mCfCvh0fLCTLF9/0xtjI=
Received: by 10.14.42.195 with SMTP id j43mr407207eeb.176.1308159126289; Wed,
 15 Jun 2011 10:32:06 -0700 (PDT)
Received: by 10.14.127.70 with HTTP; Wed, 15 Jun 2011 10:31:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175842>

I cannot seem to get GIT to add files with corrected CRLF line endings
against the repository with incorrect LF only line endings.

Many thanks in advance,

Aaron
