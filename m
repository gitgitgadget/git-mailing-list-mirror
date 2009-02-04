From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: jabber notifications for git commits
Date: Wed, 4 Feb 2009 15:27:51 +0000 (UTC)
Message-ID: <gmcc5n$1em$1@ger.gmane.org>
References: <200902041243.36507.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 16:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjgv-0007XS-W3
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbZBDP2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbZBDP2F
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:28:05 -0500
Received: from main.gmane.org ([80.91.229.2]:43557 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbZBDP2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:28:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUjfW-0006nJ-W1
	for git@vger.kernel.org; Wed, 04 Feb 2009 15:28:03 +0000
Received: from u-7-242.vpn.rwth-aachen.de ([137.226.103.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:28:02 +0000
Received: from heipei by u-7-242.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:28:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-7-242.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108378>

On 2009-02-04, Thomas Koch <thomas@koch.ro> wrote:
> Is it possible to integrate jabber and git so that I get notified when
> new commits are available on our central git repo host?

Well, the problem isn't really in the hooks but in how to connect to a 
Jabber-server. For the few svn-repos I'm using (on my own server that 
is) I'm using xmpp4r (a Ruby-jabber implementation). svn triggers a 
commit-hook which calls my ruby-script and supplies the jabber-contacts 
with commit-message, changed files and so on.

You can find the ruby-script here: 
http://avalon.hoffentlich.net/~heipei/tmp/jabber_notification.rb and 
have fun adapting it to your needs and making sure that xmpp4r is 
installed ;)

> I need to install some hook on the git server, of course.

If you can't get xmpp4r onto the host that is the master for your 
project you could always put a hook there that pushes new changes to 
another host and calls xmpp4r there.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
