From: ddw_music <jamshark70@gmail.com>
Subject: Re: (osx 10.4.11) can't push from linux to Apache on mac: can't
  access location
Date: Sat, 12 Jun 2010 23:35:11 -0700 (PDT)
Message-ID: <1276410911244-5173593.post@n2.nabble.com>
References: <1276390106819-5173157.post@n2.nabble.com> <AANLkTim4U99KQ2zDfdSmMzbn1FqCqAPh_hKwITmQDX6H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 09:03:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONhEP-0007De-L8
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 09:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab0FMHDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 03:03:39 -0400
Received: from kuber.nabble.com ([216.139.236.158]:60852 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab0FMHDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 03:03:39 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <jamshark70@gmail.com>)
	id 1ONgml-0007sM-8A
	for git@vger.kernel.org; Sat, 12 Jun 2010 23:35:11 -0700
In-Reply-To: <AANLkTim4U99KQ2zDfdSmMzbn1FqCqAPh_hKwITmQDX6H@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149038>



Tay Ray Chuan wrote:
> 
> Where are you pushing to? Look at your <Location> again - you
> configured Apache to look out for '/git/kc/', not '/~dewdrop/git/kc/'.
> 

Ah... of course. Now I do get the directory listing of the repository on the
remote machine.

Still a problem pushing, though: the famous "cannot lock existing info/refs"
message. I see a reference on a Google group -- a problem/solution post* --
but that's inaccessible to me from mainland China. Likely to be something
simple, but I have actual work that I need to get back to at the moment :-)

* groups.google.com/group/.../0792d1750d764225

Thanks for further advice.
James
-- 
View this message in context: http://git.661346.n2.nabble.com/osx-10-4-11-can-t-push-from-linux-to-Apache-on-mac-can-t-access-location-tp5173157p5173593.html
Sent from the git mailing list archive at Nabble.com.
