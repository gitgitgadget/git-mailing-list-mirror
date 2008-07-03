From: "Eric Raible" <raible@gmail.com>
Subject: Re: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Thu, 3 Jul 2008 01:50:18 -0700
Message-ID: <279b37b20807030150t2e9cbcc8wf099a5872568af8@mail.gmail.com>
References: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>
	 <7vfxqr2won.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 15:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEOh2-000707-86
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 15:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267AbYGCNM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 09:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbYGCNM1
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 09:12:27 -0400
Received: from hs-out-0708.google.com ([64.233.178.248]:30019 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbYGCNM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 09:12:27 -0400
Received: by hs-out-0708.google.com with SMTP id 4so187196hsl.5
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 06:12:25 -0700 (PDT)
Received: by 10.142.156.2 with SMTP id d2mr3463788wfe.321.1215075018447;
        Thu, 03 Jul 2008 01:50:18 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Thu, 3 Jul 2008 01:50:18 -0700 (PDT)
In-Reply-To: <7vfxqr2won.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87289>

On Thu, Jul 3, 2008 at 1:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Eric Raible" <raible@gmail.com> writes:
>
> Is there anything to fix?  In that example, you are looking for a commit
> that talks about "object name:sha1_name.c" in the comment.

Yes.  What if I'm looking for specific file (i.e. sha1_name.c) in the commit
described by ":/object name:", just like I can do with 28a4d9404:sha1_name.c?

This is not ambiguous if we first consider the entire string as the prefix.
If that fails we look for a filename after the final ':'.

I'll post a patch in a moment.

- Eric
