From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 06 Jun 2008 21:03:51 +0200
Message-ID: <48498A17.5000202@gnu.org>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>	 <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>	 <alpine.DEB.1.00.0806061911300.1783@racer> <bd6139dc0806061136o3830c826va416edca16550fa9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Cedric Vivier <cedricv@neonux.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jun 06 21:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4hF6-0005SA-Gn
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 21:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbYFFTD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbYFFTD7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 15:03:59 -0400
Received: from hu-out-0506.google.com ([72.14.214.225]:2504 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbYFFTD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 15:03:58 -0400
Received: by hu-out-0506.google.com with SMTP id 28so2118109hub.21
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=COGZRjXMxxBJ9G/qMdQ/2ngbMXXt0sgk9uem4aEfQkM=;
        b=tFpaEFm4dBVz8DaRVywI/3NskMQyuNgE6wa/s/2vuNKPM0HxKuuW1ODag560Lev9mP
         qilixaDlsRCgzdxRGcsT8QTR6j2udHovNlClSxYc4o7dnZLCVcbC/96WMjM/yMMOw14Q
         W5fj4ZwHCBA6Hww4hE06c58tgW7wuNAfc50pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=gynxJ39ASOzhz6R2vgRz7yEiwd8Od0Q0oIufpKIqkmTMF50heUI0ba+mzEUG7P7Nng
         eBFyMzUU1TuAmDb4W76ong953po4a1C5gWUGX0saWmGgMIQqEYW9ggwkEw+aUfz6CbU/
         IeRHBisHATBAg7rBF7heiBLxdzGq1jnqMryP0=
Received: by 10.86.65.11 with SMTP id n11mr880519fga.35.1212779033260;
        Fri, 06 Jun 2008 12:03:53 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e11sm6125907fga.4.2008.06.06.12.03.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 12:03:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <bd6139dc0806061136o3830c826va416edca16550fa9@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84098>

Sverre Rabbelier wrote:
> On Fri, Jun 6, 2008 at 8:11 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Except, of course, if you have a script that wants to override whatever
>> the user set in her config.
> 
> I think this is why stuff like GDB has both a CLI and a MI. In order
> to keep the CLI clean you have to make choices, similar to how we
> already separate plumbing from porcelain. I guess in that sense our MI
> is the plumbing, and the porcelain is our CLI. Of course, in that case
> there needn't be such an option in the porcelain, as long as there is
> one in the plumbing ;).
> Conclusion, go for the config option but make sure there's a switch
> for scripts in the plumbing?

Or do the natural sorting only in the porcelain, even if that means 
sorting twice, and use a config option in the porcelain?

(Now, "git branch" is porcelain isn't it?  Plumbing is git-for-each-ref, 
and it has sorting options).

Paolo
