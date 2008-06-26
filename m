From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git rebase interactive: usability issue
Date: Wed, 25 Jun 2008 23:59:01 -0400
Message-ID: <32541b130806252059l30431fcbld6196bedb32ab397@mail.gmail.com>
References: <20080625233208.GE5737@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.0806260416410.4503@eeepc-johanness>
	 <7vbq1ovpl7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 06:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBif0-0006aB-2P
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 06:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbYFZD7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 23:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755494AbYFZD7H
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 23:59:07 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:7813 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbYFZD7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 23:59:05 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3506047fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1SlxIWKGoq1nRrZbg8YnqUSs99IF6Z0ZaBQXS5PgJXA=;
        b=vBCw7DWb5TErYUcOx1K6Rfwe0U0s8GlqJ6lIoTC9l8cAwELet+mX56m9JyNUCWmozN
         GUIiuSgpouNKItIuGkY6AOkQTg/qnoUPAnEISlQ27gc3NCPI6K8BMqX1cMZxejYz4zJQ
         Th/ztVcbz1/oRDqD7n9vAChRV84L8PAevdwzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jbI6yQe8UFJV2vJhdSFTmhMNVFdSwKnyAWYOQ09XtDo8B7TrVh3RkzjUU5HCionsEb
         P1FQSMudBuYP198mjJWjHyxcgeoDhEd8pkkTM6Wgyo39zZmf5lKKf9mxd7AqcnjASDcP
         9xYVvamDjyFv2NNXOihtZdL3KXJWlwZnPCeqg=
Received: by 10.82.135.7 with SMTP id i7mr684690bud.42.1214452741297;
        Wed, 25 Jun 2008 20:59:01 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 20:59:01 -0700 (PDT)
In-Reply-To: <7vbq1ovpl7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86390>

On 6/25/08, Junio C Hamano <gitster@pobox.com> wrote:
>  I was relunctant about the patch not because of "edit", but because I am
>  not convinced that it will _never_ make sense to be able to amend while
>  the sequence stops with a conflict (as the patch does not give us any way
>  to override this rather heavy-handed denial to continue).

Perhaps the problem is more that people are encouraged to --amend so
often that they end up doing it by accident.

What if 'edit' worked more like 'squash', in that it produced the new
tree, but didn't commit it yet?  Then you can reset things, commit
them, or rebase --continue (which commits automatically if needed)
just like wish 'squash'.

I think --continue used to not commit automatically, so I can see why
edit used to commit for you, but maybe that behaviour is not needed
anymore.

Right now the asymmetry of having to use --amend with 'edit' but not
with 'squash' is what leads me to make mistakes sometimes.

Have fun,

Avery
