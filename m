From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [GSoC update] Splitting gitweb & developing write functionalities
Date: Wed, 16 Jun 2010 01:33:30 +0530
Message-ID: <AANLkTikapZa0N7xroxhdlmm7LUvlNp-7GZy7XeG-zprC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 22:03:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOcMD-0001Rw-Ps
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 22:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab0FOUDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 16:03:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46434 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab0FOUDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 16:03:31 -0400
Received: by gye5 with SMTP id 5so3515455gye.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=roCxPI6+rEq+xWnfv9f3BQ2TUKbAsr4tTKq8aJ+eZiE=;
        b=coqFls3psrWLdeKcXeTLS1Ne7wpHvPw8HKczxg+gJz99tjis03mfWcBpl1xX8XFohG
         NdSB8obmg5UO5Tsaxv0pbxqYXJg8b0fphd/7eeahF3vLfzwXASnEs3RexdVnh3nFZdbS
         MmjcDc2e2lilIGLb40mD5QwDhB7+obKDl/0Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=o4JrvM0e9RnqDPpO6AdhPW4wczw5GCiWECofEi5vnUV1GIMJBn4vnoo+pJdFbIeTgt
         D5frfX3Dbzp+8z1c3loK908QeRxRvF/t0JJw9VR6X4bMclbupCX0r2gNn/wj94tOVar+
         sKd+QGUmA7N7t3eYU53lhLtgzyjGEqOdilZ14=
Received: by 10.101.5.40 with SMTP id h40mr6602102ani.133.1276632210925; Tue, 
	15 Jun 2010 13:03:30 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Tue, 15 Jun 2010 13:03:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149220>

Hi,

I know it's been late to send a GSOC update but here is mine for the
first few weeks of GSOC coding period.

Patch list:

gitweb: Use @diff_opts while using format-patch [master]

gitweb: Move static files into seperate subdirectory [next]
gitweb: Set default destination directory for installing gitweb [next]
git-instaweb: Put httpd logs in a "$httpd_only" subdirectory [next]
git-instaweb: Configure it to work with new gitweb structure [next]
git-web--browse: Add support for google chrome and chromium [next]
Makefile: Use $(sharedir)/gitweb for target 'install-gitweb' [next]
git-instaweb: Add option to reuse previous config file [next]

git-instaweb: Add support for --reuse-config using gitconfig [waiting
for Junio] http://kerneltrap.org/mailarchive/git/2010/6/3/31711

gitweb: Create Gitweb::Git module [Work in Progress]
gitweb: Create Gitweb::Config module [Work in Progress]
gitweb: Create Gitweb::Request module [Work in Progress]
gitweb: Create Gitweb::Escape module [Work in Progress]
gitweb: Create Gitweb::View module [Work in Progress]
gitweb: Create Gitweb::Util module [Work in Progress]
gitweb: Create Gitweb::RepoConfig module [Work in Progress]
gitweb: Create Gitweb::Format module [Work in Progress]
gitweb: Create Gitweb::Parse module [Work in Progress]
