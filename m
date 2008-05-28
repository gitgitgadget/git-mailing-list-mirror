From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Problem fetching the git homepage
Date: Wed, 28 May 2008 17:45:43 +0200
Message-ID: <483D7E27.7030809@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 28 17:47:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Nri-0006xw-BO
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 17:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbYE1Ppr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 11:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbYE1Ppr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 11:45:47 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:54276 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbYE1Ppq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 11:45:46 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 98C8C25A43
	for <git@vger.kernel.org>; Wed, 28 May 2008 17:45:44 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 15859-02 for <git@vger.kernel.org>;
 Mon, 26 May 2008 19:01:50 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 1209F25A41
	for <git@vger.kernel.org>; Wed, 28 May 2008 17:45:44 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83101>

I'm trying to fetch the repo of the git homepage but get this error:

$ git version
git version 1.5.6.rc0.140.ga9675
$ git fetch origin
Getting alternates list for http://repo.or.cz/r/git-homepage.git
Getting pack list for http://repo.or.cz/r/git-homepage.git
Getting index for pack d4404a860edd30b154e8cd5b8c66ec35cf682dae
Getting pack d4404a860edd30b154e8cd5b8c66ec35cf682dae
  which contains 50819d376acb03429ab2628ef3d07893c7f0e22c
error: packfile 
.git/objects/pack/pack-d4404a860edd30b154e8cd5b8c66ec35cf682dae.pack 
size changed
fatal: packfile 
.git/objects/pack/pack-d4404a860edd30b154e8cd5b8c66ec35cf682dae.pack 
cannot be accessed

The last commit I have is "Automated update: [2008-04-20] v1.5.5 -> 
v1.5.5.1" (2b7e2d6a).

Is this due to something I've done?  (Not even sure from the error 
message if it is a local error, or a remote error.) Or a sign of 
something more serious?

/Gustaf
