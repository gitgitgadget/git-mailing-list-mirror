From: Andrey Smirnov <allter@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Fri, 17 Jul 2009 21:46:07 +0400
Message-ID: <cdea6cd10907171046u257fa8ebjee445a90de0a282c@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>
	 <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
	 <20090430085853.GA21880@pvv.org>
	 <32541b130904300732i691800f5kecc2f845584071c1@mail.gmail.com>
	 <loom.20090716T160021-218@post.gmane.org>
	 <32541b130907161134n51e070a1l93690d1b8a63bee8@mail.gmail.com>
	 <cdea6cd10907161509g7771c72bl608b1924785b49fc@mail.gmail.com>
	 <32541b130907161527l1955bf06pf54b5099a5988c65@mail.gmail.com>
	 <cdea6cd10907170016u11af7230hbbee92682604530f@mail.gmail.com>
	 <32541b130907170847g67c89d54ke9426ed8da26a9aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRrVl-00084J-MU
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 19:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbZGQRqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 13:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbZGQRqL
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 13:46:11 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:61539 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964960AbZGQRqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 13:46:09 -0400
Received: by ey-out-2122.google.com with SMTP id 9so247780eyd.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dsKrk5g40REGhhPw9kyajF6iV+RrdrfWDWYFBj53VG0=;
        b=R0rNp169CFrHf0UehQitWqnXBeu1JQ0/WykpnqwMM4H4eki7qZoJ3Y0es3lY8lyK+o
         714Y0Pq/jHHCOOt+nlFSA/7Xn+vpGSajYDK4/gAOVWGSpOtrJLDgyPN1wuRLQ8sRFwXV
         djwYNqR1UlBroApn56cq7OG/MjzvObA7VmEq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RoccU8xsgr41Z9iFiavrSBTf0A+nq1a3ABW56ngLHkhNjnn0d0cfN80GSk89yR2bOE
         k4wU9nqE2cFAcyMdl7hAMvqleMXMJFKdOFDTolUdvRCZKmNNW740Q6/jVc48mec+Qj/H
         iAhP5khxlgeuS15ESTCXhmbasU/u8EagUINr0=
Received: by 10.216.28.193 with SMTP id g43mr360430wea.192.1247852767923; Fri, 
	17 Jul 2009 10:46:07 -0700 (PDT)
In-Reply-To: <32541b130907170847g67c89d54ke9426ed8da26a9aa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123479>

On Fri, Jul 17, 2009 at 7:47 PM, Avery Pennarun<apenwarr@gmail.com> wrote:
> The problem is that test-split and test-split-old are completely
> unrelated trees that have similar-looking files but no common
> ancestry.

I understand this but if two projects share the same commit history
for their subdir-lib
both test-split and test-split-old will have same root.

> git-rebase tries to be cleverer, and starts comparing patches and file
> similarities so it can graft one tree onto another,

That is too clear for me and since I try to avoid committing
'reversion commits' it works for my
workflow. I don't want to track library as separate ref (at least now).

Anyway thank you for great extension - will now try using it on a
regular basis - there're another project that is more suitable
to track libraries as you suggest.

--
Sincerly yours, Andrey.
