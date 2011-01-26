From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 23:00:39 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1101262244550.14066@tvnag.unkk.fr>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com> <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com> <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com> <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com>
 <alpine.DEB.2.00.1101261422550.20831@tvnag.unkk.fr> <AANLkTi=Gey75oo-iaELVWg87cP+HgM3RQ60vPgwaEMpS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mika Fischer <mika.a.fischer@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 23:00:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiDPy-0008LI-Na
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 23:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab1AZWAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 17:00:40 -0500
Received: from giant.haxx.se ([80.67.6.50]:60085 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab1AZWAk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 17:00:40 -0500
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9.1) with ESMTP id p0QM0drS019373;
	Wed, 26 Jan 2011 23:00:39 +0100
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <AANLkTi=Gey75oo-iaELVWg87cP+HgM3RQ60vPgwaEMpS@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165556>

On Wed, 26 Jan 2011, Mika Fischer wrote:

> curl/openssl 0.9.8k <-> apache/openssl 1.0.0 -> error

> I'm not sure what to take away from this. Maybe it's a problem that is 
> partly caused by both apache and curl?

Could be. I just have a hard time to see why code in curl that has worked for 
so many years suddenly would stop working. It just so feels like else changed.

This error (or something similar to it) is often seen when we try to talk 
plain HTTP to a HTTPS server or vice versa. Did you verify that HTTPS was 
working fine on that port when you ran the OpenSSL 1.0.0 version of the 
server?

Perhaps it is possible to add verbose level and further debug log stuff in the 
server to see what makes it suddenly decide the handshake is bad.

-- 

  / daniel.haxx.se
