From: schachtobi <schachtobi@web.de>
Subject: svn propset
Date: Wed, 15 Sep 2010 20:52:25 +0200
Message-ID: <4C9115E9.4080900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 20:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovx5r-0006sa-Vf
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 20:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994Ab0IOSw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 14:52:26 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46962 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931Ab0IOSwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 14:52:25 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7AC961684D6B1
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 20:52:24 +0200 (CEST)
Received: from [92.75.151.92] (helo=[192.168.2.100])
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #24)
	id 1Ovx5k-0002iM-00
	for git@vger.kernel.org; Wed, 15 Sep 2010 20:52:24 +0200
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
X-Enigmail-Version: 0.96.0
X-Sender: schachtobi@web.de
X-Provags-ID: V01U2FsdGVkX1+XYoEDuz4SizJw5QUcXr0GxktpRFp0sqHoc68z
	NEHjV5MFjDq9l6mkzefFWGRSTJLMuEKB9cOGgT9KVvt7fCuKbH
	Cqw7zOYps=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156244>

In response to Ramana,

you talked about the svn:ignore property and suggested to have a special
command to set this property. But I think first it could be done
automatically using the semantics git allready has and second there are
other properties that could be treated the same way:

* svn:mime-type
* svn:ignore
* svn:keywords (is there something like this in git?)
* svn:externals (not yet supported? Found nothing so far)
  except solutions here:
http://panthersoftware.com/articles/view/3/svn-s-svn-externals-to-git-s-submodule-for-rails-plugins
  but this is not the same since the client has to setup the links,
repositories etc. And they do not come automatically as in subversion.
  I guess submodules is the proper replacement. But still having the
svn:externals from a pull this could be done automatically without the
need for scripting. And the dcommit should also work for the submodules.
* svn:bugtraq*
* svn:mergeinfo

for me the svn:merginfo and the svn:externals would be most benifitial
since our team uses this a lot and without being able to set those from
git it will be not possible for me to use git for a svn client to do the
merges.

So are there plans or updates to the problems I have encountered?

Thanks!

regards,
Tobias
