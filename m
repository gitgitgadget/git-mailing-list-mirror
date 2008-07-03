From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH/rfc] gitweb: open files (e.g. indextext.html) in utf8
 mode
Date: Thu, 03 Jul 2008 11:39:38 +0200
Message-ID: <486C9E5A.9@gmail.com>
References: <20080702121317.10819.qmail@bca5b84cb0e0a0.315fe32.mid.smarden.org> <m3prpwflus.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?UmVjYWkgT2t0YcWf?= <roktas@debian.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENql-0002ud-Vm
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758832AbYGCMWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYGCMWs
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:22:48 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:44354 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299AbYGCMWq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:22:46 -0400
Received: by gv-out-0910.google.com with SMTP id e6so168317gvc.37
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 05:22:43 -0700 (PDT)
Received: by 10.125.162.17 with SMTP id p17mr1933722mko.67.1215077983061;
        Thu, 03 Jul 2008 02:39:43 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.205.155])
        by mx.google.com with ESMTPS id g28sm20590337fkg.8.2008.07.03.02.39.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 02:39:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <m3prpwflus.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87274>

Jakub Narebski wrote:
> Second, what is minimal Perl version and Perl configuration (installed
> modules) that support "use open qw(:std :utf8);"?

open is in core (-> corelist), and "qw(:std :utf)" works here with Perl
5.8.8.  Perl 5.6 doesn't have it, but gitweb doesn't support Perl 5.6
anyway (e.g. "binmode STDOUT, ':utf8';" doesn't work with Perl 5.6).  So
it should be fine compatibility-wise.

-- Lea
