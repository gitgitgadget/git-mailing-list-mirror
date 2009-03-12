From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 23:53:41 +0530
Message-ID: <ab9fa62a0903121123v35004215hbb64f0ad65399d9f@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
	 <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
	 <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
	 <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
	 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
	 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
	 <ab9fa62a0903120542s45b1ceebwddab932891c47cf0@mail.gmail.com>
	 <alpine.DEB.1.10.0903121100360.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Mar 12 19:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhpam-0001lP-R1
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 19:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbZCLSXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 14:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbZCLSXs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 14:23:48 -0400
Received: from mail-gx0-f167.google.com ([209.85.217.167]:54187 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbZCLSXr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 14:23:47 -0400
Received: by gxk11 with SMTP id 11so1961853gxk.13
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l/ymdj1tRaATPIEzsEBvNd+GV+lNz04umBHDcKJNhuQ=;
        b=wxafEaPr7MFNd/mwhYpM8Yozofeaypq4RpqVi8JuEup65fdAv0L7Ua+MnKt/WNFzLW
         c3c4CVA5Csh0lCoBuSDwBI50Si1t4L1q+MPgLts6sWkqd/8+TrVXmOx9b+7BAM5LvSe5
         St6v7Wchge5K7nirj3CRCZLg7rq5U53unoeyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XYkz1/LNpfQiQik4rAP9P+2LfqdcneIORxio/M8BRI+hi1udjvbuNIxoqvbwC4uXHx
         iZh4YNwa32XnesCBM6aknoqCOKNPHZB0OF6VbJ1bal1DpEs6M81/S/p3TDaoiuXOOOi8
         U8ZzLxyPOxFT45XLcS7owt9Qwo5EX7gemeWcg=
Received: by 10.231.15.202 with SMTP id l10mr69998iba.35.1236882222052; Thu, 
	12 Mar 2009 11:23:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903121100360.16753@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113100>

On Thu, Mar 12, 2009 at 11:33 PM, <david@lang.hm> wrote:
>
> On Thu, 12 Mar 2009, saurabh gupta wrote:
>
>> hello,
>>
>> On Thu, Mar 12, 2009 at 1:51 AM, =A0<david@lang.hm> wrote:
>>>
>>>> Yes, but the thing is that the underlying codes and method will be
>>>> different for GUI part and terminal part to make it readable and
>>>> understandable. Like for OO Documents, if we aim to show the *diff=
*
>>>> output in the Office tool, then we have to change the xml file
>>>> accordingly. But the same xml file when used with terminal only, t=
he
>>>> *diff* output is not clear.
>>>>
>>>> As Johannes said in above post that for OO documents, while showin=
g
>>>> the *diff* result, no xml data should be shown.
>>>
>>> in part we are talking about different aspects of things, and we we=
re all
>>> wrong.
>>>
>>> see the e-mail a little bit ago by Junio
>>>
>>> there are two types of helpers that can be written
>>>
>>> 1. a low-level part that does the simple merges automaticaly and le=
aves
>>> behind appropriate conflict markers when it can't
>>>
>>> there is no GUI involved with this.
>>>
>>> what 'appropriate conflict markers' are can vary from XML file to X=
ML file
>>>
>>>
>>> 2. after a conflict has taken place, a helper to work with the user=
 to
>>> resolve the conflict
>>>
>>> this can have a GUI and/or a text UI and is tied to the 'appropriat=
e
>>> conflict markers' as defined in #1, and can be _very_ tightly coupl=
ed to the
>>> specific use of the XML file.
>>>
>>> I think it's very important to have a text UI tool that can be used=
 for the
>>> conflict resolution step as well as supporting GUI tools.
>>
>> All right. What I can understand from the current situation is that
>> for merging and marking conflicts in xml (for example) files has
>> following things to do.
>>
>> One, if the markers are put in the xml files like that of a text fil=
e,
>> one can see the difference using a text editor or a terminal. But if
>> the same xml file is to be opened in another editor which expects a
>> valid xml (as clearly mentioned on the wiki ideas for GIT), then a
>> merge helper is needed.
>>
>> But if the conflict markers are put in a way to make the xml file
>> still valid which can be then opened in the appropriate editor, then
>> the marking will be different. The merge driver has to produce the
>> conflicted merged file in a manner which is still a valid xml file a=
nd
>> user has the choice to open it in his own editor to resolve the
>> conflicts.
>
> exactly. and how you mark the conflict to have it be valid XML is goi=
ng to depend on details of the type of file. there are probably a few b=
asic methods that will work the vast majority of the time, but with som=
e details needing to be configurable.
>
> for example, if the XML document is a ODF document, it may be possibl=
e to add 'revision' tags around the conflict that are already understoo=
d by the editor.

Exactly. This includes the work to modify the xml tags and add
contents to represent marker in the best way.


--
Saurabh Gupta
Senior,
NSIT,New Delhi, India
