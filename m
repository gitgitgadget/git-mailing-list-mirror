From: cdossantos <claudia.dossantos@ricoh-europe.com>
Subject: Re: Someone using GIT and Maven?
Date: Wed, 6 Oct 2010 06:23:32 -0700 (PDT)
Message-ID: <1286371412868-5607053.post@n2.nabble.com>
References: <1285913490619-5590307.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 15:23:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Ty8-0001sL-Po
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 15:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316Ab0JFNXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 09:23:34 -0400
Received: from kuber.nabble.com ([216.139.236.158]:58552 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917Ab0JFNXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 09:23:33 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <claudia.dossantos@ricoh-europe.com>)
	id 1P3Ty0-0001nq-SH
	for git@vger.kernel.org; Wed, 06 Oct 2010 06:23:32 -0700
In-Reply-To: <1285913490619-5590307.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158285>


Hello,

I found the problem, according with
"http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt"
i should use the .netrc file to authentication. My .netrc file is configured
with localhost, and I configured localhost for the "remote" entry in the
config file (.git) as well.
Now I'm using localhost in the SCM connection too:
<scm>
    <connection>scm:git:http://admin:admin@localhost/project2</connection>
</scm> 

regards,

Santos
-- 
View this message in context: http://git.661346.n2.nabble.com/Someone-using-GIT-and-Maven-tp5590307p5607053.html
Sent from the git mailing list archive at Nabble.com.
