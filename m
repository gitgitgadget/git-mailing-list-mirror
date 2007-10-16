From: David Brown <git@davidb.org>
Subject: Re: [PATCH] tail -n not supported in all OSs
Date: Tue, 16 Oct 2007 10:12:06 -0700
Message-ID: <20071016171206.GA13715@old.davidb.org>
References: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihpxr-0001p4-Q2
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922AbXJPRMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757519AbXJPRMI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:12:08 -0400
Received: from mail.davidb.org ([66.93.32.219]:34915 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036AbXJPRMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:12:07 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1Ihpxe-0003cP-B4; Tue, 16 Oct 2007 10:12:06 -0700
Mail-Followup-To: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61221>

On Tue, Oct 16, 2007 at 07:57:14PM +0300, Jari Aalto wrote:
>
>SunOS/Solaris tail(1) does not support option '-n'. The
>following patches change occurrances of:
>
>   tail -n <N>
>
>to
>
>   tail <N>

On Linux, I get

   tail: cannot open `1' for reading: No such file or directory

Did you want

   tail -<N>

David
