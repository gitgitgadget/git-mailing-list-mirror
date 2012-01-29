From: nmartin <nmartin867@gmail.com>
Subject: Cloning bare repository always warns that its empty.
Date: Sat, 28 Jan 2012 19:09:21 -0800 (PST)
Message-ID: <1327806561158-7233455.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 04:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrL9K-0001kM-9O
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 04:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab2A2DJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 22:09:22 -0500
Received: from sam.nabble.com ([216.139.236.26]:35906 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500Ab2A2DJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 22:09:21 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <nmartin867@gmail.com>)
	id 1RrL8r-0007vZ-4n
	for git@vger.kernel.org; Sat, 28 Jan 2012 19:09:21 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189275>

Hello..

I created a bare repository (empty) on my server which I making public over
http. I cloned this repository on another machine(A), committed changes, and
pushed the changes to the server. On the server when I run $ git log I can
see the commit that I pushed. However if I clone this repository on a 3rd
machine(B).. the repository is empty.


Can someone to me what I am doing wrong? I would expect the pushed changes
to have been brought down to machine B. 

Thanks!

--
View this message in context: http://git.661346.n2.nabble.com/Cloning-bare-repository-always-warns-that-its-empty-tp7233455p7233455.html
Sent from the git mailing list archive at Nabble.com.
