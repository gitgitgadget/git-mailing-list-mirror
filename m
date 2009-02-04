From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: segfault during clone via http
Date: Wed, 4 Feb 2009 13:00:28 -0500
Message-ID: <76718490902041000x3cda2390t25254e8372c9af50@mail.gmail.com>
References: <loom.20090204T160827-822@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Thorsen <adam.thorsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUm4U-0006x2-Lz
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZBDSAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZBDSAa
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:00:30 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:28860 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZBDSA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:00:29 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2663326rvb.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 10:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YcDqi+YqTo5gQ28Y31dMD0toC3/1f2XrxV4CYnXSY0I=;
        b=jm9z7PaIn6PC2rIv8yb26GsuGCDz9sQNeS1OXlDQY+7lHGQoKI0B7temHtFN6bie3e
         OBezC6ONZEUPuqyo3XLkK+CMP2iwV8Ik/tzaZFXp09l/xVVKUgTPSqjM6r0vvW+7THCg
         JKArYUQV+W3yTg1SLxuEpJ0bIw9vW/QpljFpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U0BF8ODMcKj4CZU/CHO8LYO392AC68MEExACOIB8kGW2JgnxZ20jkJQTLTT5cEnm5t
         R/jJoM+1vZ9mxIE0b8XRx/PTUHTaesqGl+/Zy9LGqsSfoLwqfRzSxQ/MxTHBHGK8r3uf
         4LBDObVpAUKw7Pu/iVDUdz3jliC6qe5ENsEjU=
Received: by 10.140.144.1 with SMTP id r1mr152453rvd.209.1233770428638; Wed, 
	04 Feb 2009 10:00:28 -0800 (PST)
In-Reply-To: <loom.20090204T160827-822@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108403>

On Wed, Feb 4, 2009 at 11:10 AM, Adam Thorsen <adam.thorsen@gmail.com> wrote:
> Git is segfaulting when downloading from a repo via http.  Here's what the
> output looks like: http://gist.github.com/58167.  Anybody seen this before or
> know how I can debug it?  I've made sure my git (1.6.1) is compiled with libcurl.

Please run git under gdb so that there is a stacktrace to work from. Here is an
example of running git under gdb and providing a trace:

http://article.gmane.org/gmane.comp.version-control.git/107860

j.
