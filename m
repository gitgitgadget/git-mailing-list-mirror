From: Christian Meder <chris@absolutegiganten.org>
Subject: wit - demo site
Date: Wed, 20 Apr 2005 11:11:32 +0200
Message-ID: <1113988293.3183.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 20 11:08:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOBBU-0001uh-1Q
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 11:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVDTJLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 05:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDTJLy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 05:11:54 -0400
Received: from shadow.prohost.de ([216.71.84.228]:21214 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S261501AbVDTJLi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 05:11:38 -0400
Received: from blue.office.onestepahead.de (h-62.96.100.62.host.de.colt.net [62.96.100.62] (may be forged))
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3K9Bbq04585
	for <git@vger.kernel.org>; Wed, 20 Apr 2005 11:11:37 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

thanks to my friend Frank Sattelberger I got access to a site where I
could set up a demo for wit:

http://grmso.net:8090

Couple of notes wrt why I work on another git web interface compared
with Kay's work:

* I was already experimenting and implementing for a couple of days when
Kay's tool was first announced and I didn't want to throw away my
feature set

* the Web API: wit has a different philosophy when it comes to URIs: The
stable URI mapping should translate in a straightforward fashion to
git: /blob/<sha1> /tree/<sha1>, /tree/<sha>/diff/<sha1>, etc.; no URL
parameters

* wit is more of a git view right now: it only uses git and tries to
stay close to the repository browsing paradigm (see the API issue above)

* wit provides tarballs and patches but that's an easy one for Kay

* wit looks uglier but that will hopefully change soon ;-)

* I'm a not a Perl guy

I'm still seeking feedback ;-)

Greetings,


			Christian

-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

