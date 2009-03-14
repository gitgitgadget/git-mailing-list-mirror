From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] test-lib: write test results to test-results/<basename>-<pid>
Date: Sat, 14 Mar 2009 14:16:57 +0100
Message-ID: <fabb9a1e0903140616q3770f89axff84755abb1f47c7@mail.gmail.com>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
	 <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
	 <20090313172002.GA16232@neumann>
	 <alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de>
	 <20090314121617.GJ6808@neumann>
	 <alpine.DEB.1.00.0903141321550.10279@pacific.mpi-cbg.de>
	 <20090314122833.GK6808@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Mar 14 14:18:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiTlJ-0008CI-Sd
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 14:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbZCNNRE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 09:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbZCNNRD
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 09:17:03 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:45732 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZCNNRB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 09:17:01 -0400
Received: by fxm24 with SMTP id 24so2943391fxm.37
        for <git@vger.kernel.org>; Sat, 14 Mar 2009 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VzSlWvWUzJMeKsxEnA7SFhEqBxLCzEq0IkXLUWSk/Qo=;
        b=UjRsUlxQOlhoILKtJzVIApdpZjA80O0SPIriCvGE9CorCu1mu14kixtwADTapAeeOV
         oX+KIvLp4qAuYshqbrpX86dOfn5GoBRXOO7X9NlipAIjoE9IJ8Sr28ZDCfXFvmAA7uvt
         VtkAIEpEFzVwHkwLHZnERTC0zai28515IVsG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WbPzn+MlFYYODWHb1z8SmdbwJqOyl3wXwQ8li0qn2qC/OVIx8L6rK2i0uZBD7/RmxL
         GSDkwhxMhDaN7aoeAVttNMBJDSh0K+ZSechMFSlqePgxfUBDZvJOeRDYI2X5itnV9Vn3
         lhxP0cctddtHgHpsi+L/6yb0To6sb4BSu5mHM=
Received: by 10.103.248.17 with SMTP id a17mr1174834mus.83.1237036617360; Sat, 
	14 Mar 2009 06:16:57 -0700 (PDT)
In-Reply-To: <20090314122833.GK6808@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113251>

Heya,

On Sat, Mar 14, 2009 at 13:28, SZEDER G=E1bor <szeder@ira.uka.de> wrote=
:
> With my proposed change there would be no need to clean 'test-results=
'
> before running the tests, because test-lib.sh would take care of that
> (not by removing and recreating 'test-results/', but by overwriting
> (IOW: removing and recreating, but in one step) individual test resul=
t
> files).

Wouldn't that result in possible stale files being counted in the
result (e.g., if those tests were not run this time, but they were run
previously)?

--=20
Cheers,

Sverre Rabbelier
