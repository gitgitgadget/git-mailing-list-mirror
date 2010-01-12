From: "Edward Z. Yang" <ezyang@MIT.EDU>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 14:11:44 -0500
Message-ID: <1263323292-sup-4182@ezyang>
References: <1263319565-sup-1767@ezyang> <32541b131001121101i76ad8062p3a7f3571ad86b0ce@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:11:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUm9g-0006yF-NO
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 20:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530Ab0ALTLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 14:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471Ab0ALTLs
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 14:11:48 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:58587 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753419Ab0ALTLs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 14:11:48 -0500
X-AuditID: 12074425-b7ca5ae000007e53-1e-4b4cc9732c49
Received: from grand-central-station.mit.edu (GRAND-CENTRAL-STATION.MIT.EDU [18.7.21.82])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 9D.3A.32339.379CC4B4; Tue, 12 Jan 2010 14:11:47 -0500 (EST)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by grand-central-station.mit.edu (8.13.6/8.9.2) with ESMTP id o0CJC7uC026549;
	Tue, 12 Jan 2010 14:12:08 -0500 (EST)
Received: from localhost (EZYANG.MIT.EDU [18.243.1.50])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id o0CJC01U001092;
	Tue, 12 Jan 2010 14:12:01 -0500 (EST)
In-reply-to: <32541b131001121101i76ad8062p3a7f3571ad86b0ce@mail.gmail.com>
User-Agent: Sup/git
X-Scanned-By: MIMEDefang 2.42
X-Brightmail-Tracker: AAAAAgCq+KkSV7V1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136751>

Excerpts from Avery Pennarun's message of Tue Jan 12 14:01:42 -0500 2010:
> If what you want is just one shared working copy with locking, then
> what you want is RCS.  Why change what's not broken?  You're not doing
> anything distributed or even any branching, and you don't need to
> atomically commit multiple files at once (which would be very
> confusing if more than one person is changing stuff in the current
> tree), so git doesn't seem buy you anything.

I would like to respectfully disagree.  I want to use git because:

    * I use Git on a regular basis, and do not use RCS.  I constantly
      have to go digging through the manpages when I occasionally do
      stumble upon an RCS system.  Interface familiarity is nice.

    * Putting it in Git means that you can easily grow; you can decide
      "Hey, maybe we want to do branchy development" and just do it,
      rather than have to drum up the activation energy to do an
      rcsimport.

    * If code is deployed in a production context as a Git checkout,
      you can definitely have both branchy development as well as
      a shared working copy (with low contention, but contention nonetheless).

Cheers,
Edward
