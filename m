From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 14:34:50 -0500
Message-ID: <k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <4BD1EE10.4010009@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 21:35:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Oel-0005CR-Lc
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 21:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263Ab0DWTfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 15:35:13 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:56281 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab0DWTfM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 15:35:12 -0400
Received: by bwz25 with SMTP id 25so11640517bwz.28
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=/UYu6VDDsgiSlTOXR1APwEcxTloW17B9Xc2vkVEg7xQ=;
        b=ECNdfMmJMJVS85UstZudnzjOS43e+8nbs/r16UIdSvvS46Zxnj8UVmpc5T7cW7u0hm
         dwitVuplYwgnPG99lA+QOQ1KjVb3XojpG0Rbco4fH8Ly92C0XLvKd6eG9NOBXUMtyAw0
         JnsyyuyM9MSRE5iRKPv9DqB8iMtLkofCrugB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kUh0VL30lVRvaNtvbTN4V7WZ23X25M8A8jzJ7fHZin65L0K5sNzyiR0AxSc1n8eS7X
         OrfSBQjGDVY5/SSQCeFCz1LWyAxWkDHkUsuzUZIj/Qdkuj6m28MbMhRVxZJB8TZkX0aA
         KzZtobjBf0mjEMLaz2pg1Uw1mtQZ6bJuO95Qc=
Received: by 10.239.190.141 with SMTP id x13mr44380hbh.153.1272051310201; Fri, 
	23 Apr 2010 12:35:10 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Fri, 23 Apr 2010 12:34:50 -0700 (PDT)
In-Reply-To: <4BD1EE10.4010009@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145635>

On Fri, Apr 23, 2010 at 13:59, Matthias Andree <matthias.andree@gmx.de> wrote:
> I'd also concur that "default to commit -a" would be a most undesireable

The proposal was not "default to commit -a" but rather "default to
commit -a when the index has not been explicitly updated with
something like git add".

Just sayin'.
