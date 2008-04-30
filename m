From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-cvsimport problem
Date: Wed, 30 Apr 2008 12:12:58 +0200
Message-ID: <4818462A.4090709@alum.mit.edu>
References: <481809D6.5010207@opensourceclub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alenoosh Baghumian <alenoosh@opensourceclub.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 12:14:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr9KD-0003kJ-8C
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 12:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbYD3KNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 06:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbYD3KNK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 06:13:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37995 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYD3KNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 06:13:09 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m3UAD6PG019222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Apr 2008 12:13:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080227 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <481809D6.5010207@opensourceclub.org>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80821>

Alenoosh Baghumian wrote:
> I want to import a remote cvs repository to git [...]
> git-cvsimport: fatal: cvsps reported error

This is typically caused by the inability of cvsps to handle complicated
CVS repositories or by corruption in your CVS repository.

If you are doing a one-time conversion, try using cvs2git/cvs2svn [1].
It is capable of handling more complicated CVS repositories.

Even if you need incremental conversion, you might want to try cvs2git
anyway, as it might give you a better error message if your CVS
repository is corrupt in some way.

Michael

[1] http://cvs2svn.tigris.org/cvs2git.html
