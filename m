From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 13:43:08 +0200
Message-ID: <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
	 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 13:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MylIn-0003kB-FP
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 13:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbZJPLnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 07:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbZJPLnr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 07:43:47 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60623 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbZJPLnq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 07:43:46 -0400
Received: by fxm18 with SMTP id 18so2291956fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=NiIUzcU0w1wIgU/+Qu3yHh6T8JuczlCszWWQ56i66gg=;
        b=WqKqzC6/lOeTEuCCd8PKsRy0JmymKa5b/cYLI5YvBxFnUgocA5y0wtsmOXYFp0JP+R
         N2xrk1n0z1w61iV0j+ZmEOjpTPpQNapI6bj+35mIoRDgJZeeZgnbVuwApM9NFQE398Dx
         OCrRO3tqZpY/cdzvVn+2zDGi8C7y9kyoQVns8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H0oMKUhMHGwq20SCd0cXnn9bkOrROKVsjjMojdSkEuIuzZIOjFM1cHBr2doq8llIEW
         IhyyJ3Um8zqoKVAyf1V8LnNsVNqKwzitCrFiEnWmprugwkW4X76OuEuH+DqSR6Ouu4Js
         kDHpNyM4UQuX/flQvTLWuVziVCSiVU4epx41o=
Received: by 10.204.25.5 with SMTP id x5mr1130217bkb.166.1255693388566; Fri, 
	16 Oct 2009 04:43:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130480>

On Fri, Oct 16, 2009 at 1:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Here is the discussion on foundation-l :
>> http://www.gossamer-threads.com/lists/wiki/foundation/181163
>
> I found the link to the bazaar repository there, but do you have a Git
> repository, too?

Not yet. Where should I put it?  Any suggestions.

>> the question is, is there a blame tool that we can use for multiple
>> horizontal diffs on the same line that will be needed for wikipedia
>> articles?
>
> I am not quite sure what you want to do horizontally there... Can you
> explain what you want to see?

Yes, I would like to see all the contributors to each word or line.

Basically one line of blame per contributor, so many lines of output.
Ideally we would have something that is usable in a html display. Lets
say, just an blame attribute for each word. so on one line :

This is a line with two changes first change Second change  end of line

It would look like this in html :
This is a line with two changes <span blame=revisionid>first
change</span><span blame=revisionid>Second change</span> end of line

The blame edit could look like this :
REVISION ID 1    48     :  This is a line with two changes first
change first change \
REVISTION ID 2  48 C:   Second change end of line


let me see if I can find an online example.

Here is a blame tool with links to the edits:
http://hewgill.com/journal/entries/461-wikipedia-blame

here is the wikitrust tool that could be interesting :
http://wikitrust.soe.ucsc.edu/
http://wikitrust.collaborativetrust.com/screenshots

Thanks,
mike
