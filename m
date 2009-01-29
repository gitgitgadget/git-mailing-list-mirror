From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Something weird is happening...
Date: Wed, 28 Jan 2009 22:56:25 -0800
Message-ID: <7vr62mha7a.fsf@gitster.siamese.dyndns.org>
References: <49814BA4.6030705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 07:58:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSQqg-0007bs-Dk
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 07:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbZA2G4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 01:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbZA2G4g
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 01:56:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbZA2G4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 01:56:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02DF395312;
	Thu, 29 Jan 2009 01:56:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C2A095310; Thu,
 29 Jan 2009 01:56:26 -0500 (EST)
In-Reply-To: <49814BA4.6030705@zytor.com> (H. Peter Anvin's message of "Wed,
 28 Jan 2009 22:24:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F5DF6580-EDD1-11DD-A002-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107637>

"H. Peter Anvin" <hpa@zytor.com> writes:

> I was investigating a problem that Ingo Molnar reported on the
> linux-2.6-tip.git repository on kernel.org.  Unfortunately I was not
> able to reproduce his problem (which is a problem in itself) but I did
> run into another oddity:
>
> : hera 4 ; git fsck
>
> [lots of dangling commits deleted]
> missing blob af0e01d4c663a101f48614e40d006ed6272d5c36
>
> : hera 5 ; git cat-file blob af0e01d4c663a101f48614e40d006ed6272d5c36
> /*
>  *  debugfs.h - a tiny little debug file system
>  *
>  *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
>  *  Copyright (C) 2004 IBM Inc.
>  *
> [... rest of blob deleted ...]
>
> Okay, what is going on here?

Does "git fsck --full" report the blob missing?
