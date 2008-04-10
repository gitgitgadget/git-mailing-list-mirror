From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git annoyances
Date: Thu, 10 Apr 2008 10:19:41 +0200
Message-ID: <bd6139dc0804100119s30a0b62fyc819a7b247b2a972@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
	 <47FDAEEF.3090004@eclis.ch>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Ingo Molnar" <mingo@elte.hu>, git@vger.kernel.org
To: "Jean-Christian de Rivaz" <jc@eclis.ch>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:20:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjs1D-0007qW-JG
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbYDJITn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 04:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755061AbYDJITn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:19:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:38411 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbYDJITm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:19:42 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2548507wra.1
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l0OSPKnHp0QqP8z4gUx4Ea/ZoE/8BuxzcuQZ2Baob+s=;
        b=uLij1rbLSZUYkD+7qTYE9LUjGj3cdcNjlgDIsO+K+N68qqvGgLW9DWXQwdSsBUijzsGBt33FmKj/4Vg8bMDw+jxFkz2EQg+RwiEXtY4x7Sy8zsjCiIDylCPe9840ZpPDsaS5cEQorjGvvnC0Cmd48VDWpA4WMojfJKzDRg+nqEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JUzAOxNyrdZu160Qdf5R0+33w4paIKW5dZFxzoIRhOrKXQUHBgEgS7CqDK8jpC0bcWfZyMlersvQ/ff7xEf4O1hAJmFnwV8kvVHrc6VnDfLuf941lGzE9P8ZkkcahZFQUtRGxzSRxBPvqpcnptTjIQW0dT7O5kSTiO82xvgBDCQ=
Received: by 10.142.245.10 with SMTP id s10mr350821wfh.253.1207815581480;
        Thu, 10 Apr 2008 01:19:41 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Thu, 10 Apr 2008 01:19:41 -0700 (PDT)
In-Reply-To: <47FDAEEF.3090004@eclis.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79194>

On Thu, Apr 10, 2008 at 8:08 AM, Jean-Christian de Rivaz <jc@eclis.ch> wrote:
>  A possible way it to, by default, make git print the full form of the
> command when a short form is used. So the user see the concept without
> having to read the documentation and learn it gradually. I personally like
> tools that act this way. It permit to make a basic and easy tutorial with
> short commands that let know the general concept and show the full potential
> of the tool.

I think this would be a very nice solution, not only do you allow the
user to realize what it is they are doing, you also provide them with
an easy way to be more verbose. Perhaps they wish to switch from the
default short behavior to a somewhat different form (e.g., change a
default 'master' argument to another branch). When writing out the
full form each time the user gets an intuitive and gradual
introduction into the rest of git, without limiting them or more
advanced users.

>  A "short form" flag in a user (not repository) configuration file should
> allow to suppress the long form printout for the comfort of the users that
> don't want it.

Or perhaps, as I mentioned in the thread on "friendly refspecs", a
"newbie" config option or command that turns on the informative
verboseness options. As such, perhaps a "long form" flag would be more
desired instead, to prevent existing developers from being spammed
with information they do not are interested in.

Cheers,

Sverre Rabbelier
