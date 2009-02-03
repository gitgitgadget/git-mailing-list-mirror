From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: cvs2git migration - cloning CVS repository
Date: Tue, 3 Feb 2009 23:54:01 +0100
Message-ID: <46d6db660902031454r1142082cu739a4d6186bc3d2e@mail.gmail.com>
References: <286817520902020624y7f4c2942l34fafc0fe0fa0b48@mail.gmail.com>
	 <49883C52.3060102@alum.mit.edu>
	 <alpine.DEB.1.00.0902031348570.6573@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Rostislav Svoboda <rostislav.svoboda@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 23:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUB3-0005be-Ka
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 23:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZBCWyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 17:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZBCWyG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 17:54:06 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:18339 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbZBCWyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 17:54:04 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1823357fkf.5
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 14:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=13XSM0uyffl+tFkIn9dGFs6fNc5WSHqQK9yTcj0JKWQ=;
        b=E+xyFIRCcVunn0zlneZW/qOzY/N2YLX+faaNJWaH2RsrRGciMJYicGxez3JC9xHaQz
         /7DrMTr9xHoJ8pIkH9DzfKqLN4CKyDQnNUmM5WclGjnU4XyRY05AiBzbPm3MjcM+b4Ws
         YvjHlWqCxqGK4ivKieqy0bv0ni06LKSgpjpdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BmN19ytvldkOnB2tW/P0mmNO+kMjgZcPbEnuPvNk+RlaBFiic1jK97Jw5JrLHAeZpI
         AbExPr/mBUkhfpTbXZnv7y6z9InzyLEnDEl3BivQhHEhMysHfOvhR42niocf9/Mk0NYr
         TWTDWhdVMvpSCv+HyvC5FpOirRfmRXCxSEP3c=
Received: by 10.103.173.5 with SMTP id a5mr2684108mup.57.1233701641349; Tue, 
	03 Feb 2009 14:54:01 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902031348570.6573@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108259>

On Tue, Feb 3, 2009 at 1:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 3 Feb 2009, Michael Haggerty wrote:
>
>> If you do not have filesystem access to your CVS repository, you might
>> be able to clone it using CVSSuck [2,3].
>
> A substantially faster option would be to go with cvsclone:
>
>        http://samba.org/ftp/tridge/rtc/cvsclone.l
>
> (in my case, cvsclone was not only faster, but it actually worked, too,
> which is more than I could say of CVSSuck).
>

fantastic, really! :)
it saves almost half a day of git-cvsimport on vim7 cvs official repository.

Dscho rulez... Kudos...

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
