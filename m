From: Mike Doherty <doherty@cs.dal.ca>
Subject: Bad URL passed to RA layer
Date: Tue, 02 Nov 2010 17:12:28 -0300
Message-ID: <4CD070AC.8030600@cs.dal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 02 21:43:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDNhC-0002Eb-UL
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 21:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab0KBUnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 16:43:01 -0400
Received: from hammer.CS.Dal.Ca ([129.173.22.32]:57168 "EHLO hammer.cs.dal.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab0KBUnA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 16:43:00 -0400
X-Greylist: delayed 1828 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Nov 2010 16:43:00 EDT
Received: from [129.173.195.192] (DC3C0.WPA.Dal.Ca [129.173.195.192])
	by hammer.cs.dal.ca (Postfix) with ESMTP id DB7FF5055C
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 17:12:26 -0300 (ADT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160554>

Hello,

My git-svn apparently doesn't understand https URLs after installing
perl Alien::SVN:

mike@binnie:~$ git svn clone --username=doherty
https://svn.cs.dal.ca/doherty
Initialized empty Git repository in /home/mike/doherty/.git/
Bad URL passed to RA layer: Unrecognized URL scheme for
'https://svn.cs.dal.ca/doherty' at /usr/lib/git-core/git-svn line 1774

I searched for others having this issue, and did find some results,
however I didn't find any solution. Can this mailing list offer some advice?

Thanks,
-Mike
