From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [REPLACEMENT PATCH 2/2] Add "--early-output" log flag for interactive GUI use
Date: Sun, 4 Nov 2007 08:52:58 +0100
Message-ID: <e5bfff550711040052y486d71edu81bcddc8919dd496@mail.gmail.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
	 <18221.28744.805398.598809@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:53:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoaIH-0007UR-3J
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 08:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbXKDHxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 02:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbXKDHxA
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 02:53:00 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:53197 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbXKDHw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 02:52:59 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1214036rvb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9E8xAUJa96Z9PdN01Q8KVQurcj9rGfe6cIK1VAaoXt0=;
        b=sjVK8p468U3HZ9/vbhqqO8MRRzh4qd7GcwFwZTo8Vnhuqs1yNj4/E3FuJDhoq/U6iAv0ylKybLm8pO7hAw1mBwayymwIZ8c7nRn1pFssUB22wvqVhzDlpvGPhl49zA1xowLROMl32b5OkaBnpdVcQTX2oSn8PlipgxZxTybqqcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e4paZX7xP6KYnyJsIgDnHBdQpEUtqb5fUyRlCiMzN+1y1AlEwIe/61uPc6Qe9a5Z2NaPM4WVgdNJslF6jBUjpbyZwUjk62x1+UT0lgoyXWUHcV91/CaFZT1tEa94FVysZPfIlgFeMXpFhdDpXbliqveRcSLKKDtzOmcEA6Ix3Ls=
Received: by 10.140.255.19 with SMTP id c19mr1769761rvi.1194162778947;
        Sun, 04 Nov 2007 00:52:58 -0700 (PDT)
Received: by 10.141.203.3 with HTTP; Sun, 4 Nov 2007 00:52:58 -0700 (PDT)
In-Reply-To: <18221.28744.805398.598809@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63360>

On 11/4/07, Paul Mackerras <paulus@samba.org> wrote:
>
> Later on we could optimize that by having git log
> match up how many initial commits are the same in both the new list
> and the old list, and have it output that rather than the N commits
> that were the same as last time.
>

Partial output of commits after "Final output" line would be more
difficult for me to handle instead or restarting form beginning.

One possible optimization along this line instead would be that git
log match up how many initial commits are the same in both the new
list and the old list, and if the old list is whole included
unmodifies in the new simply git log outputs the new commits (not
already present in the old) without the "Final output" line.

Marco
