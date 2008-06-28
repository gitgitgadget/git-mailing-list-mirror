From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 10:34:57 -0400
Message-ID: <9b3e2dc20806280734i6ca17cc8i447c2e2db67e8051@mail.gmail.com>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
	 <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	 <7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
	 <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 16:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCbX9-0005EW-K8
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 16:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYF1Oe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 10:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbYF1Oe7
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 10:34:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:31340 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbYF1Oe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 10:34:58 -0400
Received: by rv-out-0506.google.com with SMTP id k40so991984rvb.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=21TDZt0fBBNIGhYiLlmWWiYMQLl3VjqJIm32COJTORk=;
        b=jpyx+tn8oVQKvFQS3luqFD35Mtc90ud4e4bxwnBx+cMZzhNJgS8BWEH77OvcKDRJmD
         XSSpvrcF0E6lhqNttHIvGvrPpKRIrrQA1G4gaou73huhr1lci8DDtifphDufgQx0/84C
         RsZfb4RMZ7qXWRJH6nPGM2Ul4iGKCZGSxwLLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=swmZonmkTF+z1a/CB3Th1M0hEp3iYTPHPYZ7kw4ceAt7qhpwpV37fdID8cWLq+4aEg
         AiYdGrJsa9x5gydX0iCWODSNFGZvWINP/pltY9IXea+OVuDNxWHbBBuIOUcdVaIWMHm2
         eClDYEjtTnEhFGho5COdEd99SdHaU0Qy8UnnA=
Received: by 10.141.179.5 with SMTP id g5mr1526351rvp.30.1214663698032;
        Sat, 28 Jun 2008 07:34:58 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sat, 28 Jun 2008 07:34:57 -0700 (PDT)
In-Reply-To: <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86718>

On Fri, Jun 27, 2008 at 8:08 PM, Robert Anderson <rwa000@gmail.com> wrote:
> If I come back to a branch on which there are several
> commits which have not been pushed yet, how do I know which are
> "temporary" and which are "for real" commits?  I cannot.  It is
> impossible.  The information is not there.

I use the comments for this.  I frequently have comments that say...
"NOT FINISHED, AMEND this".  I make sure they don't get into my public
repo.

You could even automate it with a hook.  You could program your public
repo to refuse a push that contains commits with some keyword like
"WIP", and get used to putting WIP into any new commit until you're
sure about it.  I think you can even program a hook (commit-msg?) to
generate the initial comment for any commit, so you could make it the
default.


> But, all of this is moot when you consider the simple case of a repo
> which has been cloned, on which you'd like to make partial commits,
> and test the committed state before doing so.

You can work in a branch which is not intended to be cloned, and only
merge/rebase to master when you're ready.  You can work in a separate
repo and only push to public when you're ready.  There are several
solutions here for what you want to do.

The answer is simple: you should not be making partial commits to a
repo that has been cloned.  You should instead be working somewhere
else and then pushing to it.  So this whole sentence is just a moot
point itself.


Steve
