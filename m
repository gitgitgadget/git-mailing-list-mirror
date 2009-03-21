From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Sat, 21 Mar 2009 23:08:44 +0530
Message-ID: <ab9fa62a0903211038x47afc54ek7c3eba2e06458ddd@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
	 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com>
	 <alpine.DEB.1.00.0903200034230.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0903191652500.16753@asgard.lang.hm>
	 <alpine.DEB.1.00.0903200128020.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0903191948050.4560@asgard.lang.hm>
	 <alpine.DEB.1.00.0903201033310.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0903201337060.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Mar 21 18:40:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll5BD-0005El-VE
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 18:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbZCURis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 13:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbZCURir
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 13:38:47 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:55170 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbZCURir (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 13:38:47 -0400
Received: by an-out-0708.google.com with SMTP id d14so1144404and.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ALKOWergeM8+qE2yQ4PSonJLRfOlyZhr/dv81p7D9Rw=;
        b=mD5Fer29TXW69cBXRfbGz6iBaKwSUwLX7O5LVgjqHxoLecz4MUSA4sUAOCMIt9x1mK
         wq/CI6FxDAYjmbwzJEiPIYdldpV1oe35cJ6kgffv0nLZwZOaTBapriFtMurKDrODk98U
         mkSHTz6K/lO9R1z4D+xSITyILqvVUx2qrWLYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BThIH+8V3Nw1JSy4BGtAZr52PbxDQ8O2sO/HxsdJnsrG549adgD4Xpf2Z62aUW9UVL
         9J0vcP8PLZ+rc0sN04wqLvO4SvGXDH2pKbflph6K/eNfHSh+5Sti6ZXiCp16iSyxMWE+
         gZPyX/diD+zp9E/MR8bjKX93qOK3fkNriujgc=
Received: by 10.231.19.72 with SMTP id z8mr1453728iba.6.1237657124571; Sat, 21 
	Mar 2009 10:38:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903201337060.16753@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114047>

hi,

On Sat, Mar 21, 2009 at 2:20 AM,  <david@lang.hm> wrote:
> On Fri, 20 Mar 2009, Johannes Schindelin wrote:
>
>> On Thu, 19 Mar 2009, david@lang.hm wrote:
>>
>>> On Fri, 20 Mar 2009, Johannes Schindelin wrote:
>>>
>>>> I'd rather have more file types supported that are useful for the
>>>> average user, than a generic XML merge driver that is useful to only a
>>>> handful of people.
>>>
>>> we are both after the same thing,
>>
>> Apparently not...
>>
>>> the most use to the average user.
>>>
>>> you look at SVG, ODF word, ODF spreadsheet, OOXML, etc as completely
>>> seperate things that should have support developed seperatly.
>>
>> No.  I look at SVG, ODF text, ODF spreadsheet, etc as things with
>> completely different user interfaces.
>>
>> And likewise, the merge _helper_, the very thing the user will get to see,
>> must have different user interfaces.
>
> I absolutly agree with this. the UI and merge _helper_ tools for these
> different file formats are completely different.
>
>> And I see much more potential for this project to fail in those different
>> user interfaces than something as _trivial_ (in relation) as XML merging.
>
> and the key thing that I am saying is that a properly done XML merge may
> eliminate the need to do _any_ development of a merge helper tool.

I also think that if xml file merging is done in a proper way and
according to the end-user editor, then it will not be needed to work
on the GUI part. For example, to merge the ODF files, we need to study
the merge conflict structure of Openoffice and will have to modify the
xml file in the same way so that OO can understand it. Similarly for
other file types.

>
> so rather than focusing on what the merge helper tool is going to be and
> what the UI for that is, I am focusing on the potential to eliminate any
> need to hae a specific helper tool by making it so that the marked up files
> can be manipulated with the existing tools for that file type.
>
> David Lang
>



-- 
Saurabh Gupta
Senior,
NSIT,New Delhi, India
