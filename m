From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] When a remote is added but not fetched, tell the user.
Date: Sat, 12 Apr 2008 01:20:34 +0200
Message-ID: <bd6139dc0804111620g3dc0eca0oe887fd206911329d@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <1207869946-17013-1-git-send-email-g2p.code@gmail.com>
	 <alpine.DEB.1.00.0804111621080.31025@eeepc-johanness>
	 <20080411203501.7095b866@localhost> <20080411190816.GA17277@mithlond>
	 <7v4pa8rs00.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0804111535y8073d22w79845341394c2067@mail.gmail.com>
	 <7vbq4gouej.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>, Gabriel <g2p.code@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 01:21:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkSYZ-0001tP-AB
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 01:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbYDKXUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 19:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755827AbYDKXUf
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 19:20:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:36585 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808AbYDKXUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 19:20:34 -0400
Received: by wf-out-1314.google.com with SMTP id 28so691556wff.4
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wivJAIYzVh1S+eB/TRkAzx2Zc1pzspE+gYYwRCJO9IY=;
        b=KQVKtiw3P4dIJ1QtcZ35MbEbdFlAA1LIqJFwpc4i4erFLogCE0bHeFUMxoYp9v0q9poQBm3NcLt7pK+SR8pjMf7SlmdHE9/hf+SMlyr8qdgc9OPmn/SCX29R6vXvzROzKu250qYq+maXIoVy7DBSqsYeDDElDqv6X0zBIar0DsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tjjMfKZFXJP4Cv+2SLj84/KV5eGttESgobwgnmi3tPyqJwfXgJ/cSX2zY3AwH9MZtnzrRrnczxyRfnTv8aGeHY4ignEoJtYRRYwAFHlEXu+KkoIuOSbeYk28LNSzisZs+eyYTbGs5BcD+dLpycusXzBO9ycIjexpSTmwg1gdWsI=
Received: by 10.142.211.10 with SMTP id j10mr969851wfg.202.1207956034597;
        Fri, 11 Apr 2008 16:20:34 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Fri, 11 Apr 2008 16:20:34 -0700 (PDT)
In-Reply-To: <7vbq4gouej.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79310>

On Sat, Apr 12, 2008 at 1:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  Yeah, I am not sure if that should be called --verbose, but a "training
>  wheel" mode of operation somebody else mentioned the other day that echoes
>  back what the command thinks it was told to do by the user, together with
>  help text that explains what other things the user could have told to the
>  command to enrich its operation, might be an interesting addition.

Hmmm, I'm not sure about '--verbose' as a name either, but it -is-
usually used to display more information about the command(s) being
executed. E.g.:
-v, --verbose
	      explain what is being done
http://unixhelp.ed.ac.uk/CGI/man-cgi?mv
Sounds pretty much like what we're doing, explaining what command we
thing is being executed. The extra text OTOH with 'possible other
workflow suggestions' doesn't quite fit in the '--verbose' picture.
Perhaps a different kind of command, like '--newbie' (or, less
humiliating, '--explain') would be more appropriate.
