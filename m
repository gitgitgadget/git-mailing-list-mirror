From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 13 Mar 2009 01:15:23 +0530
Message-ID: <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
	 <7veix33f5e.fsf@gitster.siamese.dyndns.org>
	 <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
	 <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
	 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
	 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Mar 12 20:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhqro-0001W8-5q
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbZCLTp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 15:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754410AbZCLTp1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:45:27 -0400
Received: from mail-gx0-f167.google.com ([209.85.217.167]:61795 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbZCLTp0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 15:45:26 -0400
Received: by gxk11 with SMTP id 11so2116089gxk.13
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GWBR90eDqVHT6WvW4k7e2CnqxUuhLIZA/QLN9A13lYg=;
        b=PcGF+qDNZG/+fv2J3Z3gqI0bJvXc93iNV8UQ0/gJfs8XxL7V4oTbYSCFoM3EvthqIN
         JGWl4Gi+9FxGyhfYpBkol1SzfpPofhUoXJ3chR0WjHl5d6uooO4i2xnjvVXdnEYTVGeP
         AbHQIl1O86iCKZdv/S778T8iBwK88ldxfYgZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=abHhZcJ1tSu7gJ/ccFvsSnvnO9cd4hfbLhyEgKi/wfkZxWCQqw7H4+roi234XHZnds
         loYQaYSY1QeIEftUGSvzZPNwG9AVfW6tnmk/lpDUBw6qpkDwyVFFr4S1xs5/fWgTGO3a
         cuveOJwId+7qOKcXY2zSMIw9C2AbNp15W6kOY=
Received: by 10.231.20.2 with SMTP id d2mr90179ibb.37.1236887123995; Thu, 12 
	Mar 2009 12:45:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113117>

On Fri, Mar 13, 2009 at 12:59 AM,  <david@lang.hm> wrote:
> On Fri, 13 Mar 2009, saurabh gupta wrote:
>
> defining terminology that was mentioned before
>
> merge drivers are run by git to do the merges and create the conflict
> markers. git already has a 'plug-in architecture' for these drivers (=
you can
> define file types and tell git to use a particular merge driver for t=
his
> file type)
>
> merge helpers are run by the users if there is a conflict and make us=
e of
> the markers. depending on what you end up using for conflict markers,=
 you
> may not need to write a merge helper (for OO, if your conflict marker=
s are
> good enough you can use OO to resolve conflicts easily, no need for a=
 new
> tool)
>
>
> with this terminology, you can't do merge helpers without doing the m=
erge
> drivers first (what does the helper look for as an indicator of a con=
flict?)
>
> I believe that there is a lot of potential for a configurable merge d=
river
> to support many similar formats.
>
> using the example of XML-based files, configurable options could incl=
ude
>
> 1. is the file stored compressed or not
>
> 2. does the order of the tags matter
>
> 3. does whitespace matter
>
> =A0note: #2 and #3 may boil down to 'is this a document with XML mark=
up, or
> are the XML tags the primary content'
>
> 4. how is the conflict marked
>
> 4a. wrap the conflicting tags in a set of tags that look like _
>
> 4b. if the conflict is in the content, not the tags, modify it simila=
r to
> what we do with text today.
>
> =A0note: this still requires the new driver to decide if there is a c=
onflict
> or not
>
> 4c. other (potentially including calling out to other code for more d=
rastic
> restructuring)
>
>
> with a merge driver along these lines you can handle many different t=
ypes of
> XML documents.
>
> with SVG you may be able to put the offending tags in different layer=
s
>
> with OO you may be able to put in tags that indicate a merge conflict=
 in a
> way that OO will directly handle
>
> etc.
>
> in many cases you may not even need to create a merge helper or libra=
ry for
> other software you use. you just need to figure out what sort of
> manipulation would need to be done to to file to mark the conflict in=
 a way
> that existing applications can understand.

Very well described, David. I agree with you and providing these merge
options to the user, merge drivers can do the work and mark the
conflicts according to the option. The work to do is to modify the
merge driver. I think in this way, even people who have only a
terminal can also gain from it. They can choose the apt option to see
the conflict markers in their way. So, the aim is to make merge driver
configurable and create the merged/conflicted file according to the
options.


--=20
Saurabh Gupta
Senior,
NSIT,New Delhi, India
