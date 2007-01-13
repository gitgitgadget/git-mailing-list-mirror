From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Sat, 13 Jan 2007 12:02:38 +0100
Message-ID: <20070113110238.GA2795@steel.home>
References: <871wm08kcu.fsf@morpheus.local> <7vd55jrj38.fsf@assigned-by-dhcp.cox.net> <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?iso-8859-15?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 12:03:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5gfD-0007jM-TB
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 12:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbXAMLC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 06:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbXAMLC7
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 06:02:59 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:58124 "EHLO
	mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161212AbXAMLC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jan 2007 06:02:58 -0500
Received: from fwd27.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1H5gf0-0007fm-02; Sat, 13 Jan 2007 12:02:54 +0100
Received: from tigra.home (V+-JL-ZUQetnvZJOOsEuY0glpovjmEiiMTg68CzlBeastdEErfoxwh@[84.163.124.145]) by fwd27.sul.t-online.de
	with esmtp id 1H5gem-09ZPXc0; Sat, 13 Jan 2007 12:02:40 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 928DC277B6;
	Sat, 13 Jan 2007 12:02:39 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id CE216C293; Sat, 13 Jan 2007 12:02:38 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-ID: V+-JL-ZUQetnvZJOOsEuY0glpovjmEiiMTg68CzlBeastdEErfoxwh
X-TOI-MSGID: 64c25309-e92d-4a43-9ce8-88a7bf820ad5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36748>

Junio C Hamano, Sat, Jan 13, 2007 02:31:35 +0100:
> +/* High bit set, or ISO-2022-INT */
> +static int non_ascii(int ch)
> +{
> +	ch = (ch & 0xff);
> +	return ((ch & 0x80) || (ch == 0x1b));
> +}
> +

"return (ch & 0x0x80) || (ch & 0xff) == 0x1b;" :)
