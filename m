From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: GSS-Negotiate authentication requires that all data fit into
 postbuffer
Date: Sun, 6 Oct 2013 17:38:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1310061737000.6366@tvnag.unkk.fr>
References: <20131006004236.GB3460@vauxhall.crustytoothpaste.net> <20131006105013.GA24950@LK-Perkele-VII> <alpine.DEB.2.00.1310061658330.6366@tvnag.unkk.fr> <20131006152908.GD3460@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Oct 06 17:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSqPs-0005qe-2c
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 17:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab3JFPik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 11:38:40 -0400
Received: from giant.haxx.se ([80.67.6.50]:47397 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521Ab3JFPik (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 11:38:40 -0400
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r96FcOPc009181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 6 Oct 2013 17:38:24 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r96FcOUW009176;
	Sun, 6 Oct 2013 17:38:24 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20131006152908.GD3460@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235742>

On Sun, 6 Oct 2013, brian m. carlson wrote:

> If there's a way to make Apache with mod_auth_kerb do that with curl, then 
> it doesn't require a change to git, and I'm happy to make it on my end. 
> But using the curl command line client, I don't see an Expect: 100-continue 
> anywhere during the connection using Debian's curl 7.32.0-1.  Do I need to 
> send a certain amount of data to see that behavior?

Correct, curl will enable "Expect: 100-continue" if the post size is > 1024 
bytes.

-- 

  / daniel.haxx.se
