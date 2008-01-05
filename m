From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Sat, 5 Jan 2008 09:31:50 +0100
Message-ID: <e5bfff550801050031g17e0217dueaed3ad3a53ddee8@mail.gmail.com>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	 <20080105064156.GA6954@blorf.net>
	 <7vzlvkepd5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Wayne Davison" <wayne@opencoder.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 09:32:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB4S1-0006cL-Fd
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 09:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbYAEIbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 03:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbYAEIbv
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 03:31:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:34456 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbYAEIbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 03:31:51 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6397699rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 00:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9RsJaEdL9DVC1fKoZ29Nf9jIA2GM86dMV1LYdz+bX8s=;
        b=WT8IhpqprLJ9OdLEbEWJO94WCdxR18f/XYrlxcBtKDI5rDSCjE12jawl9rqnY0lsB3eo3PByqtBvaJ+QEI8RVFp0LhYVH8KKHkyU//CublZWjZgYY/Pf+f2eO2ugibO+8PAit9Yd6lDm4ZzxpVHaxWTr+uZKNqyImQ+ealtBbXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bvhddvnABI9MXu+vRGZJN+eTLp1lHZkGOr9hLsp7Kg/Ensp0CKzws+oYED6ddGHFVCKXN8VHywthi1yFTfHc7+b19ZggIUdfBKh1yDWggXVZCP3Ybwg4mOaQrRn0evo+ZRrhORTVE3FVf8Sy6Ds5yVvzIyDLRdO35+F86H3f/QQ=
Received: by 10.141.163.12 with SMTP id q12mr9393514rvo.190.1199521910410;
        Sat, 05 Jan 2008 00:31:50 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 5 Jan 2008 00:31:50 -0800 (PST)
In-Reply-To: <7vzlvkepd5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69651>

On Jan 5, 2008 7:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Wayne Davison <wayne@opencoder.net> writes:
>
> > On Fri, Jan 04, 2008 at 05:14:42PM +0100, Marco Costalba wrote:
> >> -            echo >&2 'No local changes to save'
> >> +            echo > 'No local changes to save'
> >
> > That change and the other two following it each put a newline in a
> > strangely named file.  You should just drop the >&2 altogether if you
> > want the output to go to stdout.
>
> Lol...  Good eyes.  I did not even notice it ;-).
>

Very sorry for this, I should have been more careful. Please let me
know if you want me to resend the patch.

Marco
