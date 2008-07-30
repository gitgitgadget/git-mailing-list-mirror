From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 17:18:59 +0200
Message-ID: <8aa486160807300818m108920a0pe4a5de47de8d838c@mail.gmail.com>
References: <20080730133859.368bbd92@pc09.procura.nl>
	 <20080730133334.GB31192@lars.home.noschinski.de>
	 <20080730155835.71289eee@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lars Noschinski" <lars-2008-1@usenet.noschinski.de>,
	git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:20:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KODTC-00012A-QS
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbYG3PTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 11:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYG3PTB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:19:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:54772 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYG3PS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 11:18:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so62570rvb.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=d83n/vEKPu3HLe2FlnQ7e/ieKi5QnMqPfp9IUfEbmd4=;
        b=t+XnM2lu+yKFDYIHUTXbeLfI74+XQ5x6QHPtFb8TFgMJLd1SupmMnF+VPXx6NdqZpz
         pr7msZ5b+GjQOkSPOAwL8gilHzRaUKaM3Eh2l9ALhUeW44qrvhW28L/Orj0GO4SS2H7Q
         cUMWKZ1h+2uuwSn8AHM1+ISAXDIyDPIsK9Tbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MlKn/Hovi45VI/PUSQjCCaLG3q85Eyoo8yac2fVTBQXzeB/m4/BE8LRm395sqV4xWn
         TAjV7v7yyqVO0waVHHExTUAw0GLuOBo0/xxYCvUEn8+S9x8U8dpgsI4rVF+UjOGwUxVF
         +Tm9DO986J1tLfTdWXno9lTJYHlge/J/n47GM=
Received: by 10.141.83.15 with SMTP id k15mr4390897rvl.289.1217431139179;
        Wed, 30 Jul 2008 08:18:59 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Wed, 30 Jul 2008 08:18:59 -0700 (PDT)
In-Reply-To: <20080730155835.71289eee@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90802>

On Wed, Jul 30, 2008 at 15:58, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> On Wed, 30 Jul 2008 15:33:34 +0200, Lars Noschinski
> <lars-2008-1@usenet.noschinski.de> wrote:
>
>> * H.Merijn Brand <h.m.brand@xs4all.nl> [08-07-30 13:38]:
>>
>> >     I can ask them what version they have, and I can then check if
>> >     the complaint was already addressed in an update that was
>> >     already released. In SCCS this was easy: they tell me the output
>> >     of the what command, I check if the bug was fixed in a newer
>> >     version and the answer is present. No such luck in git, as the
>> >     stamps are (non-sequitive) SHA id's. As we moved to git, we now
>> >     have to update those id's by hand, as the customers are used to
>> >     it. (At least we can now use readable date formats)
>>
>> Hm, what about "git-describe --contains $SHA_OF_BUGFIX"?
>
> If you come from a SCCS environment, the developers are used to see the
> version of a single file, not of the id of a fix. One of the reasons we
> moved from SCCS to git, is that we now can commit a group of files as a
> single commit, and later look at the complete picture.
>
> We are not used to working with $SHA's, and IMHO from the end-user pov,
> a $SHA is less user friendly than a release number or a file version. I
> can remember a version, but I cannot remember a SHA.

>
> The end user only has the application, which is (or at least should be)
> able to spit out its release version.

As git itself does:

$ git version
git version 1.6.0.rc1.11.g1ce47

I think it is far better to know the version of the entire project,
than the version of a single file.

>  That is all we can go by when we
> dig back into the history to see where we changed things.
>
> One (very) big disadvantage of  SCCS  is that commits are on a per-file
> basis, and only in a single directory. This drawback still haunts me in
> git, as my first attempts to convert were successful in a single folder
> and git cannot merge folders into a single project.
>
> Say I now have
>
> /work/src/project/.git
> /work/src/project/module_a/.git
> /work/src/project/module_b/.git
> /work/src/project/module_c/.git
>
> Which are all converted repos from SCCS, I'd like to merge the three
> module_# repos into the top level repo.

You have, basically, two possibilities:

1) Add the module_# as submodules:
  http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html
  http://git.or.cz/gitwiki/GitSubmoduleTutorial
2) Add the submodules as subtrees (as gitk and git-gui in git.git)
  http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html

Santi
