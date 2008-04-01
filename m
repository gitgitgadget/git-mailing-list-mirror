From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [BUG] aliases not working outside of a working copy
Date: Tue, 1 Apr 2008 10:04:06 +0200
Message-ID: <8aa486160804010104u62a45081taa25693b690150c6@mail.gmail.com>
References: <8aa486160803310819r3a905bbeg5f993a55aaf6efbf@mail.gmail.com>
	 <7v1w5qkx2j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 10:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgbUE-000110-RK
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 10:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbYDAIEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 04:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756597AbYDAIEK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 04:04:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:20194 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbYDAIEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 04:04:08 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1153624wra.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Vr9Eb5i6G3IA3WCWVs4gUlR3JyCVNCGlmQWJP2JQf54=;
        b=iR5O4TTNGAzsZXZXmNp4IHyYgTB1W78KaqEdcQwBkp4GHBqdfh5oihNGcl0E6oT6ZVvaXsVTmjQiZ9gSF+IX8H25JmYbmdoXuYRUZjtghFU7SZUCbouasgVv0a6T6o3j1gUfqvF+l1nA1LxRHsgETiOkpk9uhushU6kbMP/nwMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FZwHkarA1xGD5TrJWEvZw0uKGyRTbybcOfznCTeY0snEd1il09vrn2nM0tPAhl3InjlLN5rsK4xWAMzQt0JHiV+BMQHG1VPpg6EWlq6TSzDlycuz6U+QaYfzG4a2Wy3NqR8J/c1opFp7KSE5EKD/ioHQ5lrXG9gs7VHHQvt5Wkw=
Received: by 10.150.154.6 with SMTP id b6mr3953505ybe.64.1207037046599;
        Tue, 01 Apr 2008 01:04:06 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Tue, 1 Apr 2008 01:04:06 -0700 (PDT)
In-Reply-To: <7v1w5qkx2j.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78637>

On Tue, Apr 1, 2008 at 6:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  I was wondering if anybody was using git alias outside git repository, as
>  I thought such a use would be somewhat unorthodox.  The easter egg took 6
>  days to get discovered.
>
>  I'll commit this on 'master'.  Thanks for satisfying my curiosity ;-)

You're welcome.

Santi
