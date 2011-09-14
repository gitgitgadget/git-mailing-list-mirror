From: Tomas Carnecky <tom@dbservice.com>
Subject: git bundler service
Date: Wed, 14 Sep 2011 20:48:08 +0200
Message-ID: <4E70F6E8.80408@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 20:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uVN-00068v-V3
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab1INSsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:48:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39435 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757326Ab1INSsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:48:12 -0400
Received: by wyh22 with SMTP id 22so1963838wyh.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 11:48:11 -0700 (PDT)
Received: by 10.227.7.25 with SMTP id b25mr144395wbb.103.1316026091708;
        Wed, 14 Sep 2011 11:48:11 -0700 (PDT)
Received: from calvin.local (gw.ptr-62-65-141-13.customer.ch.netstream.com. [62.65.141.13])
        by mx.google.com with ESMTPS id z18sm5024554wbm.22.2011.09.14.11.48.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 11:48:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:7.0) Gecko/20110905 Thunderbird/7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181380>

I do a fair amount of end-user support in our official IRC channel and 
every now and then someone with a really slow or unreliable internet 
connection stumbles over the fact that git can't resume clones. In the 
past I would real quick clone the repo and make a bundle for them (if 
the repo was public). Now I made a service out of it: 
https://bundler.caurea.org/. The site is really simple: you enter a git 
url and after a while you'll be able to download the bundle. Bundles are 
cached for a week. Each page has instructions how to convert the bundle 
into a git repository as you would get it via a regular git clone 
(example: https://bundler.caurea.org/bundle/4e709b2ab3f4d18746000002).

In theory it should be possible use the service from the commandline, 
for example to create a wrapper around git clone which does all the 
things automagically. If somebody is interested in doing that, please 
contact me and I'll send you the API documentation.

tom
