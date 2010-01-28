From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Wed, 27 Jan 2010 16:51:42 -0800
Message-ID: <20100128005142.GK5452@spearce.org>
References: <878wbln0oa.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 01:51:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaIbx-00031x-ML
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 01:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab0A1Avr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 19:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307Ab0A1Avr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 19:51:47 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:37360 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab0A1Avq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 19:51:46 -0500
Received: by iwn16 with SMTP id 16so185233iwn.5
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 16:51:46 -0800 (PST)
Received: by 10.231.146.2 with SMTP id f2mr3429086ibv.23.1264639906102;
        Wed, 27 Jan 2010 16:51:46 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm347033iwn.7.2010.01.27.16.51.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 16:51:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <878wbln0oa.fsf@users.sourceforge.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138212>

Pat Thoyts <patthoyts@users.sourceforge.net> wrote:
> 
> This patch enables the use of themed Tk widgets with Tk 8.5 and above.
> These make a significant difference on Windows in making the
> application appear native. On Windows and MacOSX ttk defaults to the
> native look as much as possible. On X11 the user may select a theme
> using the TkTheme XRDB resource class by adding an line to the
> .Xresources file. The set of installed theme names is available using
> the Tk command 'ttk::themes'. The default on X11 is similar to the current
> un-themed style - a kind of thin bordered motif look.
> 
> A new git config variable 'gui.usettk' may be set to disable this if
> the user prefers the classic Tk look. Using Tk 8.4 will also avoid the
> use of themed widgets as these are only available since 8.5.
> 
> Some support is included for Tk 8.6 features (themed spinbox and native
> font chooser for MacOSX and Windows).

Thanks.  I've been running with this pretty much all day today;
it seems sane.  I'll probably push it shortly.

-- 
Shawn.
