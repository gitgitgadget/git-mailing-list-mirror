From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Sat, 6 Feb 2010 00:19:02 -0500
Message-ID: <76718491002052119j5d6bae35s146bed8da03e3983@mail.gmail.com>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
	 <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
	 <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
	 <7vtytvf4vp.fsf@alter.siamese.dyndns.org>
	 <76718491002052018s324747ecj31963b493868dbbd@mail.gmail.com>
	 <7vbpg3dldq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 06:20:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndd5V-0004MR-4D
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 06:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827Ab0BFFTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 00:19:06 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:50615 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab0BFFTE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 00:19:04 -0500
Received: by iwn15 with SMTP id 15so1789846iwn.19
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 21:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=mPOu9hfDMnKyUNEwoJJI+9Y/Xfq5Mo8xlKc12DX4S0o=;
        b=nRslxZ/7O4TCuaQpof4G7s9uOlI4JhRN5WlQsjsKgma1VGmBtXo7nzlAdKDmnRBzJv
         9OLpLJ7U1QJACCxl5cJTqk8r72u5Hv1V2/zK3Gx7x33uWPsQMBth+UIk0BvhEWd0hN+q
         dKWw5IKWJnhGWjOJHAMyVFX1dOFi7CX9lhkII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pz+XkD5cAxoIE0r9d3Nqj6AuxdjRFwznOdhr9LuYKJOn/NJjdOOtNChraXrzQSm5TF
         ARQfFMD3JP9RJWTlQnLhNEIf8N3FVaeE97b12uTROMJF/pQBLHYSJbBBQj9jhNEqdqsV
         FCu8ifljqtW4ZdvLAEpG0qxAfAkbrZaAJCzKE=
Received: by 10.231.85.198 with SMTP id p6mr1311658ibl.65.1265433542501; Fri, 
	05 Feb 2010 21:19:02 -0800 (PST)
In-Reply-To: <7vbpg3dldq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139146>

On Fri, Feb 5, 2010 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> How could that be a counterproposal to a deprecation of -x and adding
> hooks as a replacement, as a solution to more general issues?

Sorry, it's been a long week and I wasn't thinking clearly.

Yes, adding post-cherry/rebase hook(s) would keep all parties happy. :-)

> Maybe, but it calls cmt_metadata() which is "grep ^git-svn-id:" of the
> commit object, so we know why it doesn't X-<.

Bah, that's too bad. :-(

j.
