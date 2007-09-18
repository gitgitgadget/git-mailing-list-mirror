From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Latest builtin-commit series
Date: Tue, 18 Sep 2007 23:39:03 +0200
Message-ID: <20070918213903.GA14488@steel.home>
References: <1190129009.23692.24.camel@hinata.boston.redhat.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 23:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXkmz-0006Ot-U8
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 23:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbXIRVjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2007 17:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbXIRVjJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 17:39:09 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:20224 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbXIRVjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 17:39:08 -0400
Received: from tigra.home (Faaaa.f.strato-dslnet.de [195.4.170.170])
	by post.webmailer.de (fruni mo49) (RZmta 12.10)
	with ESMTP id Y04833j8ILbY4e ; Tue, 18 Sep 2007 23:39:04 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id AC3E227752;
	Tue, 18 Sep 2007 23:39:04 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0457BBF18; Tue, 18 Sep 2007 23:39:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1190129009.23692.24.camel@hinata.boston.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolCodE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58635>

Kristian H=F8gsberg, Tue, Sep 18, 2007 17:23:29 +0200:
>       * Set the test suite default editor to '/bin/true' instead of '=
:'.
>         Since we're not exec'ing the editor from shell anymore, ':'
>         won't work.  Maybe we should special case ':' in launch_edito=
r
>         or perhaps make launch_editor use system(3).  Not sure.

Special case "" (empty string)? MinGW may have problems with
/bin/true, any future exotic ports notwithstanding (OS/2, anyone?).
