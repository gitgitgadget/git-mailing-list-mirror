From: David Kastrup <dak@gnu.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 22:42:34 +0200
Message-ID: <85y7g6ndj9.fsf@lola.goethe.zz>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<20070820174142.GA7943@glandium.org>
	<867inqhyuk.fsf@lola.quinscape.zz>
	<20070820181357.GA8264@glandium.org>
	<86zm0mgicy.fsf@lola.quinscape.zz>
	<20070820184829.GA8617@glandium.org>
	<20070820194328.GE8542@efreet.light.src>
	<20070820195037.GA9774@glandium.org>
	<20070820200719.GE5544@steel.home>
	<20070820201042.GA9942@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:43:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INE5k-0003GN-PF
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760741AbXHTUmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760562AbXHTUmi
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:42:38 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:52840 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758113AbXHTUmg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2007 16:42:36 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 6F39131F0B8;
	Mon, 20 Aug 2007 22:42:35 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 5C7C813EE98;
	Mon, 20 Aug 2007 22:42:35 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-046-034.pools.arcor-ip.net [84.61.46.34])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 345841D7145;
	Mon, 20 Aug 2007 22:42:35 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BAF301C36605; Mon, 20 Aug 2007 22:42:34 +0200 (CEST)
In-Reply-To: <20070820201042.GA9942@glandium.org> (Mike Hommey's message of "Mon\, 20 Aug 2007 22\:10\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4013/Mon Aug 20 18:00:53 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56255>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Aug 20, 2007 at 10:07:19PM +0200, Alex Riesen <raa.lkml@gmail.com> wrote:
>> Mike Hommey, Mon, Aug 20, 2007 21:50:37 +0200:
>> > On Mon, Aug 20, 2007 at 09:43:28PM +0200, Jan Hudec <bulb@ucw.cz> wrote:
>> > > Git does not have tracking of file's history either.
>> > 
>> > Well, it has ways to track file's history, with blame and log, for
>> > example. There is nothing similar for directories, though it could be
>> > possible to do.
>> 
>> It would be not exactly "tracking". You can present the history of
>> changes which involved the said directory.
>> 
>> And you could do it from day one: git log -- sub/dir
>
> It could be possible to really do tracking, too, like it is possible for
> files (including renames, moves, etc.)

You are confused.  Git does not track renames or moves for files,
either.  It just records snapshots.  It reverse engineers renames,
moves, copying when cranking out diffs and logs and blames.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
