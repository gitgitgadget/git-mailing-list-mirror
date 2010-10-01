From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: cvs importing a forked project
Date: Fri, 1 Oct 2010 17:53:36 +0000
Message-ID: <AANLkTi=QYHsUq320A3Sb=L4OSVOB2-P5LcpmjK9amjmo@mail.gmail.com>
References: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 19:53:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1jnj-0001uf-4G
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 19:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab0JARxi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 13:53:38 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46964 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab0JARxh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 13:53:37 -0400
Received: by ywh1 with SMTP id 1so1097117ywh.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iXZkNxI4MUpylx+gz6nixWF7+jRDaJSEWEFplDZduSg=;
        b=OAmM7bFgTTH+5unW1X6466Rru0+ccECje6YiWvVrstzXs8ilgb0vqohccxuT+XpVV0
         lMDxhIvOicYKclPkKWs99YWGIRJRyEuXlh5GVt2FwO88maFRT134Eb9I5EkLAo6yz3gt
         iTnDv0GlgnTtBK9qYLkYHh63FEkDm9XZ5lEfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q1jHs/kf16EWQxX514DP4NLyY/uNBKG0C2j307r0HH4CDMvDN42Sm55xyncSuL1g+A
         3b6DizKClsez+hTIMNhy6JFFtFe547zAA6DkR3IuxflAQe9kFXOJt6AS5oJ6VVY+qkOi
         E920AP15TFeNHkIz9Mh40W4YXFwnO/8cxDemU=
Received: by 10.231.11.9 with SMTP id r9mr6059628ibr.47.1285955616582; Fri, 01
 Oct 2010 10:53:36 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 1 Oct 2010 10:53:36 -0700 (PDT)
In-Reply-To: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157769>

On Fri, Oct 1, 2010 at 17:38, Eric Frederich <eric.frederich@gmail.com>=
 wrote:
> I have a project (several actually) where development was done in cvs
> for 10 years. =C2=A0Then, about 5 years ago, a copy of the latest was=
 made
> and development continued in a new project.
> Development in the old project stopped for the most part.
>
> Is there any way where I can combine these two projects in git?
> Basically, take the newer project's first commit and make its parent
> the the last commit of the older project.
> Development was pretty linear.

Sure, you import them both into git with cvs2git (or something like
that), then you fetch all the commits into a single git repository.

Then it becomes a problem of merging two git histories, something
that's widely documented and well understood.
