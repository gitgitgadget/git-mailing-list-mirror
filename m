From: "Caio Marcelo" <cmarcelo@gmail.com>
Subject: Re: Binary files in format-patch
Date: Mon, 5 May 2008 20:10:59 -0300
Message-ID: <d280d7f10805051610u3b020dafxb9e832ecdf14c68c@mail.gmail.com>
References: <d280d7f10805051555x67bd7e87o999a2c9e19663b92@mail.gmail.com>
	 <20080505230153.GL29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 06 01:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt9qa-0004bg-OC
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 01:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbYEEXLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 19:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbYEEXLD
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 19:11:03 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:46435 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbYEEXLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 19:11:01 -0400
Received: by fk-out-0910.google.com with SMTP id 18so892042fkq.5
        for <git@vger.kernel.org>; Mon, 05 May 2008 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rLpf5/PS56mdaoB60vDRhlZ0gsDMuy9TjD2dJIHsZsM=;
        b=aJ9CEVR2DF9/bhnkvvB7yohC7odGtPfPZzGLtID7nSpnTlrqpumZhdNj6yW0apzscUO0opXI7Nidm+a0DcqrJFXDaeBiiQeJUUnYCGRXUS6vnt5VZAzI3/Lle3lW5pCj31JYRTJ+X4UEIMtlpOqsjfhvzXFdZUKGuvMaDZfftAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GwlubjMLDhxbKr9j98GRqYV25p5to5FeElfy6rCeQu/gXlVMBZicHUGyD2Zlo5oXg6Pbbp++v+KgrxauG3P9yhjpTT/NtrM/JeM0TuX6prQ9IkEprvJ7EnE9phOhxab9VTBi/IA7EQ4ueWfUIqrVIPfeGg8qNnmRbVPpD6tO0W0=
Received: by 10.78.166.1 with SMTP id o1mr22936hue.74.1210029059292;
        Mon, 05 May 2008 16:10:59 -0700 (PDT)
Received: by 10.78.140.8 with HTTP; Mon, 5 May 2008 16:10:59 -0700 (PDT)
In-Reply-To: <20080505230153.GL29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81315>

>  > Their contents are not relevant for us, and doesn't help much in a
>  > mailing list. Taking a peek at the code I've found out this:
>
>  Why then are they committed in Git and being modified?  If the
>  files aren't relevant, why are they tracked?

Sorry, I wasn't very clear there. The binary content is mostly icons,
that get added and updated now and then, so outside of the scope of
our code review mailing list -- but relevant to the project itself.
(The patches themselves are accessible by other means other than the
ML too, so reviewers can pull and get proper versions).

Considering that, any of the proposed solutions make more sense now? :-)


Cheers,
  Caio Marcelo
