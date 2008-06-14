From: Sven <svoop@delirium.ch>
Subject: Re: [BUG REPORT]
Date: Sat, 14 Jun 2008 18:26:00 +0000 (UTC)
Message-ID: <loom.20080614T181822-325@post.gmane.org>
References: <loom.20080614T065448-251@post.gmane.org> <20080614071011.GA29699@glandium.org> <7vprqkh423.fsf@gitster.siamese.dyndns.org> <7vlk17horn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 20:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aTQ-0002vk-Hk
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbYFNS0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYFNS0K
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:26:10 -0400
Received: from main.gmane.org ([80.91.229.2]:57426 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbYFNS0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:26:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K7aS0-00005S-D1
	for git@vger.kernel.org; Sat, 14 Jun 2008 18:26:08 +0000
Received: from 151.121.221.87.dynamic.jazztel.es ([87.221.121.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 18:26:08 +0000
Received: from svoop by 151.121.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 18:26:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.121.151 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9) Gecko/2008061004 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85032>

>  (1) I do not think it is unreasonable to change update-server-info
>      to include HEAD in its output.  That would make ls-remote 
>      output over all protocols consistent;

As Jeff said, he has already done this and it will roll with the 
upcoming release.

>  (2) However, the client-side tools that run ls-remote may have to
>      interact with repositories that are managed with older git
>      (including "Today's git").  If they rely on the presense of 
>      HEAD, they _are_ buggy today (and have been so forever), and
>      they _will stay_ buggy when they need to access such 
>      repositories.

Indeed, there is a way to tell Capistrano to use a specific branch: 
Adding ...

set :branch, "master"

... to the configuration in deploy.rb does the trick.

-sven
