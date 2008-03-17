From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Should 'git config' support key with dot such as 'a.b'
Date: Mon, 17 Mar 2008 09:48:15 +0100
Message-ID: <20080317084815.GC10103@mail-vs.djpig.de>
References: <46dff0320803140124t1469defsf7002f720cf2002e@mail.gmail.com> <200803170100.m2H103CF020765@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 09:49:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbB1u-0004Wp-R1
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 09:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYCQIsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 04:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYCQIsf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 04:48:35 -0400
Received: from pauli.djpig.de ([78.46.38.139]:56044 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbYCQIse (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 04:48:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 4736390077;
	Mon, 17 Mar 2008 09:48:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y6jTisRuR+gt; Mon, 17 Mar 2008 09:48:19 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 36B5390075;
	Mon, 17 Mar 2008 09:48:18 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JbB0x-0006Xf-KH; Mon, 17 Mar 2008 09:48:16 +0100
Content-Disposition: inline
In-Reply-To: <200803170100.m2H103CF020765@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77420>

On Mon, Mar 17, 2008 at 02:00:03AM +0100, Xavier Maillard wrote:
>    I think the following form is more simple
>    ---------------------------------
>    [submodule]
> 	crawler.url = url1
> 	search.url = url2
>    ---------------------------------
> 
>    So, could we support such simpler form?
> 
> Dunno if my vote will count but I really don't like your
> proposition. I find clearer with the current notation. What's
> more it forces people to be more rigorous when touching their
> configuration file.
> 
> git config is really simple to use and there should not be
> difficult for anybody (even new git users) to set up git using
> this helper tool. We should not recommend beginners to manually
> edit their .git/config file when git-config could be used.

git config hasn't exactly a excellent track-record for dealing with all
the possibilities the config syntax allows. Adding yet another
possibility will not make it any more reliable.

Also your argument that people should git-config anyway instead of
editing by hand kinda contradicts the need for a new format, since
it would change anything for the git-config interface, only for people
editing the file by hand...

At the end of the day I don't think the benefits justify the effort.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
