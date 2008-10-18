From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: git-svn crashing perl
Date: Sat, 18 Oct 2008 14:42:52 +0100
Message-ID: <b2cdc9f30810180642n22b800ddg244555bf788a83bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 15:44:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrC6B-0000tv-Tr
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 15:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbYJRNmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 09:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbYJRNmz
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 09:42:55 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:38437 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbYJRNmy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 09:42:54 -0400
Received: by gxk9 with SMTP id 9so2191222gxk.13
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 06:42:53 -0700 (PDT)
Received: by 10.90.93.8 with SMTP id q8mr4224642agb.83.1224337373028;
        Sat, 18 Oct 2008 06:42:53 -0700 (PDT)
Received: by 10.90.105.11 with HTTP; Sat, 18 Oct 2008 06:42:52 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 276183c1f243c0eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98548>

Hi,

Doing a git-sv fetch --fetch-all is generating a SEGV in perl while I
try and update my repo. Although I can look at the backtrace in perl
it doesn't really tell me much. Any tips on how I can get more info?


-- 
Alex, homepage: http://www.bennee.com/~alex/
