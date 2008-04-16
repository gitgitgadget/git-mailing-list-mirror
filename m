From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 23:28:49 -0400
Message-ID: <9b3e2dc20804152028s571ea2edm3cdbac7db57e6d8d@mail.gmail.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
	 <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
	 <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com>
	 <7vej97x78v.fsf@gitster.siamese.dyndns.org>
	 <m3abjushvs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Russ Dill" <russ.dill@gmail.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:39:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlyL1-0003zO-4b
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 05:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbYDPD2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 23:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbYDPD2u
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 23:28:50 -0400
Received: from rv-out-0708.google.com ([209.85.198.251]:15564 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753537AbYDPD2t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 23:28:49 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1037826rvb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 20:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5AxazY58v321CrlOh8ZOhI8NneIfVUdnmT8Q8fmpamc=;
        b=S7PD+8SB85iKqz4QJpNcYKA8cRMebrEnCMkBeMip0J8kwOuprFCuZtIBPJhjf5n5dXZW1Np6R2iZVmuXL9vOd74lCmk4q8RmssApyhFSgCYVwXIwwA2iukPIwAYszO2DtzKAqh5VPT3yrGMSo9kr/MTQcefz1O9UhkJg0y4WO98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TGha+Tn8YtfUKIhSoXO6BT6q0S+xAMcPKp4JEn827v1ZPng1/5vADzglPnozFVwVIp8mAcA7Edv+1C/DOSP81JdWP1/nMNXt+KyvkYvmqZzN0cUUBbkWgytYZgmmVu8noGWu9gCkPKkgc2/fyhyTbhSWv4CRpzdFmKAPenOtEiM=
Received: by 10.141.20.7 with SMTP id x7mr4831634rvi.34.1208316529050;
        Tue, 15 Apr 2008 20:28:49 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Tue, 15 Apr 2008 20:28:49 -0700 (PDT)
In-Reply-To: <m3abjushvs.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79654>

On Tue, Apr 15, 2008 at 9:33 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>   (such as branch names in case of Mercurial, or branches
>  descriptions in this case)

This got me thinking...
It's a little crazy, but: since branch descriptions would essentially
just be an extension of the branch name, play basically the same role
and have the same requirements for storage, cloning, etc., what about
using some syntax in the branch name itself to separate a "short name"
and a "long name"..

That is, you could store it as,
refs/heads/wip:work_in_progress

and git-branch would report,

wip

while git-branch --long would report the long names,

wip:work_in_progress

or could parse it to something more legible:

wip     "Work in progress"

Of course this would require modification to refspec-related code,
which is likely more work than it's worth..
Hm, well just an idea anyways.  Probably not a good idea to save
meta-data in a filename.


Steve
