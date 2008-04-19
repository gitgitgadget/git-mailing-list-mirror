From: jacobhenry <jachenry@indiana.edu>
Subject: git over http
Date: Sat, 19 Apr 2008 11:05:36 -0700 (PDT)
Message-ID: <16785966.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 20:34:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnHSA-0001J0-SH
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 20:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbYDSSFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 14:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755567AbYDSSFh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 14:05:37 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38829 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755397AbYDSSFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 14:05:36 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1JnHRQ-0001E6-9K
	for git@vger.kernel.org; Sat, 19 Apr 2008 11:05:36 -0700
X-Nabble-From: jachenry@indiana.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79914>


The past couple days I have tried to configure git over http.  To this point
I have it working for a small repository. However, when I try to push a
large directory to the server, it gives me a very vague description of the
error "http-push died with strange error".  My apache logs do not even
flicker.  Is there anywhere I can look to see what the actual error is?  

Here is the trace:

Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   267c7ff02a8dbd0e0d81bbfeee4e64faa4773f83
    sending 301 objects
    done
Updating remote server info
Waiting for http://url/webservice.git/objects/95/
error: http-push died with strange error
error: failed to push to 'http://url/webservice.git/'


-- 
View this message in context: http://www.nabble.com/git-over-http-tp16785966p16785966.html
Sent from the git mailing list archive at Nabble.com.
