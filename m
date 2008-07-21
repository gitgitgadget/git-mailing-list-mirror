From: "Eric Raible" <raible@gmail.com>
Subject: Re: making a branch with just one file and keeping its whole history
Date: Mon, 21 Jul 2008 11:22:53 -0700
Message-ID: <279b37b20807211122w3a1e0687wc84693bd95689326@mail.gmail.com>
References: <20080721061804.223f7801@mail.tin.it>
	 <loom.20080721T161926-61@post.gmane.org>
	 <alpine.DEB.1.00.0807211907270.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:23:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL03B-0005Yz-Vn
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYGUSWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbYGUSWz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:22:55 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:53337 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbYGUSWy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:22:54 -0400
Received: by yw-out-2324.google.com with SMTP id 9so572697ywe.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mdwTh2aXGQlkw0l4PhjPc8LowIMOKZFJg+36Cm74WRc=;
        b=PAvlm2KS8m9rVtW6gR80fsD4L9QgJMpGlUm9S9jg+Gy2dlzTDJ6IPK2CKaBQyWz8Uj
         pDhzXCqNLCJLL6mxQaWFacKJY9PsKGr960hdEtPAiRzRZG8VqijMsk22sLjzNejFU1sG
         SwPrUdi4oh9lLBeJnYw3szAfIuH5PkYTrMx+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lucovj6uT2eAoec4nsKDJZaoPh2nFbVror+DWB5FiNxcdpxUM1GJmoCQ/7Xo84Z/DJ
         HIQULwoAQT/u0ukT1jIR9u+CLRIRgTDhWCvnrK0Y6jTPwyzed91Wzp6I1ph23uRS23BG
         RAz1HRL8mEzxMRECIMGrDHVPH1blVrzjcAbwk=
Received: by 10.142.155.4 with SMTP id c4mr1473162wfe.9.1216664573104;
        Mon, 21 Jul 2008 11:22:53 -0700 (PDT)
Received: by 10.142.177.12 with HTTP; Mon, 21 Jul 2008 11:22:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807211907270.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89380>

On Mon, Jul 21, 2008 at 11:08 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 21 Jul 2008, Eric Raible wrote:
>
>> http://www.gitcasts.com/posts/empty-branches
>
> Beware!  This is one of the sites that triggered my mail about considering
> teaching plumbing to new users harmful.
>
> In other words, I think that these "git casts" are not really the best way
> to teach Git to new users, but rather confusing.
>
> Which is a pity, because they are nicely done otherwise.
>
> Ciao,
> Dscho

I understand your concern, but if you treat that particular gitcast
simple as a recipe to be followed it accomplishes the goal in the
in the most straightforward way I've seen.

A new-user pure-porcelain way would be to branch then delete all
of the files in the branch.  Which seems a bit dirty to me.

Or is there some more intuitive porcelain-ish way of creating
a new empty branch that I haven't thought of?

- Eric
