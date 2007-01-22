From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: modifying commit's author
Date: Mon, 22 Jan 2007 21:50:16 +0100
Organization: Dewire
Message-ID: <200701222150.16465.robin.rosenberg.lists@dewire.com>
References: <20070122203734.GB23187@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 21:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H967g-0007rN-DD
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbXAVUty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 Jan 2007 15:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbXAVUty
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:49:54 -0500
Received: from [83.140.172.130] ([83.140.172.130]:5821 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932630AbXAVUtx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jan 2007 15:49:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 477AB802E0C;
	Mon, 22 Jan 2007 21:45:20 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09614-09; Mon, 22 Jan 2007 21:45:20 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 20277802651;
	Mon, 22 Jan 2007 21:45:20 +0100 (CET)
To: "J. Bruce Fields" <bfields@fieldses.org>
User-Agent: KMail/1.9.4
In-Reply-To: <20070122203734.GB23187@fieldses.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37450>

m=E5ndag 22 januari 2007 21:37 skrev J. Bruce Fields:
> If I got the author wrong on a commit, is there a quick way to fix it
> (e.g. by passing the right arguments or environment variables to comm=
it
> --amend)?

Set these:
GIT_AUTHOR_EMAIL
GIT_AUTHOR_NAME
GIT_COMMITTER_EMAIL
GIT_COMMITTER_NAME

-- robin
