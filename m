From: Ondra Medek <xmedeko@gmail.com>
Subject: Re: gitweb showing slash r at the end of line
Date: Sun, 29 Jan 2012 23:55:40 -0800 (PST)
Message-ID: <1327910140526-7235866.post@n2.nabble.com>
References: <1327673954458-7229895.post@n2.nabble.com> <m3aa58eskw.fsf@localhost.localdomain> <7vvcnwybxj.fsf@alter.siamese.dyndns.org> <201201281802.44339.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 08:55:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrm5Z-0007I7-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 08:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab2A3Hzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 02:55:41 -0500
Received: from sam.nabble.com ([216.139.236.26]:40661 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab2A3Hzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 02:55:41 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <xmedeko@gmail.com>)
	id 1Rrm5U-0001Vg-HG
	for git@vger.kernel.org; Sun, 29 Jan 2012 23:55:40 -0800
In-Reply-To: <201201281802.44339.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189327>

Hi Jakub,
I have read "SubmittingPatches". I have made a path by "git format-patch -M"
and I have though it's enough. The problem maybe was, that I had not
included "Subject: " from the result of "git format-patch -M". Next time I
will try to do it better.

I am a Git newbie, but my bare repos have "config" file and this file can
contain the "core.autocrlf" setting. So the gitweb can read it. Or what
about to have a special section [gitweb] in this config? For now, the gitweb
config files are somewhat "scattered" = "descrition", "cloneurl",
"project.list", ...

Yeah, the autodetection of mixed mode line endings could be the best
solution.

However, from my point of view a global gitweb setting would be enough for
now.


--
View this message in context: http://git.661346.n2.nabble.com/gitweb-showing-slash-r-at-the-end-of-line-tp7229895p7235866.html
Sent from the git mailing list archive at Nabble.com.
