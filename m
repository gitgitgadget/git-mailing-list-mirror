From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU
 extended regex syntax
Date: Fri, 19 Sep 2008 10:55:11 -0500
Message-ID: <pkDB-Ku6Wgh0oYLOf6pWNHJMXdy7I_ZG5lIyvIEdaaaGQxO3kjqHBQ@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <200809190140.15489.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 17:56:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgiLN-0004DD-CM
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 17:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYISPzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 11:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYISPzU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 11:55:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53302 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbYISPzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 11:55:20 -0400
Received: by mail.nrlssc.navy.mil id m8JFtCEL028543; Fri, 19 Sep 2008 10:55:12 -0500
In-Reply-To: <200809190140.15489.johan@herland.net>
X-OriginalArrivalTime: 19 Sep 2008 15:55:12.0351 (UTC) FILETIME=[1983FEF0:01C91A70]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96296>

Johan Herland wrote:
> On Friday 19 September 2008, Brandon Casey wrote:
>> The 'non-GNU' part of this basic RE to extended RE conversion means '\\s'
>> was converted to ' '.
> 
> Shouldn't that be '[ \t]' instead? At least I would like that for the HTML 
> pattern.

Ah, yes, I think you are right.

-brandon
