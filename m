From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT PATCH] Add safeguards to Git::userInfo()
Date: Tue, 7 Oct 2008 18:55:26 +0200
Message-ID: <e5bfff550810070955o5ea20e90jf52faf31a0ada013@mail.gmail.com>
References: <48EB10C8.4070009@lyx.org>
	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
	 <48EB49B3.1090509@lyx.org>
	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
	 <48EB5FAF.4080303@lyx.org>
	 <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:57:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnFrW-0001S3-As
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 18:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbYJGQza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 12:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYJGQza
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 12:55:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:21850 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbYJGQz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 12:55:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2868572fkq.5
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+yCOdEGs6IN4gFro1mNg0JnEecPoUqKzDa0mgQJI5eI=;
        b=Q0yBSpC3wDelkkF4z+v9UJEvV7NGluGTaRoi3FOqnVNc0TUfX4IV8nVmdM5MFQaaSy
         kfGrLJiMyVyOixI7MhjoJZoK/GeThlj/CeNon5JgZzUDH/dhUwNoTVP1vlHMUeI6vRty
         tw2ZykfwSAC+edQqSMfntOBsld3/iWQG3O4WA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=o70ZzzbXJ4jQRxc/UuOhrfBQZ3rpAJiICdCZdyrZLLseX8VdRfBFCIxGKhJ1f7BfEN
         JWSPwZmvJWeycgMFaO4f0zRc+5Ed1hhnNZWLaZeuICxSo2wTKld1xSu0OJZGXf4FJqSS
         BhSBT2qpfngJ1zfuGrDrjDCDLsbUFtjMKmXYA=
Received: by 10.180.248.13 with SMTP id v13mr5183022bkh.14.1223398526890;
        Tue, 07 Oct 2008 09:55:26 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 09:55:26 -0700 (PDT)
In-Reply-To: <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97728>

On Tue, Oct 7, 2008 at 6:50 PM, Marco Costalba <mcostalba@gmail.com> wrote:
>
> An empty user and email it does not mean failure. Again, I would think
> that is git config that returns no data (without failing) if it is run
> from outside git directory.
>

Yes ! it is like this, I have finally had the possibility to test.

git config does not returns user and mail if run outside git dir
because user and mail are local set.
