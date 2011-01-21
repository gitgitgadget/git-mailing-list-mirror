From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2 v2] rebase -i: clarify in-editor documentation of
 "exec"
Date: Fri, 21 Jan 2011 01:47:00 -0600
Message-ID: <20110121074700.GA26600@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino>
 <20110116020132.GB28137@burratino>
 <vpq39otrvmk.fsf@bauges.imag.fr>
 <20110120200949.GB11702@burratino>
 <7vy66fqoji.fsf@alter.siamese.dyndns.org>
 <20110121003624.GB23139@burratino>
 <vpqr5c6zqrh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 21 08:47:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgBiQ-0001Aq-Aa
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 08:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab1AUHrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 02:47:21 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64836 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab1AUHrU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 02:47:20 -0500
Received: by gwj20 with SMTP id 20so438044gwj.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 23:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9HSprDburrhqjfHrtRldd0PryrW34WCaC7ZA9uUShXk=;
        b=tJm7tIS8hxbNKYA5id8Q+3+TrsBFIlMaiVopWRtMGj+yovCj2WZYwpUqu1MjxU/seI
         f+UwGq5NArRw985zKP7olqEnAlH9CvaUuIr5dO6LR4TtdH5/fRG8DvxMwpa0wY0NJBMe
         rK74+vfR68KaIU7xCTnOuIHklCX1EyuLZyrqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ECwhxu+wYbezVMeUcv2/WshDd/fl6y/b4WeWYLfv685H9iuLJPiibuYnMyf8jU02Ks
         Fo5H/LMjnVJpYwGF0I/rvGSUpLEYPeRD8PuRF5rdzS7YvlRC8jy3AQPODHWlX5Q6i/4h
         LiudqPEs2iCWv8eAHWZeQlCbQcqNNYn54IhUU=
Received: by 10.101.1.15 with SMTP id d15mr240279ani.123.1295596039508;
        Thu, 20 Jan 2011 23:47:19 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id z12sm11121559anp.19.2011.01.20.23.47.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 23:47:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpqr5c6zqrh.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165359>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
>> +#  x, exec = run command specified on the rest of the line
>
> I don't think dropping "shell" is a good idea. In this context,
> "command" could mean "one of pick/fixup/squash/...", a Git command,
> and at last, an arbitrary line of shell.

Hmm.  I suppose

# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#  x, exec = run command (the rest of the line) using shell

would do?

Sorry to take so long to get this right.
