From: Eric Niebler <eric@boostpro.com>
Subject: help moving boost.org to git
Date: Mon, 05 Jul 2010 10:16:36 -0400
Message-ID: <4C31E944.30801@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 16:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVmdj-0004mp-Vz
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 16:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab0GEO1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 10:27:09 -0400
Received: from boostpro.com ([206.217.198.21]:48170 "EHLO boostpro.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751387Ab0GEO1I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 10:27:08 -0400
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2010 10:27:08 EDT
Received: from [192.168.2.114] (c-76-118-178-34.hsd1.ma.comcast.net [76.118.178.34])
	(Authenticated sender: eric)
	by boostpro.com (Postfix) with ESMTPSA id 658DF14BAAC
	for <git@vger.kernel.org>; Mon,  5 Jul 2010 15:16:41 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.10) Gecko/20100512 Lightning/1.0b1 Thunderbird/3.0.5
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150270>

I have a question about the best approach to take for refactoring a
large svn project into git. The project, boost.org, is a collection of
C++ libraries (>100) that are mostly independent. (There may be
cross-library dependencies, but we plan to handle that at a higher
level.) After the move to git, we'd like each library to be in its own
git repository. Boost can then be a stitching-together of these, using
submodules or something (opinions welcome). It's an old project with
lots of history that we don't want to lose. The naive approach of simply
forking into N repositories for the N libraries and deleting the
unwanted files in each is unworkable because we'll end up with all the
history duplicated everywhere ... >100 repositories, each larger than 100Mb.

So, what are the options? Can I somehow delete from each repository the
history that is irrelevant? Is these some feature of git I don't know
about that can solve this problem for us?

(Caveat: I'm new to git and still getting up to speed. An acceptable
answer is: go off an learn about feature X and come back to us.)

At boost, We've already discussed a few possible approaches. Feel free
to comment and/or criticize any of the solutions suggested here:

  http://github.com/ryppl/ryppl/issues#issue/4

-- 
Eric Niebler
BoostPro Computing
http://www.boostpro.com
