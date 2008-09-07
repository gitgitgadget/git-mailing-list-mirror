From: Mike Sharov <msharov@users.sourceforge.net>
Subject: How can I track a template?
Date: Sun, 07 Sep 2008 12:04:46 -0400
Message-ID: <48C3FB9E.8090404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 18:06:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcMlv-0000BB-Ok
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 18:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYIGQEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 12:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYIGQEt
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 12:04:49 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:37019
	"EHLO QMTA02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587AbYIGQEt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 12:04:49 -0400
Received: from OMTA05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by QMTA02.westchester.pa.mail.comcast.net with comcast
	id BpX11a00K0vyq2s52s4nUJ; Sun, 07 Sep 2008 16:04:47 +0000
Received: from [192.168.1.3] ([68.32.115.135])
	by OMTA05.westchester.pa.mail.comcast.net with comcast
	id Bs4m1a00D2vLhQL3Rs4mRl; Sun, 07 Sep 2008 16:04:47 +0000
X-Authority-Analysis: v=1.0 c=1 a=2SbvGOF3Z3cGrJVg9qgA:9
 a=uLVvW0Zes7ovxnIxSQAA:7 a=kpbAmSQ8n0y7904BTJKZnQsXhGoA:4 a=gi0PWCVxevcA:10
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.8) Gecko/20071025 SeaMonkey/1.1.5
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95146>

I am trying to create a standard module to be included into many
projects. Specifically, the build system skeleton, but I have other uses
for the same mechanism. The idea is to have a repository with the
skeleton itself, and have other projects include it somehow and keep
up-to-date by pulling from the template repository.

The straightforward approach of using 'git pull' does not work very
well. At each merge, all the things changed show up. For example, I
would change the project name in the configure template. This change
creates a merge conflict on every pull even if that particular line did
not change in the template. Somehow it just doesn't seem to establish a
base for the merges. Another problem is that the tags get pulled and
become tags on the project, which is undesirable.

What sort of a solution would you recommend for this, if any?
-- 
Mike Sharov
