From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: files missing after converting a cvs repository to git
Date: Tue, 07 Oct 2008 12:46:30 +0200
Message-ID: <48EB3E06.70100@alum.mit.edu>
References: <799406d60810061502y417ec53o1a1f5cef800dfe45@mail.gmail.com> <48EAFCEF.8030907@op5.se> <gcfcrg$ubc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 12:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnA6V-0002i1-L0
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 12:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbYJGKqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 06:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYJGKqh
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 06:46:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45494 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbYJGKqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 06:46:36 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m97AkU8C021615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Oct 2008 12:46:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080925 Thunderbird/2.0.0.17 Mnenhy/0.7.5.666
In-Reply-To: <gcfcrg$ubc$1@ger.gmane.org>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97688>

Jakub Narebski wrote:
> Andreas Ericsson wrote:
> 
>> cvs2svn is apparently quite good at getting even the weirdest history
>> right. Perhaps you can try that and then running "git svn" on the
>> resulting svn repo?
> 
> cvs2svn has git output now (I think it is actually fast-import output)

Correct.  See http://cvs2svn.tigris.org/cvs2git.html for more info.  I
suggest using the trunk version of cvs2svn for conversions to git.

Please note, however, that cvs2svn can only handle one-time conversions
(i.e., not tracking a live CVS repository incrementally).

Michael
