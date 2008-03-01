From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH 20/40] Windows: A rudimentary poll() emulation.
Date: Sat, 1 Mar 2008 16:48:38 +0100
Message-ID: <200803011648.38296.robin.rosenberg@dewire.com>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <47C680A4.6050309@gnu.org> <200802282149.36748.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Mar 01 16:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVTxS-0002Hw-Gf
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 16:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558AbYCAPsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 10:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755999AbYCAPs3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 10:48:29 -0500
Received: from [83.140.172.130] ([83.140.172.130]:5197 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756203AbYCAPs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 10:48:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A94E2802673;
	Sat,  1 Mar 2008 16:48:27 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id guoFlvI1cB9z; Sat,  1 Mar 2008 16:48:27 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 39553800698;
	Sat,  1 Mar 2008 16:48:27 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200802282149.36748.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75680>

Den Thursday 28 February 2008 21.49.36 skrev Johannes Sixt:
> On Thursday 28 February 2008 10:36, Paolo Bonzini wrote:
> > For the future, would it be better to first use WaitForMultipleObjects,
> > and then use PeekNamedPipe to find which handles have data on it?
> > That's how the mingw port of GNU Smalltalk does it.
>
> I tried but I failed. If you can show me code where WaitForMultipleObjects
> works on handles that MSVCRT.DLL's open() created, I'll gladly accept it!

Have you checked _get_osfhandle? There's a warning though in the knowledgebase
with number 99173, though. There's also another function that works the other 
way, _open_osfhandle.

-- robin

