From: ddw_music <jamshark70@gmail.com>
Subject: Re: (osx 10.4.11) can't push from linux to Apache on mac: can't
  access location
Date: Sun, 13 Jun 2010 03:28:56 -0700 (PDT)
Message-ID: <1276424936869-5173934.post@n2.nabble.com>
References: <1276390106819-5173157.post@n2.nabble.com> <AANLkTim4U99KQ2zDfdSmMzbn1FqCqAPh_hKwITmQDX6H@mail.gmail.com> <1276410911244-5173593.post@n2.nabble.com> <AANLkTilIGhEXlhEbAAXIU-_1Qg8AJoCalkilWGCzIP1m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 12:29:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONkR5-0003ZF-02
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 12:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab0FMK26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 06:28:58 -0400
Received: from kuber.nabble.com ([216.139.236.158]:52475 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab0FMK25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 06:28:57 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <jamshark70@gmail.com>)
	id 1ONkQy-0006gt-SF
	for git@vger.kernel.org; Sun, 13 Jun 2010 03:28:56 -0700
In-Reply-To: <AANLkTilIGhEXlhEbAAXIU-_1Qg8AJoCalkilWGCzIP1m@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149042>



Tay Ray Chuan wrote:
> 
> I vaguely remember encountering this. Use a dav client, like cadaver,
> to manually release the lock.
> 
>   $ cadaver http://yourserver/git/kc/
>   > discover info/refs
> 
>   <bla bla: look for the lock token>
>   > unlock <token>
> 

I do appreciate the help... unfortunately, cadaver reports no locks but the
error persists...

For my purposes, I think I can use git-daemon. It's approaching the point
where it will not be worth dealing with the Apache layer. Unless there is a
simple solution, the HTTP approach seems to be adding complexity without
much benefit.

If anyone out there knows of a straightforward way to set this up, I'm eager
to hear it. (By "straightforward," I mean I'm out of time to fiddle around
with it much more.) If there is no straightforward way, git-daemon it will
be for me.

Thanks.
James
-- 
View this message in context: http://git.661346.n2.nabble.com/osx-10-4-11-can-t-push-from-linux-to-Apache-on-mac-can-t-access-location-tp5173157p5173934.html
Sent from the git mailing list archive at Nabble.com.
