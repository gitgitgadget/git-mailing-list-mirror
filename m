From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/2] Minor fixes for Perl + Git::I18N
Date: Sat, 10 Mar 2012 12:29:33 +0000
Message-ID: <1331382575-16936-1-git-send-email-avarab@gmail.com>
References: <CACBZZX5wHEigiYjn6ahmnXN3wd9sEyDnRV2EZiP+JSUCc182TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 13:30:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6LRa-0006Ta-Id
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 13:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab2CJM34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 07:29:56 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:63704 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab2CJM34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 07:29:56 -0500
Received: by wejx9 with SMTP id x9so1827137wej.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 04:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bKGHPPU4U/UA/HrJ+tEPz0ap0qMocUpsFuLFh/qANmE=;
        b=XgQ1EHTADe422crurhJJKospD8afMtCJ8PDESeFg61LQNYD3OtPCML6DKc0VpxOsad
         EAzUzgz75m9tSD/DWydzm1rc2MwikSOzqDq5scEvGRCKqjvizBHpRDDS7xHTid4J8hJV
         Qa256cXf9SlNfqXFmYUT3a/zEJMH8gAyqgvRIq0TRUZxckNuQeuO5U9VTy173I8GVtV9
         uM52Jut7g3PcpzUMCn5dRQNUJXIJAt5ZDo9/BI0JzG9GoKuNfyNpUYH2pKUoDbQhR31W
         SbYOqLfVE65YFZlTimTXlhMXX/Fj88XBMfRVptzDtp6GAd3in25U7aBekpVn+Tj4ze/c
         UHAQ==
Received: by 10.216.139.129 with SMTP id c1mr3453844wej.48.1331382594499;
        Sat, 10 Mar 2012 04:29:54 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id e6sm10892551wix.8.2012.03.10.04.29.53
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 04:29:53 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <CACBZZX5wHEigiYjn6ahmnXN3wd9sEyDnRV2EZiP+JSUCc182TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192779>

This minor series fixes the Perl issues raised by Tom
Christensen. Since it shouldn't break anything I hope this can make it
into 1.7.10, but that's up to Junio.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Git::I18N: compatibility with perl <5.8.3
  perl/Makefile: install Git::I18N under NO_PERL_MAKEMAKER

 perl/Git/I18N.pm |   11 ++++++++++-
 perl/Makefile    |    7 ++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

--=20
1.7.9
