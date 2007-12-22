From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Move git send-email cover letter temporary file to $GIT_DIR
Date: Sat, 22 Dec 2007 12:18:08 +1100
Message-ID: <ee77f5c20712211718g230802b6jb70e5db1f6a43973@mail.gmail.com>
References: <7vhcic9e17.fsf@gitster.siamese.dyndns.org>
	 <1198284202-20666-1-git-send-email-hendeby@isy.liu.se>
	 <7vmys3358v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gustaf Hendeby" <hendeby@isy.liu.se>, luciano@eurotux.com,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 02:18:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5t0d-0000EI-7a
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 02:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXLVBSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 20:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbXLVBSK
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 20:18:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:47921 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXLVBSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 20:18:09 -0500
Received: by rv-out-0910.google.com with SMTP id k20so591934rvb.1
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 17:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=k8l9eUMbTsK4Ty95VkamSaCMhbXgxq+Nwkkt/UTKFTA=;
        b=EkWDIDnMyg6x4swPCoHp9QLnWB0ApAiSpa6UgdvZ8OLfQM02PDUELJYyd1xfHwxJufE4TafFvNhRde/PKnlIzHDpXO4Ptuh3CoyeWCucK7wSug1bF+fK098jFYk1eCUUG+3XxjaAXcX3BhFY+qQ/QNr+BlXvOOD/E8FOVBdIeL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UXYrExIR7Qeit4x5rcy2Q7qoIxRiSlf1ij/1TKDjWJ+Wg93BjNzApE9Gl2k+oXz0TmYFPYHYQTB5oXKOQqlFWbMS67bRVhFJpMCVaUc48vETzDsQELZXUnjfxLhRSTiuEqfpl9lpusztKQ0QbFon0C4h/qtk9tm8RgpYGf8nYzs=
Received: by 10.141.123.4 with SMTP id a4mr1137109rvn.172.1198286288173;
        Fri, 21 Dec 2007 17:18:08 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Fri, 21 Dec 2007 17:18:08 -0800 (PST)
In-Reply-To: <7vmys3358v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69117>

On Dec 22, 2007 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Don't you have $repo (an instance of Git) at that point?  You
> should be able to ask repo_path() about it, shouldn't you?

Isn't git-send-email still useful outside a Git repo?


Dave.
